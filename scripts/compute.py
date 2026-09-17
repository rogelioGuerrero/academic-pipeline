"""
compute.py - Análisis estadístico real para AcademicPipeline
Recibe un JSON con datos estructurados, ejecuta análisis reales, devuelve resultados.

Uso: python scripts/compute.py input.json > output.json

Input JSON format:
{
  "variables": [
    {"name": "desempleo_juvenil", "label": "Tasa de desempleo juvenil (%)", "values": [22.1, 27.0, 24.0, ...]},
    {"name": "inversion_ia", "label": "Inversión en IA (USD per cápita)", "values": [15, 18, 22, ...]},
    {"name": "competencias_digitales", "label": "Competencias digitales avanzadas (%)", "values": [28, 31, 35, ...]},
    {"name": "variacion_empleo", "label": "Variación % empleo juvenil", "values": [-2.3, 1.2, 1.4, ...]}
  ],
  "regression": {
    "dependent": "variacion_empleo",
    "independent": ["desempleo_juvenil", "inversion_ia", "competencias_digitales"]
  },
  "correlations": [
    ["desempleo_juvenil", "variacion_empleo"],
    ["inversion_ia", "variacion_empleo"],
    ["competencias_digitales", "variacion_empleo"]
  ]
}
"""

import sys
import json
import warnings
warnings.filterwarnings("ignore")

def load_input(path):
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)

def _get_variables(data):
    """Normalize input: accept both 'variables' (old) and 'series' (new) formats."""
    variables = []
    if "variables" in data:
        for v in data["variables"]:
            variables.append({"name": v["name"], "label": v.get("label", v["name"]), "values": v.get("values", []), "years": v.get("years", []), "unit": v.get("unit", "unknown"), "country": v.get("country", ""), "country_code": v.get("country_code", "")})
    if "series" in data:
        for s in data["series"]:
            variables.append({"name": s["name"], "label": s.get("label", s["name"]), "values": s.get("values", []), "years": s.get("years", []), "unit": s.get("unit", "unknown"), "country": s.get("country", ""), "country_code": s.get("country_code", "")})
    return variables

# Unit compatibility matrix: which units can be correlated together.
# Pearson r es invariante a escala, pero el guardia evita pares sin sentido semantico.
UNIT_COMPAT = {
    ("%", "%"): True,
    ("%", "index"): True,   # Gini index vs % is semantically comparable
    ("%", "USD"): True,     # % vs USD: correlation is scale-invariant (Pearson r)
    ("USD", "USD"): True,
    ("count", "count"): True,
    ("count", "USD"): True,    # net migration vs remittances / GDP
    ("count", "%"): True,      # net migration vs unemployment %
    ("per100", "per100"): True,
    ("per100", "%"): True,   # per100 and % are comparable (both rates)
    ("per100", "USD"): True,   # mobile subs vs GDP per capita
    ("score", "score"): True,  # PISA scores
    ("score", "USD"): True,    # PISA score vs GDP per capita
    ("score", "%"): True,      # PISA score vs % indicators
    ("score", "index"): True,  # PISA score vs Gini index
    ("years", "%"): True,      # life expectancy vs rates
    ("years", "USD"): True,    # life expectancy vs GDP per capita
    ("years", "count"): True,  # life expectancy vs population
    ("t", "%"): True,          # CO2 per capita vs rates
    ("t", "USD"): True,        # CO2 per capita vs GDP per capita
    ("kWh", "%"): True,        # power consumption vs rates
    ("kWh", "USD"): True,      # power consumption vs GDP per capita
}

def _units_compatible(unit_a, unit_b):
    """Check if two units can be meaningfully correlated."""
    if unit_a == unit_b:
        return True
    key = tuple(sorted([unit_a, unit_b]))
    return UNIT_COMPAT.get(key, False)

def descriptive_stats(data):
    import numpy as np
    results = {}
    for var in _get_variables(data):
        name = var["name"]
        values = var.get("values", [])
        if not values or len(values) < 2:
            results[name] = {"error": "insufficient data", "n": len(values)}
            continue
        arr = np.array(values, dtype=float)
        results[name] = {
            "label": var.get("label", name),
            "country": var.get("country", ""),
            "n": int(len(arr)),
            "mean": float(np.mean(arr)),
            "median": float(np.median(arr)),
            "std": float(np.std(arr, ddof=1)) if len(arr) > 1 else 0.0,
            "min": float(np.min(arr)),
            "max": float(np.max(arr)),
        }
    return results

def _align_by_years(var_a, var_b):
    """Align two variables by their years, returning paired arrays."""
    years_a = var_a.get("years", [])
    years_b = var_b.get("years", [])
    vals_a = var_a.get("values", [])
    vals_b = var_b.get("values", [])
    if not years_a or not years_b:
        min_len = min(len(vals_a), len(vals_b))
        return vals_a[:min_len], vals_b[:min_len], []
    map_a = {y: v for y, v in zip(years_a, vals_a) if v is not None}
    map_b = {y: v for y, v in zip(years_b, vals_b) if v is not None}
    common = sorted(set(map_a.keys()) & set(map_b.keys()))
    if len(common) < 3:
        return [], [], []
    return [map_a[y] for y in common], [map_b[y] for y in common], common

def correlation_analysis(data):
    import numpy as np
    from scipy import stats
    results = []
    variables = _get_variables(data)
    var_map = {v["name"]: v for v in variables}
    for pair in data.get("correlations", []):
        if len(pair) != 2:
            continue
        x_name, y_name = pair
        va = var_map.get(x_name)
        vb = var_map.get(y_name)
        if not va or not vb:
            results.append({"x": x_name, "y": y_name, "error": "variable not found"})
            continue
        # ── Guard: same country only ──
        ca = va.get("country_code", "")
        cb = vb.get("country_code", "")
        if ca and cb and ca != cb:
            results.append({"x": x_name, "y": y_name, "error": f"country mismatch: {ca} vs {cb}"})
            continue
        # ── Guard: compatible units ──
        ua = va.get("unit", "unknown")
        ub = vb.get("unit", "unknown")
        if not _units_compatible(ua, ub):
            results.append({"x": x_name, "y": y_name, "error": f"incompatible units: {ua} vs {ub}"})
            continue
        x_vals, y_vals, years = _align_by_years(va, vb)
        if len(x_vals) < 3:
            results.append({"x": x_name, "y": y_name, "error": "insufficient paired data"})
            continue
        x_arr = np.array(x_vals, dtype=float)
        y_arr = np.array(y_vals, dtype=float)
        r, p_value = stats.pearsonr(x_arr, y_arr)
        # Spearman rank correlation (robust to outliers, non-linear monotonic)
        rho, p_spearman = stats.spearmanr(x_arr, y_arr)
        # 95% CI for Pearson r via Fisher z-transform
        if abs(r) < 1:
            z = np.arctanh(r)
            se_z = 1.0 / np.sqrt(len(x_arr) - 3)
            z_lo = z - 1.96 * se_z
            z_hi = z + 1.96 * se_z
            ci_lo = float(np.tanh(z_lo))
            ci_hi = float(np.tanh(z_hi))
        else:
            ci_lo = ci_hi = float(r)
        result = {
            "x": x_name,
            "y": y_name,
            "pearson_r": float(r),
            "pearson_p": float(p_value),
            "pearson_ci_95": [ci_lo, ci_hi],
            "spearman_rho": float(rho),
            "spearman_p": float(p_spearman),
            "significant": bool(p_value < 0.05),
            "n": int(len(x_arr)),
            "years": years,
            "units": f"{ua} vs {ub}",
        }
        # ── First-difference correlation: distinguishes real co-movement
        # from spurious co-trending. Two series that both trend upward always
        # correlate in levels; only diff correlation shows whether year-to-year
        # changes actually move together. Only diff between consecutive years. ──
        if years:
            dx, dy = [], []
            for i in range(1, len(years)):
                if years[i] - years[i - 1] == 1:
                    dx.append(x_arr[i] - x_arr[i - 1])
                    dy.append(y_arr[i] - y_arr[i - 1])
            if len(dx) >= 4:
                r_d, p_d = stats.pearsonr(np.array(dx), np.array(dy))
                result["diff_pearson_r"] = float(r_d)
                result["diff_pearson_p"] = float(p_d)
                result["diff_n"] = len(dx)
                result["diff_significant"] = bool(p_d < 0.05)
        results.append(result)
    return results

def ols_regression(data):
    import numpy as np
    from scipy import stats
    reg_spec = data.get("regression")
    if not reg_spec:
        return None
    dep_name = reg_spec["dependent"]
    indep_names = reg_spec["independent"]
    variables = _get_variables(data)
    var_map = {v["name"]: v for v in variables}
    dep_var = var_map.get(dep_name)
    if not dep_var:
        return {"error": f"dependent variable '{dep_name}' not found"}
    indep_vars = [var_map.get(n) for n in indep_names]
    if not all(indep_vars):
        missing = [n for n, v in zip(indep_names, indep_vars) if not v]
        return {"error": f"independent variables not found: {missing}"}
    # Align all by years
    all_vars = [dep_var] + indep_vars
    all_years = [v.get("years", []) for v in all_vars]
    if all(all_years):
        year_sets = [set(y for y, v in zip(yrs, vals) if v is not None) for yrs, vals in zip(all_years, [v.get("values", []) for v in all_vars])]
        common = sorted(set.intersection(*year_sets)) if year_sets else []
        if len(common) < len(indep_names) + 2:
            return {"error": f"insufficient common years (n={len(common)}, need {len(indep_names)+2})", "dependent": dep_name}
        y_arr = np.array([next(v for y, v in zip(dep_var["years"], dep_var["values"]) if y == yr) for yr in common], dtype=float)
        X_cols = []
        for iv in indep_vars:
            col = [next(v for y, v in zip(iv["years"], iv["values"]) if y == yr) for yr in common]
            X_cols.append(np.array(col, dtype=float))
        X_arr = np.column_stack(X_cols)
        n = len(common)
    else:
        y = dep_var.get("values", [])
        X_raw = [v.get("values", []) for v in indep_vars]
        min_len = min(len(y), *[len(x) for x in X_raw])
        if min_len < len(indep_names) + 2:
            return {"error": f"insufficient observations (n={min_len}, need {len(indep_names)+2})", "dependent": dep_name}
        y_arr = np.array(y[:min_len], dtype=float)
        X_arr = np.column_stack([np.array(x[:min_len], dtype=float) for x in X_raw])
        n = min_len
    k = len(indep_names)
    # OLS: beta = (X'X)^-1 X'y
    X_with_const = np.column_stack([np.ones(n), X_arr])
    try:
        beta = np.linalg.lstsq(X_with_const, y_arr, rcond=None)[0]
    except np.linalg.LinAlgError:
        return {"error": "singular matrix (multicollinearity)"}
    y_pred = X_with_const @ beta
    residuals = y_arr - y_pred
    ss_res = float(np.sum(residuals ** 2))
    ss_tot = float(np.sum((y_arr - np.mean(y_arr)) ** 2))
    r_squared = 1 - ss_res / ss_tot if ss_tot > 0 else 0.0
    adj_r_squared = 1 - (1 - r_squared) * (n - 1) / (n - k - 1) if n - k - 1 > 0 else 0.0
    # Standard errors
    dof = n - k - 1
    if dof > 0:
        sigma2 = ss_res / dof
        try:
            cov_matrix = sigma2 * np.linalg.inv(X_with_const.T @ X_with_const)
            se = np.sqrt(np.diag(cov_matrix))
            t_stats = beta / se
            p_values = 2 * (1 - stats.t.cdf(np.abs(t_stats), dof))
        except np.linalg.LinAlgError:
            se = np.full(k + 1, float("nan"))
            t_stats = np.full(k + 1, float("nan"))
            p_values = np.full(k + 1, float("nan"))
    else:
        se = np.full(k + 1, float("nan"))
        t_stats = np.full(k + 1, float("nan"))
        p_values = np.full(k + 1, float("nan"))
    # F-statistic
    if dof > 0 and k > 0:
        f_stat = (ss_tot - ss_res) / k / (ss_res / dof)
        f_p_value = 1 - stats.f.cdf(f_stat, k, dof)
    else:
        f_stat = float("nan")
        f_p_value = float("nan")
    # ── VIF (Variance Inflation Factor) for multicollinearity ──
    vif = {}
    if k > 1 and n > k + 1:
        for i, name in enumerate(indep_names):
            others = [j for j in range(k) if j != i]
            if others:
                X_others = np.column_stack([np.ones(n), X_arr[:, others]])
                try:
                    beta_vif = np.linalg.lstsq(X_others, X_arr[:, i], rcond=None)[0]
                    y_pred_vif = X_others @ beta_vif
                    ss_res_vif = float(np.sum((X_arr[:, i] - y_pred_vif) ** 2))
                    ss_tot_vif = float(np.sum((X_arr[:, i] - np.mean(X_arr[:, i])) ** 2))
                    r2_vif = 1 - ss_res_vif / ss_tot_vif if ss_tot_vif > 0 else 0.0
                    vif[name] = float(1.0 / (1.0 - r2_vif)) if r2_vif < 1.0 else float("inf")
                except Exception:
                    vif[name] = float("nan")
    # ── White test for heteroscedasticity ──
    white_test = None
    if dof > 0 and k >= 1:
        try:
            # Aux regression: residuals^2 on original regressors + squares + cross-products
            aux_cols = [np.ones(n)]
            aux_names = ["const"]
            for i in range(k):
                aux_cols.append(X_arr[:, i])
                aux_names.append(indep_names[i])
                aux_cols.append(X_arr[:, i] ** 2)
                aux_names.append(f"{indep_names[i]}^2")
            for i in range(k):
                for j in range(i + 1, k):
                    aux_cols.append(X_arr[:, i] * X_arr[:, j])
                    aux_names.append(f"{indep_names[i]}*{indep_names[j]}")
            X_aux = np.column_stack(aux_cols)
            n_aux = X_aux.shape[1]
            if n > n_aux + 1:
                resid2 = residuals ** 2
                beta_aux = np.linalg.lstsq(X_aux, resid2, rcond=None)[0]
                resid2_pred = X_aux @ beta_aux
                ss_res_aux = float(np.sum((resid2 - resid2_pred) ** 2))
                ss_tot_aux = float(np.sum((resid2 - np.mean(resid2)) ** 2))
                r2_aux = 1 - ss_res_aux / ss_tot_aux if ss_tot_aux > 0 else 0.0
                lm_stat = n * r2_aux
                lm_p = 1 - stats.chi2.cdf(lm_stat, n_aux - 1)
                white_test = {"lm_stat": float(lm_stat), "p_value": float(lm_p), "heteroscedastic": bool(lm_p < 0.05)}
        except Exception:
            white_test = None
    # ── Robust standard errors (HC3) ──
    robust_se = None
    if dof > 0:
        try:
            XtX_inv = np.linalg.inv(X_with_const.T @ X_with_const)
            # HC3: weights = (1 - h_ii)^2 where h_ii = leverage
            H = X_with_const @ XtX_inv @ X_with_const.T
            leverages = np.diag(H)
            weights = (1 - leverages) ** 2
            weights = np.where(weights > 0, weights, 1e-10)
            meat = X_with_const.T @ np.diag(weights * residuals ** 2) @ X_with_const
            cov_robust = XtX_inv @ meat @ XtX_inv
            robust_se = np.sqrt(np.maximum(np.diag(cov_robust), 0))
            robust_t = beta / robust_se
            robust_p = 2 * (1 - stats.t.cdf(np.abs(robust_t), dof))
        except Exception:
            robust_se = None
    # ── Bootstrap de coeficientes (case resampling, B=2000) ──
    # Con n pequeno el p-value parametrico asume errores normales — supuesto
    # inverificable. El bootstrap construye el IC95% desde la distribucion
    # empirica: remuestrea las observaciones con reemplazo y re-ajusta.
    boot_ci = None
    boot_frac_zero = None
    boot_hists = None
    if dof > 0:
        try:
            rng = np.random.default_rng(42)
            B = 2000
            boot_betas = []
            for _ in range(B):
                idx = rng.integers(0, n, n)
                # Evitar muestras degeneradas (todas las X constantes)
                if np.unique(X_arr[idx], axis=0).shape[0] <= k:
                    continue
                try:
                    b = np.linalg.lstsq(X_with_const[idx], y_arr[idx], rcond=None)[0]
                    if np.all(np.isfinite(b)):
                        boot_betas.append(b)
                except np.linalg.LinAlgError:
                    continue
            if len(boot_betas) >= 500:
                bb = np.array(boot_betas)  # (B_ok, k+1)
                lo = np.percentile(bb, 2.5, axis=0)
                hi = np.percentile(bb, 97.5, axis=0)
                boot_ci = np.column_stack([lo, hi])  # (k+1, 2)
                # Fraccion de replicas donde el signo del coeficiente se invierte
                # o el IC incluye cero -> fragilidad del resultado
                boot_frac_zero = []
                boot_hists = []
                for j in range(k + 1):
                    col = bb[:, j]
                    signs = np.sign(col[col != 0])
                    flip = float(1 - abs(np.mean(signs))) / 2 if len(signs) else 0.5
                    boot_frac_zero.append(bool(lo[j] <= 0 <= hi[j]) or flip > 0.15)
                    # Histograma recortado al 99% central: con n~10, replicas
                    # degeneradas pueden dar betas extremos que aplanarian
                    # la distribucion visible en un solo bin.
                    lo99, hi99 = np.percentile(col, [0.5, 99.5])
                    cnt, edges = np.histogram(col, bins=20, range=(float(lo99), float(hi99)))
                    boot_hists.append({"counts": [int(c) for c in cnt], "edges": [float(e) for e in edges]})
        except Exception:
            boot_ci = None
            boot_frac_zero = None
            boot_hists = None
    t_crit = float(stats.t.ppf(0.975, dof)) if dof > 0 else 1.96
    coefficients = [{"name": "intercept", "beta": float(beta[0]), "se": float(se[0]), "t": float(t_stats[0]), "p_value": float(p_values[0]),
                      "ci_95": [float(beta[0] - t_crit * se[0]), float(beta[0] + t_crit * se[0])]}]
    if robust_se is not None:
        coefficients[0]["robust_se"] = float(robust_se[0])
        coefficients[0]["robust_t"] = float(robust_t[0])
        coefficients[0]["robust_p"] = float(robust_p[0])
        coefficients[0]["robust_ci_95"] = [float(beta[0] - t_crit * robust_se[0]), float(beta[0] + t_crit * robust_se[0])]
    if boot_ci is not None:
        coefficients[0]["boot_ci_95"] = [float(boot_ci[0][0]), float(boot_ci[0][1])]
        coefficients[0]["boot_includes_zero"] = boot_frac_zero[0]
        coefficients[0]["boot_hist"] = boot_hists[0]
    for i, name in enumerate(indep_names):
        coef = {
            "name": name,
            "beta": float(beta[i + 1]),
            "se": float(se[i + 1]),
            "t": float(t_stats[i + 1]),
            "p_value": float(p_values[i + 1]),
            "significant": bool(p_values[i + 1] < 0.05),
            "ci_95": [float(beta[i + 1] - t_crit * se[i + 1]), float(beta[i + 1] + t_crit * se[i + 1])],
        }
        if robust_se is not None:
            coef["robust_se"] = float(robust_se[i + 1])
            coef["robust_t"] = float(robust_t[i + 1])
            coef["robust_p"] = float(robust_p[i + 1])
            coef["robust_significant"] = bool(robust_p[i + 1] < 0.05)
            coef["robust_ci_95"] = [float(beta[i + 1] - t_crit * robust_se[i + 1]), float(beta[i + 1] + t_crit * robust_se[i + 1])]
        if boot_ci is not None:
            coef["boot_ci_95"] = [float(boot_ci[i + 1][0]), float(boot_ci[i + 1][1])]
            coef["boot_includes_zero"] = boot_frac_zero[i + 1]
            coef["boot_hist"] = boot_hists[i + 1]
        coefficients.append(coef)
    return {
        "dependent": dep_name,
        "independent": indep_names,
        "n": n,
        "r_squared": float(r_squared),
        "adj_r_squared": float(adj_r_squared),
        "f_statistic": float(f_stat),
        "f_p_value": float(f_p_value),
        "vif": vif if vif else None,
        "white_test": white_test,
        "robust_se": robust_se is not None,
        "bootstrap": bool(boot_ci is not None),
        "coefficients": coefficients,
    }

def panel_regression(data):
    """Regresion de panel con efectos fijos por pais (dummies de pais).
    Usa todas las observaciones pais x anio (ej. 6 paises x 10 anios = 60 obs)
    en vez del agregado regional — controla las diferencias estructurales
    fijas entre paises y responde 'dentro de cada pais, cuando X subio,
    se movio Y?'. Input: data['panel'] = {dependent, independent} con
    nombres base de indicador (sin sufijo [CC]); se resuelven por pais."""
    import numpy as np
    from scipy import stats
    spec = data.get("panel")
    if not spec:
        return None
    variables = _get_variables(data)
    countries = sorted(set(v.get("country_code", "") for v in variables
                           if v.get("country_code", "") and v.get("country_code") != "LCN"))
    if len(countries) < 3:
        return {"error": "need >=3 countries for panel", "n_countries": len(countries)}
    dep_pat = spec["dependent"].lower()
    indep_pats = [p.lower() for p in spec.get("independent", [])]

    def find_base(cc, pat):
        for v in variables:
            if v.get("country_code") == cc and pat in v["name"].split(" [")[0].lower():
                return v
        return None

    rows = []  # (country_idx, y, x1, x2, ...)
    used_countries = []
    for ci, cc in enumerate(countries):
        dep_v = find_base(cc, dep_pat)
        indep_vs = [find_base(cc, p) for p in indep_pats]
        if not dep_v or not all(indep_vs):
            continue
        used_countries.append(cc)
        year_sets = []
        for v in [dep_v] + indep_vs:
            year_sets.append({y: val for y, val in zip(v.get("years", []), v.get("values", [])) if val is not None})
        common = sorted(set.intersection(*[set(s.keys()) for s in year_sets]))
        for yr in common:
            rows.append([cc, year_sets[0][yr]] + [s[yr] for s in year_sets[1:]])
    if len(used_countries) < 3 or len(rows) < len(indep_pats) + len(used_countries) + 2:
        return {"error": f"insufficient panel data ({len(rows)} obs, {len(used_countries)} countries)"}
    y_arr = np.array([r[1] for r in rows], dtype=float)
    X_main = np.array([r[2:] for r in rows], dtype=float)
    n = len(rows)
    k = len(indep_pats)
    nc = len(used_countries)
    # Efectos fijos por pais: dummies para nc-1 paises (la primera es base)
    cc_to_idx = {cc: i for i, cc in enumerate(used_countries)}
    D = np.zeros((n, nc - 1))
    for i, r in enumerate(rows):
        j = cc_to_idx[r[0]]
        if j > 0:
            D[i, j - 1] = 1.0
    X_full = np.column_stack([np.ones(n), X_main, D])
    dof = n - X_full.shape[1]
    if dof <= 0:
        return {"error": f"dof <= 0 (n={n}, params={X_full.shape[1]})"}
    try:
        beta = np.linalg.lstsq(X_full, y_arr, rcond=None)[0]
    except np.linalg.LinAlgError:
        return {"error": "singular matrix"}
    y_pred = X_full @ beta
    residuals = y_arr - y_pred
    ss_res = float(np.sum(residuals ** 2))
    ss_tot = float(np.sum((y_arr - np.mean(y_arr)) ** 2))
    r_squared = 1 - ss_res / ss_tot if ss_tot > 0 else 0.0
    sigma2 = ss_res / dof
    try:
        cov = sigma2 * np.linalg.inv(X_full.T @ X_full)
        se = np.sqrt(np.maximum(np.diag(cov), 0))
        t_stats = np.where(se > 0, beta / se, float("nan"))
        p_values = 2 * (1 - stats.t.cdf(np.abs(t_stats), dof))
    except np.linalg.LinAlgError:
        se = np.full(len(beta), float("nan")); t_stats = se.copy(); p_values = se.copy()
    coefficients = []
    for i, name in enumerate(spec["independent"]):
        j = i + 1  # despues del intercepto
        t_crit_fe = float(stats.t.ppf(0.975, dof)) if dof > 0 else 1.96
        coefficients.append({
            "name": name,
            "beta": float(beta[j]),
            "se": float(se[j]),
            "t": float(t_stats[j]),
            "p_value": float(p_values[j]),
            "significant": bool(p_values[j] < 0.05) if np.isfinite(p_values[j]) else False,
            "ci_95": [float(beta[j] - t_crit_fe * se[j]), float(beta[j] + t_crit_fe * se[j])],
        })
    return {
        "type": "fixed_effects_country",
        "dependent": spec["dependent"],
        "independent": spec["independent"],
        "n": n,
        "n_countries": nc,
        "countries": used_countries,
        "r_squared": float(r_squared),
        "dof": int(dof),
        "coefficients": coefficients,
        "note": "OLS con dummies de pais (efectos fijos). Controla caracteristicas fijas por pais; los coeficientes reflejan variacion intra-pais en el tiempo.",
    }

def cluster_analysis(data, k_min=2, k_max=4):
    """K-means clustering of countries by indicator profiles (latest year, standardized)."""
    import numpy as np
    variables = _get_variables(data)
    if not variables:
        return None
    # Build country x indicator matrix using latest value per variable
    countries = sorted(set(v.get("country_code", "") for v in variables if v.get("country_code", "") and v.get("country_code", "") != "LCN"))
    if len(countries) < k_min:
        return {"error": "not enough countries for clustering"}
    # Get unique indicator names
    ind_names = sorted(set(v["name"] for v in variables))
    # Build matrix
    matrix = []
    valid_countries = []
    for cc in countries:
        row = []
        for ind in ind_names:
            var = next((v for v in variables if v["name"] == ind and v.get("country_code", "") == cc), None)
            if var and var.get("values"):
                row.append(float(var["values"][-1]))
            else:
                row.append(np.nan)
        if not all(np.isnan(row)):
            matrix.append(row)
            valid_countries.append(cc)
    if len(valid_countries) < k_min:
        return {"error": "not enough countries with data"}
    X = np.array(matrix)
    # Impute NaN with column mean
    for j in range(X.shape[1]):
        col = X[:, j]
        mask = ~np.isnan(col)
        if mask.sum() > 0:
            col[~mask] = np.nanmean(col)
        else:
            col[:] = 0.0
    # Standardize (z-score)
    means = X.mean(axis=0)
    stds = X.std(axis=0)
    stds[stds == 0] = 1.0
    X_std = (X - means) / stds
    # Try k from k_min to k_max, pick best by silhouette
    best_k = k_min
    best_labels = None
    best_sil = -1
    results_by_k = {}
    for k in range(k_min, min(k_max + 1, len(valid_countries))):
        # Simple k-means (numpy only)
        np.random.seed(42)
        centroids = X_std[np.random.choice(len(X_std), k, replace=False)]
        for _ in range(100):
            dists = np.linalg.norm(X_std[:, None] - centroids[None, :], axis=2)
            labels = np.argmin(dists, axis=1)
            new_centroids = np.array([X_std[labels == j].mean(axis=0) if (labels == j).sum() > 0 else centroids[j] for j in range(k)])
            if np.allclose(new_centroids, centroids):
                break
            centroids = new_centroids
        # Silhouette score (simplified)
        if k < len(valid_countries):
            sil_vals = []
            for i in range(len(X_std)):
                same = labels == labels[i]
                same[i] = False
                if same.sum() == 0:
                    sil_vals.append(0)
                    continue
                a = np.mean(np.linalg.norm(X_std[i] - X_std[same], axis=1))
                other_dists = []
                for j_k in range(k):
                    if j_k == labels[i]:
                        continue
                    mask_j = labels == j_k
                    if mask_j.sum() == 0:
                        continue
                    other_dists.append(np.mean(np.linalg.norm(X_std[i] - X_std[mask_j], axis=1)))
                b = min(other_dists) if other_dists else 0
                sil_vals.append((b - a) / max(a, b) if max(a, b) > 0 else 0)
            sil = float(np.mean(sil_vals))
        else:
            sil = 0.0
        results_by_k[k] = {"silhouette": sil}
        if sil > best_sil:
            best_sil = sil
            best_k = k
            best_labels = labels
    # Build cluster assignments
    clusters = {}
    for i, cc in enumerate(valid_countries):
        c = int(best_labels[i])
        if c not in clusters:
            clusters[c] = []
        clusters[c].append(cc)
    # Compute cluster centroids in original scale for interpretation
    cluster_profiles = {}
    for c in range(best_k):
        mask = best_labels == c
        if mask.sum() == 0:
            continue
        profile = {}
        for j, ind in enumerate(ind_names):
            profile[ind] = float(np.mean(X[mask, j]))
        cluster_profiles[c] = profile
    return {
        "best_k": best_k,
        "silhouette": best_sil,
        "clusters": clusters,
        "cluster_profiles": cluster_profiles,
        "n_countries": len(valid_countries),
        "n_indicators": len(ind_names),
    }

def anomaly_detection(data):
    """Detect outlier countries/years per indicator using z-scores and IQR."""
    import numpy as np
    variables = _get_variables(data)
    results = []
    for var in variables:
        name = var["name"]
        vals = var.get("values", [])
        years = var.get("years", [])
        country = var.get("country", "")
        cc = var.get("country_code", "")
        if len(vals) < 4:
            continue
        arr = np.array(vals, dtype=float)
        mean = np.mean(arr)
        std = np.std(arr, ddof=1)
        if std == 0:
            continue
        z_scores = (arr - mean) / std
        # Z-score outliers (|z| > 2)
        for i, (v, z) in enumerate(zip(arr, z_scores)):
            if abs(z) > 2:
                results.append({
                    "indicator": name,
                    "country": country,
                    "country_code": cc,
                    "year": years[i] if i < len(years) else None,
                    "value": float(v),
                    "z_score": float(z),
                    "type": "high_z" if z > 0 else "low_z",
                })
        # IQR outliers
        q1, q3 = np.percentile(arr, [25, 75])
        iqr = q3 - q1
        lo = q1 - 1.5 * iqr
        hi = q3 + 1.5 * iqr
        for i, v in enumerate(arr):
            if v < lo or v > hi:
                if abs(z_scores[i]) <= 2:  # Only add if not already caught by z-score
                    results.append({
                        "indicator": name,
                        "country": country,
                        "country_code": cc,
                        "year": years[i] if i < len(years) else None,
                        "value": float(v),
                        "z_score": float(z_scores[i]),
                        "type": "iqr_low" if v < lo else "iqr_high",
                    })
    return results

def trend_analysis(data):
    """Mann-Kendall trend test and linear slope per variable."""
    import numpy as np
    from scipy import stats
    variables = _get_variables(data)
    results = []
    for var in variables:
        name = var["name"]
        vals = var.get("values", [])
        years = var.get("years", [])
        country = var.get("country", "")
        cc = var.get("country_code", "")
        if len(vals) < 4:
            continue
        arr = np.array(vals, dtype=float)
        if len(years) >= len(arr):
            yr = np.array(years[:len(arr)], dtype=float)
        else:
            yr = np.arange(len(arr), dtype=float)
        # Linear regression slope
        slope, intercept, r, p_slope, se = stats.linregress(yr, arr)
        # Mann-Kendall trend test
        n = len(arr)
        s = 0
        for i in range(n - 1):
            for j in range(i + 1, n):
                if arr[j] > arr[i]:
                    s += 1
                elif arr[j] < arr[i]:
                    s -= 1
        # Variance of S (with ties correction)
        var_s = n * (n - 1) * (2 * n + 5) / 18
        # Ties correction: subtract sum of t_i*(t_i-1)*(2t_i+5)/18 for each tied group
        unique_vals, counts = np.unique(arr, return_counts=True)
        ties = counts[counts > 1]
        if len(ties) > 0:
            tie_adj = np.sum(ties * (ties - 1) * (2 * ties + 5)) / 18
            var_s -= tie_adj
        if var_s > 0:
            if s > 0:
                z_mk = (s - 1) / np.sqrt(var_s)
            elif s < 0:
                z_mk = (s + 1) / np.sqrt(var_s)
            else:
                z_mk = 0
            p_mk = 2 * (1 - stats.norm.cdf(abs(z_mk)))
        else:
            z_mk = 0
            p_mk = 1.0
        results.append({
            "indicator": name,
            "country": country,
            "country_code": cc,
            "n": n,
            "slope": float(slope),
            "slope_p": float(p_slope),
            "r_squared": float(r ** 2),
            "mann_kendall_z": float(z_mk),
            "mann_kendall_p": float(p_mk),
            "trend": "increasing" if p_mk < 0.05 and z_mk > 0 else "decreasing" if p_mk < 0.05 and z_mk < 0 else "no_trend",
        })
    return results

def _short_label(name, maxlen=42):
    """Shorten an indicator name for chart labels."""
    name = name.split(" [")[0]  # drop [CC] suffix for display
    return name if len(name) <= maxlen else name[:maxlen - 1] + "…"

def make_charts(data, results, outdir):
    """Generate real figures (matplotlib, Agg backend) from computed results.
    Returns list of {file, caption}. Empty list if matplotlib unavailable or no data."""
    try:
        import matplotlib
        matplotlib.use("Agg")
        import matplotlib.pyplot as plt
        import numpy as np
    except Exception:
        return []
    import os
    os.makedirs(outdir, exist_ok=True)
    # ── Estilo editorial consistente (paleta del sitio) ──
    NAVY, BLUE, GOLD, RED, GREEN = "#14213d", "#1a56db", "#b8860b", "#d93025", "#2e7d32"
    plt.rcParams.update({
        "font.family": "DejaVu Sans", "font.size": 8.5,
        "axes.edgecolor": "#cccccc", "axes.linewidth": 0.8,
        "axes.titlesize": 9.5, "axes.titleweight": "bold",
        "figure.facecolor": "white", "axes.facecolor": "white",
        "axes.grid": True, "grid.color": "#e5e2db", "grid.linewidth": 0.6,
    })

    def _despine(ax):
        for s in ("top", "right"):
            ax.spines[s].set_visible(False)

    def _watermark(fig):
        fig.text(0.99, 0.005, "AcademicPipeline · World Bank API", ha="right", va="bottom", fontsize=5.5, color="#aaaaaa")

    variables = _get_variables(data)
    var_map = {v["name"]: v for v in variables}
    charts = []
    chart_data = {"figures": {}}

    # ── Fig 1: trends grid for LCN series ──
    lcn_vars = [v for v in variables if v.get("country_code") == "LCN" and len(v.get("values", [])) >= 3]
    if lcn_vars:
        ncols = 3
        nrows = int(np.ceil(len(lcn_vars) / ncols))
        fig, axes = plt.subplots(nrows, ncols, figsize=(11, 2.6 * nrows))
        axes = np.array(axes).reshape(-1)
        for ax, var in zip(axes, lcn_vars):
            yrs = var.get("years", [])[:len(var["values"])]
            ax.plot(yrs, var["values"], marker="o", ms=3, lw=1.4, color=BLUE)
            ax.set_title(_short_label(var["name"], 38), fontsize=7.5, fontweight="normal")
            ax.tick_params(labelsize=7)
            _despine(ax)
        for ax in axes[len(lcn_vars):]:
            ax.axis("off")
        fig.suptitle("Indicadores World Bank — América Latina y Caribe (agregado)", fontsize=11, fontweight="bold")
        fig.tight_layout(rect=[0, 0, 1, 0.96])
        _watermark(fig)
        fname = "fig1_trends.png"
        fig.savefig(os.path.join(outdir, fname), dpi=150)
        plt.close(fig)
        charts.append({"file": fname, "caption": "Evolución temporal 2015-2024 de los indicadores regionales (América Latina y Caribe). Fuente: World Bank API."})
        chart_data["figures"][fname] = {"type": "trends", "title": "Indicadores World Bank — América Latina y Caribe", "series": [{"name": v["name"], "years": v.get("years", []), "values": v["values"]} for v in lcn_vars]}

    # ── Fig 2: scatter of top significant correlation ──
    corr_results = [c for c in results.get("correlations", []) if c.get("significant")]
    if corr_results:
        best = max(corr_results, key=lambda c: abs(c["pearson_r"]))
        va, vb = var_map.get(best["x"]), var_map.get(best["y"])
        if va and vb:
            x_vals, y_vals, years = _align_by_years(va, vb)
            if len(x_vals) >= 3:
                x_arr, y_arr = np.array(x_vals, dtype=float), np.array(y_vals, dtype=float)
                fig, ax = plt.subplots(figsize=(6.5, 4.2))
                ax.scatter(x_arr, y_arr, color=BLUE, s=45, zorder=3)
                for x, y, yr in zip(x_arr, y_arr, years):
                    ax.annotate(str(yr), (x, y), textcoords="offset points", xytext=(5, 4), fontsize=7, color="#666")
                m, b = np.polyfit(x_arr, y_arr, 1)
                xs = np.linspace(x_arr.min(), x_arr.max(), 50)
                ax.plot(xs, m * xs + b, color=RED, lw=1.5, ls="--", label=f"r = {best['pearson_r']:.3f} (p = {best['pearson_p']:.4f})")
                ax.set_xlabel(_short_label(best["x"], 55), fontsize=9)
                ax.set_ylabel(_short_label(best["y"], 55), fontsize=9)
                ax.legend(fontsize=8)
                _despine(ax)
                fig.tight_layout()
                _watermark(fig)
                fname = "fig2_correlation.png"
                fig.savefig(os.path.join(outdir, fname), dpi=150)
                plt.close(fig)
                charts.append({"file": fname, "caption": f"Correlación de Pearson entre {_short_label(best['x'], 60)} y {_short_label(best['y'], 60)} (n={best['n']})."})
                chart_data["figures"][fname] = {"type": "scatter", "x_label": _short_label(best["x"], 60), "y_label": _short_label(best["y"], 60), "r": best["pearson_r"], "p": best["pearson_p"], "n": best["n"], "points": [[float(x), float(y), int(yr)] for x, y, yr in zip(x_arr, y_arr, years)], "fit": {"m": float(m), "b": float(b), "x_min": float(x_arr.min()), "x_max": float(x_arr.max())}}

    # ── Fig 3: regression actual vs fitted ──
    reg = results.get("regression")
    if reg and reg.get("dependent") and reg.get("coefficients"):
        dep_var = var_map.get(reg["dependent"])
        indep_vars = [var_map.get(n) for n in reg.get("independent", [])]
        if dep_var and all(indep_vars):
            all_vars = [dep_var] + indep_vars
            year_sets = [set(y for y, v in zip(v.get("years", []), v.get("values", [])) if v is not None) for v in all_vars]
            common = sorted(set.intersection(*year_sets)) if all(year_sets) else []
            if len(common) >= 3:
                y_arr = np.array([next(v for y, v in zip(dep_var["years"], dep_var["values"]) if y == yr) for yr in common], dtype=float)
                X_cols = []
                for iv in indep_vars:
                    X_cols.append(np.array([next(v for y, v in zip(iv["years"], iv["values"]) if y == yr) for yr in common], dtype=float))
                X_arr = np.column_stack(X_cols)
                beta = np.array([c["beta"] for c in reg["coefficients"]], dtype=float)
                y_pred = np.column_stack([np.ones(len(common)), X_arr]) @ beta
                fig, ax = plt.subplots(figsize=(6.5, 4.2))
                ax.plot(common, y_arr, marker="o", ms=4, lw=1.4, color=BLUE, label="Observado")
                ax.plot(common, y_pred, marker="s", ms=4, lw=1.4, ls="--", color=RED, label=f"Ajustado (R² = {reg['r_squared']:.3f})")
                ax.set_xlabel("Año", fontsize=9)
                ax.set_ylabel(_short_label(reg["dependent"], 55), fontsize=9)
                ax.set_title("Modelo OLS: valores observados vs ajustados", fontsize=10)
                ax.legend(fontsize=8)
                _despine(ax)
                fig.tight_layout()
                _watermark(fig)
                fname = "fig3_regression.png"
                fig.savefig(os.path.join(outdir, fname), dpi=150)
                plt.close(fig)
                charts.append({"file": fname, "caption": f"Ajuste del modelo de regresión OLS sobre {_short_label(reg['dependent'], 60)} (n={reg['n']}, R²={reg['r_squared']:.3f})."})
                chart_data["figures"][fname] = {"type": "fit", "dep": _short_label(reg["dependent"], 60), "r2": reg["r_squared"], "years": [int(y) for y in common], "observed": [float(v) for v in y_arr], "fitted": [float(v) for v in y_pred]}

    # ── Fig 4: country comparison bar chart (latest value of key indicator) ──
    # Pick the indicator with most country coverage (excluding LCN)
    by_ind = {}
    for v in variables:
        cc = v.get("country_code", "")
        if cc and cc != "LCN" and v.get("values"):
            base = v["name"].split(" [")[0]
            by_ind.setdefault(base, []).append(v)
    if by_ind:
        base_name, vs = max(by_ind.items(), key=lambda kv: len(kv[1]))
        if len(vs) >= 3:
            labels = [v.get("country_code") for v in vs]
            vals = [v["values"][-1] for v in vs]
            years = [v["years"][-1] if v.get("years") else "" for v in vs]
            order = np.argsort(vals)
            fig, ax = plt.subplots(figsize=(6.5, 3.6))
            ax.barh([labels[i] for i in order], [vals[i] for i in order], color=NAVY)
            ax.set_xlabel(_short_label(base_name, 55), fontsize=9)
            ax.set_title(f"Comparación por país ({years[0]})", fontsize=10)
            ax.grid(axis="x", alpha=0.3)
            _despine(ax)
            fig.tight_layout()
            _watermark(fig)
            fname = "fig4_countries.png"
            fig.savefig(os.path.join(outdir, fname), dpi=150)
            plt.close(fig)
            charts.append({"file": fname, "caption": f"Comparación internacional de {_short_label(base_name, 60)} (último año disponible). Fuente: World Bank API."})
            chart_data["figures"][fname] = {"type": "bars", "indicator": _short_label(base_name, 60), "year": years[0], "items": [{"cc": labels[i], "geo": vs[i].get("country") or labels[i], "value": float(vals[i])} for i in order]}

    # ── Fig 5: gráfico facetado de coeficientes con intervalos de confianza legibles ──
    ols_entries = []
    panel_entries = []
    reg = results.get("regression")
    if reg and reg.get("coefficients"):
        for c in reg["coefficients"]:
            if c["name"] == "intercept":
                continue
            ci = c.get("boot_ci_95") or c.get("ci_95")
            if ci:
                ols_entries.append({"name": c["name"].split(" [")[0], "beta": float(c["beta"]), "lo": float(ci[0]), "hi": float(ci[1]), "p": float(c.get("p_value", 1.0))})
    panel = results.get("panel")
    if panel and panel.get("coefficients"):
        for c in panel["coefficients"]:
            ci = c.get("ci_95")
            if ci:
                panel_entries.append({"name": c["name"].split(" [")[0], "beta": float(c["beta"]), "lo": float(ci[0]), "hi": float(ci[1]), "p": float(c.get("p_value", 1.0))})

    if ols_entries or panel_entries:
        n_plots = (1 if panel_entries else 0) + (1 if ols_entries else 0)
        fig, axes = plt.subplots(n_plots, 1, figsize=(7.2, 2.4 * n_plots), sharex=False)
        if n_plots == 1:
            axes = [axes]

        ax_idx = 0
        all_forest_entries = []
        if panel_entries:
            ax = axes[ax_idx]
            ys = np.arange(len(panel_entries))
            labels = [_short_label(e["name"], 32) for e in panel_entries]
            ax.axvline(0, color=NAVY, lw=1.2, ls="--", alpha=0.7)
            for i, e in enumerate(panel_entries):
                includes_zero = (e["lo"] <= 0 <= e["hi"])
                color = GREEN if not includes_zero else "#d97706"
                ax.errorbar([e["beta"]], [i], xerr=[[e["beta"] - e["lo"]], [e["hi"] - e["beta"]]], fmt="s",
                            color=color, ecolor=color, elinewidth=2.5, capsize=6, capthick=2, ms=7, zorder=3)
                p_str = f"p={e['p']:.3f}" if e['p'] >= 0.001 else "p<0.001"
                status = "Robusto" if not includes_zero else "Incluye 0 (Frágil)"
                badge = f"β={e['beta']:+.2f} ({p_str}) | IC95% [{e['lo']:.1f}, {e['hi']:.1f}] — {status}"
                ax.annotate(badge, (e["beta"], i), textcoords="offset points", xytext=(0, 10),
                            ha="center", fontsize=7.8, fontweight="bold", color="#1f2937",
                            bbox=dict(boxstyle="round,pad=0.2", facecolor="#f8fafc", edgecolor="#cbd5e1", alpha=0.9))
                all_forest_entries.append({"label": f"Panel FE · {e['name']}", "beta": e["beta"], "lo": e["lo"], "hi": e["hi"], "model": "Panel"})
            ax.set_yticks(ys)
            ax.set_yticklabels(labels, fontsize=8.5, fontweight="bold")
            ax.set_title("Panel Efectos Fijos por País (Variación Intra-País)", fontsize=9.5, fontweight="bold", color=NAVY, pad=14)
            ax.grid(axis="x", alpha=0.25, ls=":")
            _despine(ax)
            ax_idx += 1

        if ols_entries:
            ax = axes[ax_idx]
            ys = np.arange(len(ols_entries))
            labels = [_short_label(e["name"], 32) for e in ols_entries]
            ax.axvline(0, color=NAVY, lw=1.2, ls="--", alpha=0.7)
            for i, e in enumerate(ols_entries):
                includes_zero = (e["lo"] <= 0 <= e["hi"])
                color = GREEN if not includes_zero else "#d97706"
                ax.errorbar([e["beta"]], [i], xerr=[[e["beta"] - e["lo"]], [e["hi"] - e["beta"]]], fmt="o",
                            color=color, ecolor=color, elinewidth=2.5, capsize=6, capthick=2, ms=7, zorder=3)
                p_str = f"p={e['p']:.3f}" if e['p'] >= 0.001 else "p<0.001"
                status = "Robusto" if not includes_zero else "Incluye 0 (Frágil)"
                badge = f"β={e['beta']:+.2f} ({p_str}) | IC95% [{e['lo']:.1f}, {e['hi']:.1f}] — {status}"
                ax.annotate(badge, (e["beta"], i), textcoords="offset points", xytext=(0, 10),
                            ha="center", fontsize=7.8, fontweight="bold", color="#1f2937",
                            bbox=dict(boxstyle="round,pad=0.2", facecolor="#f8fafc", edgecolor="#cbd5e1", alpha=0.9))
                all_forest_entries.append({"label": f"OLS · {e['name']}", "beta": e["beta"], "lo": e["lo"], "hi": e["hi"], "model": "OLS"})
            ax.set_yticks(ys)
            ax.set_yticklabels(labels, fontsize=8.5, fontweight="bold")
            ax.set_title("Regresión OLS Agregada Regional (Bootstrap)", fontsize=9.5, fontweight="bold", color=NAVY, pad=14)
            ax.set_xlabel("Magnitud del coeficiente e Intervalo de Confianza (IC 95%)", fontsize=8.5, color="#475569")
            ax.grid(axis="x", alpha=0.25, ls=":")
            _despine(ax)

        fig.tight_layout()
        _watermark(fig)
        fname = "fig5_forest.png"
        fig.savefig(os.path.join(outdir, fname), dpi=150)
        plt.close(fig)
        charts.append({"file": fname, "caption": "Gráfico de coeficientes con intervalos de confianza al 95% (Panel FE y OLS agregado con escalas independientes y anotaciones de robustez)."})
        chart_data["figures"][fname] = {"type": "forest", "entries": all_forest_entries}

    # ── Fig 6: heatmap pais x par de indicadores (heterogeneidad visible) ──
    corr_all = [c for c in results.get("correlations", []) if c.get("pearson_r") is not None]
    if corr_all:
        pair_cc = {}
        for c in corr_all:
            cc = c["x"].split("[")[-1].rstrip("]") if "[" in c["x"] else ""
            if not cc:
                continue
            pair = f"{_short_label(c['x'].split(' [')[0], 30)} ↔ {_short_label(c['y'].split(' [')[0], 30)}"
            pair_cc.setdefault(pair, {})[cc] = c
        # Top pares: los que tienen al menos una celda significativa, orden por max |r|
        scored = []
        for pair, cells in pair_cc.items():
            max_r = max(abs(v["pearson_r"]) for v in cells.values())
            any_sig = any(v.get("significant") for v in cells.values())
            scored.append((any_sig, max_r, pair))
        scored.sort(key=lambda t: (t[0], t[1]), reverse=True)
        top_pairs = [p for _, _, p in scored[:10]]
        ccs = sorted(set(cc for cells in pair_cc.values() for cc in cells.keys()))
        if top_pairs and len(ccs) >= 2:
            M = np.full((len(top_pairs), len(ccs)), np.nan)
            for i, pair in enumerate(top_pairs):
                for j, cc in enumerate(ccs):
                    cell = pair_cc[pair].get(cc)
                    if cell is not None:
                        M[i, j] = cell["pearson_r"]
            fig, ax = plt.subplots(figsize=(max(5.5, 0.8 * len(ccs) + 2), 0.6 * len(top_pairs) + 1.6))
            masked = np.ma.masked_invalid(M)
            im = ax.imshow(masked, cmap="RdBu_r", vmin=-1, vmax=1, aspect="auto")
            ax.set_xticks(range(len(ccs)), ccs, fontsize=8)
            ax.set_yticks(range(len(top_pairs)), top_pairs, fontsize=7.5)
            for i, pair in enumerate(top_pairs):
                for j, cc in enumerate(ccs):
                    cell = pair_cc[pair].get(cc)
                    if cell is not None:
                        star = "*" if cell.get("significant") else ""
                        txt_col = "white" if abs(cell["pearson_r"]) > 0.6 else "#333333"
                        ax.text(j, i, f"{cell['pearson_r']:.2f}{star}", ha="center", va="center", fontsize=7, color=txt_col)
            ax.set_title("Correlaciones por país (r de Pearson) — * p<0.05", fontsize=9.5)
            ax.grid(False)
            for s in ax.spines.values():
                s.set_visible(False)
            fig.colorbar(im, ax=ax, shrink=0.7, label="r")
            fig.tight_layout()
            _watermark(fig)
            fname = "fig6_heatmap.png"
            fig.savefig(os.path.join(outdir, fname), dpi=150)
            plt.close(fig)
            charts.append({"file": fname, "caption": "Mapa de calor de correlaciones Pearson por país: la heterogeneidad entre países se aprecia en las diferencias de signo e intensidad. * marca significancia (p<0.05)."})
            cells = []
            for pair in top_pairs:
                row = []
                for cc in ccs:
                    cell = pair_cc[pair].get(cc)
                    row.append({"r": float(cell["pearson_r"]), "sig": bool(cell.get("significant"))} if cell is not None else None)
                cells.append(row)
            chart_data["figures"][fname] = {"type": "heatmap", "pairs": top_pairs, "countries": ccs, "cells": cells}

    # ── Fig 7: boxplot por pais — la dispersion entre paises visible ──
    # Trigger: el indicador con mas cobertura (mismo de fig4) tiene >=3 paises
    # con >=4 observaciones.
    if by_ind:
        base_name2, vs2 = max(by_ind.items(), key=lambda kv: len(kv[1]))
        box_vs = [v for v in vs2 if len(v.get("values", [])) >= 4]
        if len(box_vs) >= 3:
            fig, ax = plt.subplots(figsize=(6.5, 3.8))
            ax.boxplot([v["values"] for v in box_vs], tick_labels=[v.get("country_code") for v in box_vs],
                       patch_artist=True, boxprops=dict(facecolor="#dbe4f5", color=NAVY),
                       medianprops=dict(color=RED, lw=1.8), whiskerprops=dict(color=NAVY),
                       capprops=dict(color=NAVY), flierprops=dict(marker="o", ms=3, color=GOLD, markerfacecolor=GOLD))
            ax.set_ylabel(_short_label(base_name2, 45), fontsize=8.5)
            ax.set_title("Distribución por país — el rango importa tanto como el nivel", fontsize=9.5)
            ax.grid(axis="y", alpha=0.3)
            ax.grid(axis="x", visible=False)
            _despine(ax)
            fig.tight_layout()
            _watermark(fig)
            fname = "fig7_boxplot.png"
            fig.savefig(os.path.join(outdir, fname), dpi=150)
            plt.close(fig)
            charts.append({"file": fname, "caption": f"Distribución de {_short_label(base_name2, 60)} por país (2015-2024): caja = rango intercuartílico, línea = mediana. La dispersión revela heterogeneidad que el promedio esconde."})
            chart_data["figures"][fname] = {"type": "box", "indicator": _short_label(base_name2, 60), "countries": [{"cc": v.get("country_code"), "values": [float(x) for x in v["values"]]} for v in box_vs]}

    # ── Fig 8: distribucion bootstrap del coeficiente principal ──
    # Trigger: el primer coeficiente independiente tiene boot_hist.
    if reg and reg.get("coefficients"):
        coef1 = next((c for c in reg["coefficients"] if c["name"] != "intercept" and c.get("boot_hist")), None)
        if coef1:
            h = coef1["boot_hist"]
            edges, counts = np.array(h["edges"]), np.array(h["counts"])
            fig, ax = plt.subplots(figsize=(6.5, 3.8))
            ax.bar((edges[:-1] + edges[1:]) / 2, counts, width=np.diff(edges) * 0.95, color="#9db4dd", edgecolor=NAVY, lw=0.5)
            ci = coef1["boot_ci_95"]
            ax.axvspan(ci[0], ci[1], color=GOLD, alpha=0.25, label=f"IC95% [{ci[0]:.3f}, {ci[1]:.3f}]")
            ax.axvline(coef1["beta"], color=NAVY, lw=1.8, label=f"β = {coef1['beta']:.3f}")
            ax.axvline(0, color=RED, lw=1.4, ls="--", label="Efecto nulo")
            ax.set_xlabel(_short_label(coef1["name"].split(" [")[0], 50), fontsize=9)
            ax.set_ylabel("Frecuencia", fontsize=9)
            ax.set_title("¿Qué tan estable es el coeficiente? (2000 remuestreos)", fontsize=9.5)
            ax.legend(fontsize=8)
            pad = max((edges[-1] - edges[0]) * 0.3, abs(edges[-1] - edges[0]) * 0.05 + 1e-6)
            lo_x = min(edges[0], 0) - pad * 0.4 if edges[0] > 0 else edges[0] - pad
            ax.set_xlim(lo_x, edges[-1] + pad)
            _despine(ax)
            fig.tight_layout()
            _watermark(fig)
            fname = "fig8_bootdist.png"
            fig.savefig(os.path.join(outdir, fname), dpi=150)
            plt.close(fig)
            charts.append({"file": fname, "caption": f"Estabilidad del coeficiente de {_short_label(coef1['name'], 60)} tras 2000 remuestreos (rango recortado al 99% central): las barras muestran dónde cayó la estimación en cada réplica; si toca la línea roja (cero = sin efecto), el resultado es frágil."})
            chart_data["figures"][fname] = {"type": "boot", "label": _short_label(coef1["name"].split(" [")[0], 60), "counts": h["counts"], "edges": h["edges"], "beta": coef1["beta"], "ci": ci}

    # ── Fig 9: residuos vs ajustados — diagnostico honesto del modelo ──
    # Trigger: la regresion corrio (reutiliza el calculo de fig3 si existe).
    if reg and reg.get("dependent") and reg.get("coefficients"):
        dep_var = var_map.get(reg["dependent"])
        indep_vars_r = [var_map.get(n) for n in reg.get("independent", [])]
        if dep_var and all(indep_vars_r):
            all_vars_r = [dep_var] + indep_vars_r
            year_sets_r = [set(y for y, v in zip(v.get("years", []), v.get("values", [])) if v is not None) for v in all_vars_r]
            common_r = sorted(set.intersection(*year_sets_r)) if all(year_sets_r) else []
            if len(common_r) >= 4:
                y_r = np.array([next(v for y, v in zip(dep_var["years"], dep_var["values"]) if y == yr) for yr in common_r], dtype=float)
                Xr = np.column_stack([np.array([next(v for y, v in zip(iv["years"], iv["values"]) if y == yr) for yr in common_r], dtype=float) for iv in indep_vars_r])
                beta_r = np.array([c["beta"] for c in reg["coefficients"]], dtype=float)
                fitted = np.column_stack([np.ones(len(common_r)), Xr]) @ beta_r
                resid = y_r - fitted
                fig, ax = plt.subplots(figsize=(6.5, 3.8))
                ax.scatter(fitted, resid, color=BLUE, s=40, zorder=3)
                for xv, yv, yr in zip(fitted, resid, common_r):
                    ax.annotate(str(yr), (xv, yv), textcoords="offset points", xytext=(4, 4), fontsize=7, color="#666")
                ax.axhline(0, color=RED, lw=1.4, ls="--")
                ax.set_xlabel("Valor ajustado", fontsize=9)
                ax.set_ylabel("Residuo", fontsize=9)
                ax.set_title("Residuos vs ajustados — patrón visible = modelo incompleto", fontsize=9.5)
                _despine(ax)
                fig.tight_layout()
                _watermark(fig)
                fname = "fig9_residuals.png"
                fig.savefig(os.path.join(outdir, fname), dpi=150)
                plt.close(fig)
                charts.append({"file": fname, "caption": "Diagnóstico de residuos del modelo OLS: puntos dispersos alrededor del cero indican ajuste razonable; patrones sistemáticos revelan limitaciones del modelo."})
                chart_data["figures"][fname] = {"type": "resid", "dep": _short_label(reg["dependent"], 60), "points": [[float(f2), float(r2), int(yr)] for f2, r2, yr in zip(fitted, resid, common_r)]}

    # ── Fig 10: small multiples por pais — la heterogeneidad contada en paneles ──
    # Trigger: el par dependiente~independiente tiene >=3 paises con >=4 puntos.
    if reg and reg.get("independent"):
        dep_base = reg["dependent"].split(" [")[0]
        indep_base = reg["independent"][0].split(" [")[0]
        country_ccs = sorted(set(v.get("country_code") for v in variables if v.get("country_code") not in (None, "", "LCN")))
        panels = []
        for cc in country_ccs:
            vd = var_map.get(f"{dep_base} [{cc}]")
            vi = var_map.get(f"{indep_base} [{cc}]")
            if vd and vi:
                xs, ys, yrs = _align_by_years(vi, vd)
                if len(xs) >= 4:
                    panels.append({"cc": cc, "x": xs, "y": ys, "years": yrs})
        if len(panels) >= 3:
            ncols2 = 3
            nrows2 = int(np.ceil(len(panels) / ncols2))
            fig, axes = plt.subplots(nrows2, ncols2, figsize=(9, 2.4 * nrows2), sharex=False, sharey=False)
            axes = np.array(axes).reshape(-1)
            for ax, p in zip(axes, panels):
                xa, ya = np.array(p["x"], dtype=float), np.array(p["y"], dtype=float)
                ax.scatter(xa, ya, color=BLUE, s=22, zorder=3)
                m2, b2 = np.polyfit(xa, ya, 1)
                xs2 = np.linspace(xa.min(), xa.max(), 30)
                ax.plot(xs2, m2 * xs2 + b2, color=RED, lw=1.2, ls="--")
                ax.set_title(f"{p['cc']} (pendiente {m2:+.2f})", fontsize=8)
                ax.tick_params(labelsize=7)
                _despine(ax)
            for ax in axes[len(panels):]:
                ax.axis("off")
            fig.suptitle(f"{_short_label(dep_base, 40)} vs {_short_label(indep_base, 40)} — por país", fontsize=10, fontweight="bold")
            fig.tight_layout(rect=[0, 0, 1, 0.95])
            _watermark(fig)
            fname = "fig10_panels.png"
            fig.savefig(os.path.join(outdir, fname), dpi=150)
            plt.close(fig)
            charts.append({"file": fname, "caption": f"Relación {_short_label(dep_base, 50)} vs {_short_label(indep_base, 50)} dentro de cada país: las pendientes de signo distinto evidencian heterogeneidad que el agregado regional oculta."})
            chart_data["figures"][fname] = {"type": "panels", "x_label": _short_label(indep_base, 50), "y_label": _short_label(dep_base, 50), "panels": [{"cc": p["cc"], "points": [[float(a), float(b), int(c)] for a, b, c in zip(p["x"], p["y"], p["years"])]} for p in panels]}

    # ── Fig 11: anomalias marcadas en la serie — el contexto visible ──
    # Trigger: anomaly_detection encontro algun ano con |z|>2 en una serie clave.
    anomalies = results.get("anomalies") or []
    if anomalies:
        # Serie con la anomalia mas extrema
        top_anom = max(anomalies, key=lambda a: abs(a.get("z_score") or 0))
        anom_var = var_map.get(top_anom.get("indicator", ""))
        if anom_var and len(anom_var.get("values", [])) >= 4:
            yrs = anom_var.get("years", [])[:len(anom_var["values"])]
            vals = anom_var["values"]
            marks = [a for a in anomalies if a.get("indicator") == anom_var["name"]]
            fig, ax = plt.subplots(figsize=(6.5, 3.8))
            ax.plot(yrs, vals, marker="o", ms=4, lw=1.4, color=BLUE)
            for a in marks:
                yr_a = a.get("year")
                if yr_a in yrs:
                    v_a = vals[yrs.index(yr_a)]
                    ax.axvspan(yr_a - 0.4, yr_a + 0.4, color=RED, alpha=0.12)
                    ax.scatter([yr_a], [v_a], color=RED, s=60, zorder=4, marker="D")
                    ax.annotate(f"z={a['z_score']:+.1f}", (yr_a, v_a), textcoords="offset points", xytext=(6, 8), fontsize=7.5, color=RED)
            ax.set_xlabel("Año", fontsize=9)
            ax.set_ylabel(_short_label(anom_var["name"], 45), fontsize=8.5)
            ax.set_title("Años atípicos marcados (|z|>2)", fontsize=9.5)
            _despine(ax)
            fig.tight_layout()
            _watermark(fig)
            fname = "fig11_anomaly.png"
            fig.savefig(os.path.join(outdir, fname), dpi=150)
            plt.close(fig)
            charts.append({"file": fname, "caption": f"Años estadísticamente atípicos en {_short_label(anom_var['name'], 60)} (desviación estándar |z|>2). Los choques externos (p. ej. 2020) deben leerse como contexto, no como tendencia."})
            chart_data["figures"][fname] = {"type": "anomaly", "label": _short_label(anom_var["name"], 60), "years": [int(y) for y in yrs], "values": [float(v) for v in vals], "marks": [{"year": int(a["year"]), "z": float(a["z_score"]), "type": a.get("type")} for a in marks if a.get("year") in yrs]}

    # data.json: insumo de las figuras interactivas (ECharts) en el visor web.
    # Los PNG siguen siendo el formato del documento .md; el JSON alimenta la web.
    if chart_data["figures"]:
        try:
            with open(os.path.join(outdir, "data.json"), "w", encoding="utf-8") as fh:
                json.dump(chart_data, fh, ensure_ascii=False)
        except Exception:
            pass
    for c in charts:
        c["howto"] = FIG_GUIDE.get(c["file"], "")
    return charts

# Guia de lectura en lenguaje llano por figura — llega al prompt de WRITE y,
# cuando el orquestador inyecta figuras, se inserta como linea en cursiva.
FIG_GUIDE = {
    "fig1_trends.png": "cada mini-panel muestra un indicador regional a lo largo del tiempo; busca si sube, baja o fluctúa",
    "fig2_correlation.png": "cada punto es un año; si se alinean cerca de la línea punteada, las variables se mueven juntas",
    "fig3_regression.png": "los datos observados frente a lo que el modelo predijo; donde se separan, el modelo no captura la realidad",
    "fig4_countries.png": "barra más larga o país más oscuro = valor más alto del indicador",
    "fig5_forest.png": "la bolita es la estimación y la barra el rango plausible; si la barra cruza la línea del cero, el resultado no es concluyente",
    "fig6_heatmap.png": "azul = se mueven juntas; rojo = se mueven al revés; casi blanco = sin relación clara; * = significativo",
    "fig7_boxplot.png": "cada caja resume un país: la línea central es el valor típico; una caja alta significa mucha variación año a año",
    "fig8_bootdist.png": "repetimos el cálculo 2000 veces barajando los datos; si las barras no tocan la línea roja del cero, el coeficiente es estable",
    "fig9_residuals.png": "puntos regados sin patrón cerca del cero = modelo sano; si dibujan una forma, el modelo se perdió algo",
    "fig10_panels.png": "la misma relación dentro de cada país; si las pendientes apuntan en direcciones distintas, la respuesta depende del país",
    "fig11_anomaly.png": "los pines marcan años estadísticamente atípicos — choques como 2020 que se leen como contexto, no como tendencia",
}

def _evidence_badge(p, ci=None):
    """Semaforo de evidencia para coeficientes: robusta / marginal / sin evidencia."""
    if p is None:
        return "—"
    ci_has_zero = ci is not None and len(ci) == 2 and ci[0] <= 0 <= ci[1]
    if p < 0.05 and not ci_has_zero:
        return "🟢 Robusta"
    if p < 0.10:
        return "🟡 Marginal"
    return "🔴 Sin evidencia"

def _corr_badge(c):
    """Semaforo para correlaciones: una r significativa que no sobrevive en
    primeras diferencias es probable co-tendencia, no evidencia robusta."""
    if c.get("significant"):
        return "🟢 Robusta" if c.get("diff_significant") else "🟡 Co-tendencia probable"
    if (c.get("pearson_p") or 1) < 0.10:
        return "🟡 Marginal"
    return "🔴 Sin evidencia"

def generate_markdown_tables(data, results):
    """
    Genera tablas Markdown determinísticas con datos reales y resultados estadísticos.
    Evita que el LLM tenga que transcribir números a mano o que coloque puntos suspensivos (...).
    """
    variables = _get_variables(data)
    tables = {}

    reg = results.get("regression")
    panel = results.get("panel")

    ind_candidates = []
    if reg and isinstance(reg, dict) and "dependent" in reg:
        ind_candidates.append(reg["dependent"].split(" [")[0])
        for n in reg.get("independent", []):
            ind_candidates.append(n.split(" [")[0])
    elif panel and isinstance(panel, dict) and "dependent" in panel:
        ind_candidates.append(panel["dependent"].split(" [")[0])
        for n in panel.get("independent", []):
            ind_candidates.append(n.split(" [")[0])

    if not ind_candidates:
        corrs = results.get("correlations", [])
        for c in corrs[:5]:
            ind_candidates.append(c["x"].split(" [")[0])
            ind_candidates.append(c["y"].split(" [")[0])

    ind_candidates = list(dict.fromkeys(ind_candidates))

    all_years = set()
    selected_vars = []
    for cand in ind_candidates:
        for v in variables:
            base_name = v["name"].split(" [")[0]
            if base_name.lower() == cand.lower() or cand.lower() in base_name.lower():
                if v.get("values"):
                    selected_vars.append(v)
                    all_years.update(v.get("years", []))

    years_list = sorted(all_years)
    if years_list and selected_vars:
        # LCN primero, luego por país
        selected_vars.sort(key=lambda x: (0 if x.get("country_code") == "LCN" else 1, x.get("country_code", ""), x["name"]))
        headers = ["Serie / Indicador", "País / Región"] + [str(y) for y in years_list]
        sep = [":---", ":---:"] + [":---:" for _ in years_list]
        rows = [
            "| " + " | ".join(headers) + " |",
            "| " + " | ".join(sep) + " |"
        ]
        for v in selected_vars:
            label = v.get("label", v["name"].split(" [")[0])
            cc = v.get("country", "") or v.get("country_code", "")
            unit = f" ({v['unit']})" if v.get("unit") and v['unit'] != "unknown" else ""
            y_map = dict(zip(v.get("years", []), v.get("values", [])))
            row_vals = []
            for y in years_list:
                val = y_map.get(y)
                if val is None:
                    row_vals.append("—")
                else:
                    if abs(val) >= 1000:
                        row_vals.append(f"{val:,.1f}")
                    elif abs(val) >= 10:
                        row_vals.append(f"{val:.2f}")
                    else:
                        row_vals.append(f"{val:.3f}")
            rows.append(f"| {label}{unit} | {cc} | " + " | ".join(row_vals) + " |")
        tables["descriptive"] = "\n".join(rows)

    model_rows = [
        "| Modelo | Variable / Parámetro | Coeficiente (beta) | Error Estándar | Estadístico | p-valor | IC 95% | Evidencia |",
        "|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|"
    ]
    has_model = False
    if reg and isinstance(reg, dict) and "coefficients" in reg:
        has_model = True
        for c in reg["coefficients"]:
            sig_mark = _evidence_badge(c.get("p_value"), c.get("boot_ci_95"))
            boot_ci = c.get("boot_ci_95")
            ci_str = f"[{boot_ci[0]:.3f}, {boot_ci[1]:.3f}]" if boot_ci else "—"
            stat_str = f"t = {c.get('t_stat', 0):.2f}"
            var_name = c['name'].split(" [")[0]
            model_rows.append(f"| OLS Agregado (LCN) | {var_name} | {c.get('beta', 0):.4f} | {c.get('se', 0):.4f} | {stat_str} | {c.get('p_value', 1):.4f} | {ci_str} | {sig_mark} |")
        model_rows.append(f"| *Diagnóstico OLS* | *R² = {reg.get('r_squared', 0):.4f}, R²-adj = {reg.get('adj_r_squared', 0):.4f}, F = {reg.get('f_statistic', 0):.2f} (p = {reg.get('f_p_value', 1):.4f}), n = {reg.get('n', 0)}* | — | — | — | — | — | — |")

    if panel and isinstance(panel, dict) and "coefficients" in panel:
        has_model = True
        for c in panel["coefficients"]:
            ci = c.get("ci_95")
            sig_mark = _evidence_badge(c.get("p_value"), ci)
            ci_str = f"[{ci[0]:.3f}, {ci[1]:.3f}]" if ci else "—"
            stat_str = f"t = {c.get('t', 0):.2f}"
            var_name = c['name'].split(" [")[0]
            model_rows.append(f"| Panel Efectos Fijos (País) | {var_name} | {c.get('beta', 0):.4f} | {c.get('se', 0):.4f} | {stat_str} | {c.get('p_value', 1):.4f} | {ci_str} | {sig_mark} |")
        model_rows.append(f"| *Diagnóstico Panel* | *R² = {panel.get('r_squared', 0):.4f}, n = {panel.get('n', 0)} obs ({panel.get('n_countries', 0)} países), dof = {panel.get('dof', 0)}* | — | — | — | — | — | — |")

    if has_model:
        tables["regression"] = "\n".join(model_rows)

    corrs = results.get("correlations", [])
    if corrs:
        top_corrs = sorted(corrs, key=lambda c: (1 if c.get("significant") else 0, abs(c.get("pearson_r") or 0)), reverse=True)[:15]
        corr_rows = [
            "| Variable X | Variable Y | Ámbito / País | Pearson r | p-valor | Spearman ρ | Δ Pearson (año a año) | Δ p-valor | Evidencia |",
            "|:---|:---|:---:|:---:|:---:|:---:|:---:|:---:|"
        ]
        for c in top_corrs:
            vx = c["x"].split(" [")[0]
            vy = c["y"].split(" [")[0]
            cc = c["x"].split(" [")[-1].replace("]", "") if " [" in c["x"] else "Regional"
            r_val = f"{c['pearson_r']:.3f}" if c.get("pearson_r") is not None else "—"
            p_val = f"{c['pearson_p']:.3f}" if c.get("pearson_p") is not None else "—"
            sp_val = f"{c['spearman_rho']:.3f}" if c.get("spearman_rho") is not None else "—"
            diff_r = f"{c['diff_pearson_r']:.3f}" if c.get("diff_pearson_r") is not None else "—"
            diff_p = f"{c['diff_pearson_p']:.3f}" if c.get("diff_pearson_p") is not None else "—"
            corr_rows.append(f"| {vx} | {vy} | {cc} | {r_val} | {p_val} | {sp_val} | {diff_r} | {diff_p} | {_corr_badge(c)} |")
        tables["correlations"] = "\n".join(corr_rows)

    return tables

def main():
    if len(sys.argv) < 2:
        print(json.dumps({"error": "Usage: python compute.py input.json [charts_dir]"}))
        sys.exit(1)
    data = load_input(sys.argv[1])
    output = {
        "descriptive": descriptive_stats(data),
        "correlations": correlation_analysis(data),
        "regression": ols_regression(data),
        "panel": panel_regression(data),
        "clustering": cluster_analysis(data),
        "anomalies": anomaly_detection(data),
        "trends": trend_analysis(data),
    }
    charts_dir = sys.argv[2] if len(sys.argv) > 2 else None
    output["charts"] = make_charts(data, output, charts_dir) if charts_dir else []
    output["tables"] = generate_markdown_tables(data, output)
    # Escribir UTF-8 explicito: en Windows el stdout usa cp1252 y corrompe caracteres con tilde
    sys.stdout.buffer.write(json.dumps(output, ensure_ascii=False, indent=2).encode("utf-8"))
    sys.stdout.buffer.write(b"\n")

if __name__ == "__main__":
    main()
