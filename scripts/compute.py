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

# Unit compatibility matrix: which units can be correlated together
UNIT_COMPAT = {
    ("%", "%"): True,
    ("%", "index"): True,   # Gini index vs % is semantically comparable
    ("%", "USD"): True,     # % vs USD: correlation is scale-invariant (Pearson r)
    ("USD", "USD"): True,
    ("count", "count"): True,
    ("per100", "per100"): True,
    ("per100", "%"): True,   # per100 and % are comparable (both rates)
    ("score", "score"): True,  # PISA scores
    ("score", "USD"): True,    # PISA score vs GDP per capita
    ("score", "%"): True,      # PISA score vs % indicators
    ("score", "index"): True,  # PISA score vs Gini index
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
        results.append({
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
        })
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
    coefficients = [{"name": "intercept", "beta": float(beta[0]), "se": float(se[0]), "t": float(t_stats[0]), "p_value": float(p_values[0]),
                      "ci_95": [float(beta[0] - 1.96 * se[0]), float(beta[0] + 1.96 * se[0])]}]
    if robust_se is not None:
        coefficients[0]["robust_se"] = float(robust_se[0])
        coefficients[0]["robust_t"] = float(robust_t[0])
        coefficients[0]["robust_p"] = float(robust_p[0])
        coefficients[0]["robust_ci_95"] = [float(beta[0] - 1.96 * robust_se[0]), float(beta[0] + 1.96 * robust_se[0])]
    for i, name in enumerate(indep_names):
        coef = {
            "name": name,
            "beta": float(beta[i + 1]),
            "se": float(se[i + 1]),
            "t": float(t_stats[i + 1]),
            "p_value": float(p_values[i + 1]),
            "significant": bool(p_values[i + 1] < 0.05),
            "ci_95": [float(beta[i + 1] - 1.96 * se[i + 1]), float(beta[i + 1] + 1.96 * se[i + 1])],
        }
        if robust_se is not None:
            coef["robust_se"] = float(robust_se[i + 1])
            coef["robust_t"] = float(robust_t[i + 1])
            coef["robust_p"] = float(robust_p[i + 1])
            coef["robust_significant"] = bool(robust_p[i + 1] < 0.05)
            coef["robust_ci_95"] = [float(beta[i + 1] - 1.96 * robust_se[i + 1]), float(beta[i + 1] + 1.96 * robust_se[i + 1])]
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
        "coefficients": coefficients,
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
        # Variance of S
        var_s = n * (n - 1) * (2 * n + 5) / 18
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

def main():
    if len(sys.argv) < 2:
        print(json.dumps({"error": "Usage: python compute.py input.json"}))
        sys.exit(1)
    data = load_input(sys.argv[1])
    output = {
        "descriptive": descriptive_stats(data),
        "correlations": correlation_analysis(data),
        "regression": ols_regression(data),
        "clustering": cluster_analysis(data),
        "anomalies": anomaly_detection(data),
        "trends": trend_analysis(data),
    }
    print(json.dumps(output, ensure_ascii=False, indent=2))

if __name__ == "__main__":
    main()
