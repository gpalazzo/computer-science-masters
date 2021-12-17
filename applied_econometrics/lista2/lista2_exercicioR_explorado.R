# problema
  # regressão em que `cost` é variável endógena (dependente) e as demais 
  # são exógenas (independentes)
  # construir uma matriz com os seguintes outputs:
    # - coeficientes (betas)
    # - desvio padrão dos coeficientes
    # - estatística t
    # - p valor

# processo para resolver
# 1. criar matriz de variável dependente e de variáveis independentes
# 2. transpor a matriz de variáveis independentes
# 3. multiplicar matricialmente a matriz de variáveis independentes original 
# e a transposta (transposta x original)
# 4. calcular a matriz inversa do passo 3
# 5. multiplicar matricialmente a matriz transposta com a matriz de variável
#     dependente
# 6. calcular os coeficientes beta: multiplicar matricialmente as matrizes dos 
#     passos 4 e 5
# 7. calcular os valores estimados (y^ ou Xbeta)
# 8. calcular matriz de resíduos (matriz dependente - matriz do passo 7)
# 9. multiplicar matricialmente a matriz de residuos original e a transposta dela
# 10. calcular a variância dos resíduos (valor do resíduo / (n-k))
# 11. calcular a matriz de variância do beta
# 12. calcular desvio padrão dos betas
# 13. calcular estatística t
# 14. calcular p_valor

# instala pacotes
install.packages("rstudioapi")
install.packages("stringr")

# importa pacotes
library(rstudioapi)
library(stringr)

# define variáveis
# premissas
# 1. a base de dados chama airline.RDS e está no mesmo path do script
# 2. o script chama lista2_exercicioR.R
full_file_path <- getSourceEditorContext()$path

current_file_name <- "lista2_exercicioR.R"
new_file_name <- "airline.RDS"

new_full_file_path <- str_replace(full_file_path, current_file_name, new_file_name)

# carrega dados
df <- readRDS(file=new_full_file_path)
#head(df)

# tratamento inicial
df["constante"] <- 1
#head(df)

# baseline: modelo de regressão
#df.lm <- lm(cost ~ constante + output + pf + lf, data=df)
#summary(df.lm)

# processo de cálculo de regressão
# 1. criar matriz de variável dependente e de variáveis independentes
df_dep <- df[, c("cost"), drop = FALSE]
#head(df_dep)

df_indep <- df[, c("constante", "output", "pf", "lf")]
#head(df_indep)

# 2. transpor a matriz de variáveis independentes
df_indep_t <- t(df_indep)
#head(df_indep_t)

# 3. multiplicar matricialmente a matriz de variáveis independentes original 
# e a transposta (transposta x original)
df_indep_mult <- df_indep_t %*% as.matrix(df_indep)
#head(df_indep_mult)

# 4. calcular a matriz inversa do passo 3
df_indep_mult_inv <- solve(df_indep_mult)
#head(df_indep_mult_inv)

# 5. multiplicar matricialmente a matriz transposta com a matriz de variável
#     dependente
df_dep_indep_t_mult <- df_indep_t %*% as.matrix(df_dep)
#head(df_dep_indep_t_mult)

# 6. calcular os coeficientes beta: multiplicar matricialmente as matrizes dos 
#     passos 4 e 5
df_betas <- df_indep_mult_inv %*% df_dep_indep_t_mult
#head(df_betas)

# 7. calcular os valores estimados (y^ ou Xbeta)
df_val_estimados <- as.matrix(df_indep) %*% df_betas
#head(df_val_estimados)

# 8. calcular matriz de resíduos (matriz dependente - matriz do passo 7)
df_residuos <- df_dep - df_val_estimados
#head(df_residuos)

# 9. multiplicar matricialmente a matriz de residuos original e a transposta dela
df_residuos_t_mult = t(df_residuos) %*% as.matrix(df_residuos)
#df_residuos_t_mult

# 10. calcular a variância dos resíduos (valor do resíduo / (n-k))
n <- nrow(df_indep)
k <- ncol(df_indep)
var_residous = df_residuos_t_mult[1, 1] / (n-k)
#var_residous

# 11. calcular a matriz de variância do beta
df_var_betas = var_residous * df_indep_mult_inv
df_var_betas

# 12. calcular desvio padrão dos betas
desv_pad_pf <- sqrt(df_var_betas["pf", "pf"])
#desv_pad_pf

desv_pad_lf <- sqrt(df_var_betas["lf", "lf"])
#desv_pad_lf

desv_pad_output <- sqrt(df_var_betas["output", "output"])
#desv_pad_output

desv_pad_cte <- sqrt(df_var_betas["constante", "constante"])
#desv_pad_cte

df_desv_pad <- data.frame(desv_pad = c(desv_pad_cte, desv_pad_output, desv_pad_pf, desv_pad_lf),
                          row.names = c("constante", "output", "pf", "lf"))
#df_desv_pad

# pré-processamento para o passo 13
# ajuste em nome de coluna
colnames(df_betas)[1] <- "coeficientes"

# casting objeto para dataframe
df_betas <- as.data.frame(df_betas)

# merge
df_merged <- merge(df_betas, df_desv_pad, by.x = 0, by.y = 0)
#df_merged

# 13. calcular estatística t
df_merged["estatistica_t"] <- df_merged$coeficientes / df_merged$desv_pad
#df_merged

# 14. calcular p_valor
df_merged["p_valor"] <- 2*pt(abs(df_merged$estatistica_t), df = n-k, lower.tail = FALSE)
#df_merged

# 15. montar output como esperado
# copiar dataframe
df_copy <- data.frame(df_merged)
# renomear colunas
colnames(df_copy)[2] <- "beta"
colnames(df_copy)[3] <- "sd.beta"
colnames(df_copy)[4] <- "t"
colnames(df_copy)[5] <- "p.value"

df_copy <- as.data.frame(df_copy) #casting para dataframe

# appenda linhas em um dataframe
df_staging <- rbind(df_copy[1, ], df_copy[3, ], df_copy[4, ], df_copy[2, ])
df_staging <- subset(df_staging, select = -c(Row.names)) #deletar coluna
row.names(df_staging) <- NULL #resetar o index
df_staging
