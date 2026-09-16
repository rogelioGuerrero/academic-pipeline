#!/usr/bin/env Rscript
# compute_panel.R - Analisis econometrico de panel en R para AcademicPipeline
# Ejecuta regresiones de panel con efectos fijos (country + year) y exporta JSON estandar

args <- commandArgs(trailingOnly = TRUE)
input_file <- ifelse(length(args) >= 1, args[1], "output/raw/compute-input.json")
output_file <- ifelse(length(args) >= 2, args[2], "output/raw/compute-r-results.json")

# Intentar cargar jsonlite si existe, o usar helper base
has_jsonlite <- suppressWarnings(require("jsonlite", quietly = TRUE))

load_data <- function(file_path) {
  if (has_jsonlite) {
    return(jsonlite::fromJSON(file_path, simplifyVector = FALSE))
  } else {
    # Fallback lectura basica si jsonlite no esta
    lines <- paste(readLines(file_path, warn = FALSE), collapse = " ")
    return(NULL)
  }
}

write_json <- function(obj, file_path) {
  if (has_jsonlite) {
    json_text <- jsonlite::toJSON(obj, pretty = TRUE, auto_unbox = TRUE)
    writeLines(json_text, file_path)
  } else {
    # Serializador manual a prueba de fallos para el esquema de panel
    coef_lines <- sapply(obj$coefficients, function(c) {
      sprintf('      {"name": "%s", "estimate": %.4f, "std_error": %.4f, "t_stat": %.2f, "p_value": %.4f, "significant": %s}',
              c$name, c$estimate, c$std_error, c$t_stat, c$p_value, ifelse(c$significant, "true", "false"))
    })
    json_text <- sprintf('{\n  "engine": "R (stats base lm)",\n  "model_type": "%s",\n  "formula": "%s",\n  "r_squared": %.4f,\n  "adj_r_squared": %.4f,\n  "f_statistic": %.2f,\n  "f_p_value": %.4f,\n  "n": %d,\n  "n_countries": %d,\n  "coefficients": [\n%s\n  ]\n}',
                         obj$model_type, obj$formula, obj$r_squared, obj$adj_r_squared, obj$f_statistic, obj$f_p_value, obj$n, obj$n_countries, paste(coef_lines, collapse = ",\n"))
    writeLines(json_text, file_path)
  }
}

run_analysis <- function() {
  if (!file.exists(input_file)) {
    cat(sprintf("Archivo no encontrado: %s\n", input_file))
    return(NULL)
  }
  
  if (!has_jsonlite) {
    cat("Aviso: jsonlite no disponible en R, omitiendo panel especializado.\n")
    return(NULL)
  }
  
  raw <- jsonlite::fromJSON(input_file, simplifyVector = FALSE)
  series_list <- raw$series
  if (is.null(series_list) || length(series_list) == 0) {
    return(NULL)
  }
  
  # Buscar especificación de panel o regresión en el input
  reg_spec <- raw$regression
  if (is.null(reg_spec)) {
    return(NULL)
  }
  
  dep_name <- reg_spec$dependent
  indep_names <- unlist(reg_spec$independent)
  
  # Extraer datos en formato largo (pais, anio, variable, valor)
  records <- list()
  for (s in series_list) {
    c_code <- s$country_code
    if (is.null(c_code) || c_code == "LCN") next # Excluir regional agregado del panel
    
    yrs <- unlist(s$years)
    vals <- unlist(s$values)
    v_name <- s$name
    
    if (length(yrs) > 0 && length(vals) > 0) {
      for (k in seq_along(yrs)) {
        if (!is.na(vals[k])) {
          key <- paste(c_code, yrs[k], sep = "_")
          if (is.null(records[[key]])) {
            records[[key]] <- list(country = c_code, year = yrs[k])
          }
          # Limpiar nombre para columna R
          clean_v <- gsub("\\[.*?\\]", "", v_name)
          clean_v <- trimws(clean_v)
          records[[key]][[clean_v]] <- vals[k]
        }
      }
    }
  }
  
  if (length(records) < 15) {
    return(NULL)
  }
  
  # Convertir a data.frame
  df <- do.call(rbind, lapply(records, function(x) as.data.frame(x, stringsAsFactors = FALSE)))
  
  # Identificar columnas dependiente e independientes
  dep_clean <- trimws(gsub("\\[.*?\\]", "", dep_name))
  indep_cleans <- trimws(gsub("\\[.*?\\]", "", indep_names))
  
  # Match de columnas en df
  col_dep <- colnames(df)[which(sapply(colnames(df), function(c) grepl(substr(dep_clean, 1, 15), c, ignore.case = TRUE)))[1]]
  col_indeps <- c()
  for (ind in indep_cleans) {
    m <- colnames(df)[which(sapply(colnames(df), function(c) grepl(substr(ind, 1, 15), c, ignore.case = TRUE)))[1]]
    if (!is.na(m)) col_indeps <- c(col_indeps, m)
  }
  
  if (is.na(col_dep) || length(col_indeps) == 0) {
    return(NULL)
  }
  
  # Filtrar casos completos
  use_cols <- c("country", "year", col_dep, col_indeps)
  sub_df <- df[, use_cols, drop = FALSE]
  for (c in c(col_dep, col_indeps)) sub_df[[c]] <- as.numeric(sub_df[[c]])
  sub_df$year <- as.factor(sub_df$year)
  sub_df$country <- as.factor(sub_df$country)
  sub_df <- na.omit(sub_df)
  
  if (nrow(sub_df) < 10) return(NULL)
  
  # Modelo con efectos fijos bidireccionales: Y ~ X1 + X2 + factor(country) + factor(year)
  fmla_str <- paste("`", col_dep, "` ~ ", paste(paste0("`", col_indeps, "`"), collapse = " + "), " + country + year", sep = "")
  fit <- lm(as.formula(fmla_str), data = sub_df)
  s <- summary(fit)
  
  # Extraer coeficientes solo de las variables de interés (no de los dummies)
  coefs <- list()
  for (ind in col_indeps) {
    r_name <- paste0("`", ind, "`")
    if (!r_name %in% rownames(s$coefficients)) {
      r_name <- ind
    }
    if (r_name %in% rownames(s$coefficients)) {
      row_c <- s$coefficients[r_name, ]
      coefs[[length(coefs) + 1]] <- list(
        name = ind,
        estimate = as.numeric(row_c[1]),
        std_error = as.numeric(row_c[2]),
        t_stat = as.numeric(row_c[3]),
        p_value = as.numeric(row_c[4]),
        significant = (row_c[4] < 0.05)
      )
    }
  }
  
  f_stat <- as.numeric(s$fstatistic[1])
  f_p <- pf(s$fstatistic[1], s$fstatistic[2], s$fstatistic[3], lower.tail = FALSE)
  
  res <- list(
    engine = "R 4.x (Two-Way Fixed Effects Panel OLS)",
    model_type = "two_way_fixed_effects",
    formula = paste(dep_clean, "~", paste(indep_cleans, collapse = " + "), "| country + year"),
    r_squared = as.numeric(s$r.squared),
    adj_r_squared = as.numeric(s$adj.r.squared),
    f_statistic = ifelse(is.na(f_stat), 0, f_stat),
    f_p_value = ifelse(is.na(f_p), 1, f_p),
    n = nrow(sub_df),
    n_countries = length(unique(sub_df$country)),
    coefficients = coefs
  )
  
  dir.create(dirname(output_file), showWarnings = FALSE, recursive = TRUE)
  write_json(res, output_file)
  cat(sprintf("R Panel completado exitosamente: R2=%.4f (n=%d, %d paises)\n", res$r_squared, res$n, res$n_countries))
  return(res)
}

tryCatch({
  run_analysis()
}, error = function(e) {
  cat(sprintf("Aviso R Panel: %s\n", e$message))
})
