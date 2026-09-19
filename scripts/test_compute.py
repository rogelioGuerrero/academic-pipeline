"""Tests deterministas de compute.py — respuestas conocidas.

Si estas pruebas fallan, el pipeline publica cifras incorrectas con total
confianza: el verificador solo compara el texto contra los resultados, no
detecta bugs en quien los produce. Corre en CI antes de publicar.

Uso: python -m pytest scripts/test_compute.py -v
"""
import json
import os
import subprocess
import sys

import numpy as np
import pytest

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import compute

YEARS = list(range(2015, 2025))


def var(name, values, unit="%", country="", country_code=""):
    return {"name": name, "label": name, "years": YEARS[:len(values)],
            "values": values, "unit": unit, "country": country,
            "country_code": country_code}


# ── Benjamini-Hochberg ──────────────────────────────────────────────────────

def test_bh_qvalues_known():
    p = [0.001, 0.01, 0.04, 0.20, 0.50]
    q = compute._bh_qvalues(p)
    assert q == pytest.approx([0.005, 0.025, 0.0667, 0.25, 0.5], abs=1e-3)


def test_bh_qvalues_monotonic_and_bounded():
    q = compute._bh_qvalues([0.5, 0.03, 0.9, 0.001, 0.2])
    assert all(0 <= v <= 1 for v in q)
    # q >= p siempre (BH nunca "mejora" un p-valor)
    for p, qq in zip([0.5, 0.03, 0.9, 0.001, 0.2], q):
        assert qq >= p - 1e-12
    # todos iguales -> q = p
    assert compute._bh_qvalues([0.07, 0.07, 0.07]) == pytest.approx([0.07] * 3)


# ── Alineacion y guardias ────────────────────────────────────────────────────

def test_align_by_years_intersects_and_drops_none():
    a = var("a", [1, None, 3, 4, 5])
    a["years"] = [2015, 2016, 2017, 2018, 2019]
    b = var("b", [10, 20, 30, 40, 50])
    b["years"] = [2016, 2017, 2018, 2019, 2020]
    x, y, yrs = compute._align_by_years(a, b)
    # comun: 2016-2019, pero a[2016] es None -> 2017,2018,2019
    # b mapea por anio: 2017->20, 2018->30, 2019->40
    assert yrs == [2017, 2018, 2019]
    assert x == [3, 4, 5] and y == [20, 30, 40]


def test_align_by_years_insufficient():
    a = var("a", [1, 2]); a["years"] = [2015, 2016]
    b = var("b", [9, 9]); b["years"] = [2020, 2021]
    x, y, yrs = compute._align_by_years(a, b)
    assert x == [] and y == [] and yrs == []


def test_units_compatible():
    assert compute._units_compatible("%", "%") is True
    assert compute._units_compatible("%", "USD") is True
    assert compute._units_compatible("score", "count") is False


# ── Correlaciones ───────────────────────────────────────────────────────────

def _corr_data(pairs_vars, pairs):
    return {"variables": pairs_vars, "correlations": pairs}


def test_correlation_perfect_positive_and_negative():
    xs = [float(i) for i in range(10)]
    data = _corr_data(
        [var("x", xs), var("up", [2 * v + 1 for v in xs]), var("down", [100 - 3 * v for v in xs])],
        [["x", "up"], ["x", "down"]])
    res = {f"{c['x']}|{c['y']}": c for c in compute.correlation_analysis(data)}
    assert res["x|up"]["pearson_r"] == pytest.approx(1.0, abs=1e-9)
    assert res["x|down"]["pearson_r"] == pytest.approx(-1.0, abs=1e-9)
    assert res["x|up"]["n"] == 10


def test_correlation_guards():
    xa = var("xa", [float(i) for i in range(10)], country_code="BRA")
    xb = var("xb", [float(i) for i in range(10)], country_code="MEX")
    xc = var("xc", [float(i) for i in range(10)], unit="score")
    short = var("short", [1.0, 2.0])
    data = _corr_data([xa, xb, xc, short],
                      [["xa", "xb"], ["xa", "xc"], ["xa", "short"]])
    res = compute.correlation_analysis(data)
    assert "country mismatch" in res[0]["error"]
    assert "incompatible units" in res[1]["error"]
    assert res[2]["error"] == "insufficient paired data"


def test_correlation_diff_fields_present():
    xs = [float(i) for i in range(10)]
    data = _corr_data([var("x", xs), var("y", [v + 0.5 for v in xs])], [["x", "y"]])
    c = compute.correlation_analysis(data)[0]
    assert "diff_pearson_r" in c and "diff_n" in c and "diff_significant" in c


def test_correlation_fdr_demotes_marginal_p():
    """Un p marginal (~0.04) en una familia de 6 tests debe quedar
    significant=True pero significant_fdr=False: es exactamente el falso
    positivo que FDR existe para cazar."""
    y = np.arange(10, dtype=float)
    y_s = (y - y.mean()) / y.std()
    z = np.array([1, -1, 1, -1, 1, -1, 1, -1, 1, -1], dtype=float)
    z_s = (z - z.mean()) / z.std()
    z_s = z_s - y_s * (z_s @ y_s) / (y_s @ y_s)   # decorrela z de y
    z_s = z_s / np.linalg.norm(z_s) * np.linalg.norm(y_s)
    r_t = 0.66                                    # r ~0.66, n=10 -> p ~0.038
    x_marg = (r_t * y_s + np.sqrt(1 - r_t ** 2) * z_s) * 3 + 20
    variables = [var("y", list(y)), var("marg", list(x_marg))]
    pairs = [["y", "marg"]]
    for i in range(5):                            # 5 pares con r ~0 -> p altos
        zi = np.roll(z_s, i + 1)
        variables.append(var(f"noise{i}", list(zi * 5 + 50)))
        pairs.append(["y", f"noise{i}"])
    res = compute.correlation_analysis({"variables": variables, "correlations": pairs})
    marg = next(c for c in res if c["y"] == "marg")
    assert marg["pearson_p"] < 0.05
    assert marg["significant"] is True
    assert marg["significant_fdr"] is False
    assert marg["pearson_q"] >= marg["pearson_p"]
    assert all("pearson_q" in c for c in res)


# ── Regresion OLS ────────────────────────────────────────────────────────────

def test_ols_exact_fit():
    xs = [float(i) for i in range(10)]
    data = {"variables": [var("y", [3 + 2 * v for v in xs]), var("x", xs)],
            "regression": {"dependent": "y", "independent": ["x"]}}
    out = compute.ols_regression(data)
    coef = {c["name"]: c for c in out["coefficients"]}
    assert coef["x"]["beta"] == pytest.approx(2.0, abs=1e-6)
    assert coef["intercept"]["beta"] == pytest.approx(3.0, abs=1e-6)
    assert out["r_squared"] == pytest.approx(1.0, abs=1e-6)
    assert out["n"] == 10 and out["dof"] == 8


def test_ols_regressor_cap():
    """5 regresores con n=10: max_k = (10-2)//4 = 2 -> quedan los 2 primeros
    en el orden de la spec y los otros 3 se declaran excluidos."""
    variables = [var("y", [float(2 * i) + 1 for i in range(10)])]
    variables += [var(f"x{j}", [float(i) + j * 0.5 for i in range(10)]) for j in range(5)]
    data = {"variables": variables,
            "regression": {"dependent": "y", "independent": [f"x{j}" for j in range(5)]}}
    out = compute.ols_regression(data)
    assert out["independent"] == ["x0", "x1"]
    assert out["dropped_regressors"] == ["x2", "x3", "x4"]
    assert out["dof"] == 7


def test_ols_errors():
    data = {"variables": [var("y", [1, 2, 3])],
            "regression": {"dependent": "y", "independent": ["nope"]}}
    assert "not found" in compute.ols_regression(data)["error"]
    data2 = {"variables": [var("y", [1, 2]), var("x", [1, 2])],
             "regression": {"dependent": "y", "independent": ["x"]}}
    assert "insufficient" in compute.ols_regression(data2)["error"]


def test_panel_exact_fit():
    """Panel FE por pais: y = offset_pais + 2x. Los efectos fijos deben
    absorber el offset y recuperar beta ~ 2."""
    variables = []
    for ci, cc in enumerate(["BRA", "MEX", "COL", "ARG"]):
        xs = [float(i) for i in range(10)]
        ys = [ci * 10 + 2 * v + 1 for v in xs]
        variables.append(var(f"dep [{cc}]", ys, country_code=cc))
        variables.append(var(f"ind [{cc}]", xs, country_code=cc))
    out = compute.panel_regression({"variables": variables,
                                    "panel": {"dependent": "dep", "independent": ["ind"]}})
    coef = next(c for c in out["coefficients"] if c["name"] != "intercept" and not c["name"].startswith("FE_"))
    assert coef["beta"] == pytest.approx(2.0, abs=1e-6)
    assert out["n_countries"] == 4 and out["n"] == 40


# ── Tendencias, anomalias, derivados, descriptivas ───────────────────────────

def test_trend_increasing_and_flat():
    data = {"variables": [var("up", [10.0 + i for i in range(10)]),
                          var("flat", [5.0] * 10)]}
    res = {t["indicator"]: t for t in compute.trend_analysis(data)}
    assert res["up"]["trend"] == "increasing"
    assert res["up"]["mann_kendall_p"] < 0.05
    assert res["up"]["slope"] == pytest.approx(1.0)
    assert res["flat"]["trend"] == "no_trend"


def test_anomaly_detection_outlier():
    vals = [10.0] * 9 + [50.0]
    res = compute.anomaly_detection({"variables": [var("a", vals)]})
    assert any(r["value"] == 50.0 and r["year"] == 2024 and r["type"] in ("high_z", "iqr_high") for r in res)


def test_derived_stats_known():
    out = compute.derived_stats({"variables": [var("s", [10.0 + i for i in range(10)])]})["s"]
    assert out["first_year"] == 2015 and out["last_year"] == 2024
    assert out["delta_total"] == pytest.approx(9.0)
    assert out["avg_annual_change"] == pytest.approx(1.0)
    assert out["pct_change_total"] == pytest.approx(90.0)
    assert out["cagr"] == pytest.approx((1.9 ** (1 / 9) - 1) * 100)
    assert out["min_year"] == 2015 and out["max_year"] == 2024


def test_descriptive_stats_known():
    out = compute.descriptive_stats({"variables": [var("s", [1.0, 2.0, 3.0, 4.0, 5.0])]})["s"]
    assert out["n"] == 5 and out["mean"] == pytest.approx(3.0)
    assert out["median"] == pytest.approx(3.0)
    assert out["std"] == pytest.approx(np.std([1, 2, 3, 4, 5], ddof=1))
    assert out["min"] == 1.0 and out["max"] == 5.0


# ── Tablas Markdown ──────────────────────────────────────────────────────────

def test_tables_fdr_and_dropped_note():
    xs = [float(i) for i in range(10)]
    variables = [var("y", [3 + 2 * v for v in xs])]
    variables += [var(f"x{j}", [float(i) + j * 0.5 for i in range(10)]) for j in range(5)]
    data = {"variables": variables,
            "regression": {"dependent": "y", "independent": [f"x{j}" for j in range(5)]},
            "correlations": [["y", "x0"]]}
    results = {"correlations": compute.correlation_analysis(data),
               "regression": compute.ols_regression(data),
               "panel": None, "derived": compute.derived_stats(data),
               "descriptive": compute.descriptive_stats(data),
               "trends": [], "anomalies": []}
    tables = compute.generate_markdown_tables(data, results)
    assert "q (FDR)" in tables["correlations"]
    assert "Regresores excluidos" in tables["regression"]
    assert "dof" in tables["regression"]
    assert "derived" in tables and "descriptive" in tables


# ── Smoke end-to-end del CLI ─────────────────────────────────────────────────

def test_main_smoke(tmp_path):
    data = {"variables": [var("y", [3 + 2 * i for i in range(10)]),
                          var("x", [float(i) for i in range(10)])],
            "regression": {"dependent": "y", "independent": ["x"]},
            "correlations": [["y", "x"]]}
    inp = tmp_path / "input.json"
    inp.write_text(json.dumps(data), encoding="utf-8")
    proc = subprocess.run([sys.executable, os.path.join(os.path.dirname(__file__), "compute.py"), str(inp)],
                          capture_output=True, timeout=120)
    assert proc.returncode == 0, proc.stderr.decode("utf-8", "replace")[:500]
    out = json.loads(proc.stdout.decode("utf-8"))
    for key in ("descriptive", "correlations", "regression", "panel",
                "clustering", "anomalies", "trends", "derived", "tables", "charts"):
        assert key in out
    assert out["regression"]["r_squared"] == pytest.approx(1.0, abs=1e-6)


if __name__ == "__main__":
    sys.exit(pytest.main([os.path.abspath(__file__), "-v"]))
