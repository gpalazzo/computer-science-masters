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

# importa pacotes
library(rstudioapi)
library(ggplot2)
library(dplyr)
library(broom)

# carrega dados
df <- data.frame(cost = c(3, 2, 6, 4, 1),
                 output = c(1, 1, 1, 1, 1),
                 pf = c(2, 5, 3, 2, 6),
                 lf = c(4, 7, 8, 3, 2))
df

# 1. criar matriz de variável dependente e de variáveis independentes
df_dependente <- df[, c("cost"), drop=FALSE]
df_dependente
df_independente <- df[, c("output", "pf", "lf")]
df_independente

# 2. transpor a matriz de variáveis independentes
df_independente_t <- t(df_independente)
df_independente_t

# 3. multiplicar matricialmente a matriz de variáveis independentes original 
# e a transposta (transposta x original)
df_independente_mult <- df_independente_t %*% as.matrix(df_independente)
df_independente_mult

# 4. calcular a matriz inversa do passo 3
df_independente_mult_inv <- solve(df_independente_mult)
df_independente_mult_inv

# 5. multiplicar matricialmente a matriz transposta com a matriz de variável
#     dependente
df_dependente_independente_t_mult <- df_independente_t %*% as.matrix(df_dependente)
df_dependente_independente_t_mult

# 6. calcular os coeficientes beta: multiplicar matricialmente as matrizes dos 
#     passos 4 e 5
df_betas <- df_independente_mult_inv %*% df_dependente_independente_t_mult
df_betas

# 7. calcular os valores estimados (y^ ou Xbeta)
df_val_estimados <- as.matrix(df_independente) %*% df_betas
df_val_estimados

# 8. calcular matriz de resíduos (matriz dependente - matriz do passo 7)
df_residuos <- df_dependente - df_val_estimados
df_residuos

# 9. multiplicar matricialmente a matriz de residuos original e a transposta dela
df_residuos_mult <- t(df_residuos) %*% as.matrix(df_residuos)
df_residuos_mult

# 10. calcular a variância dos resíduos (valor do resíduo / (n-k))
n <- nrow(df_independente)
k <- ncol(df_independente)
var_residuos <- df_residuos_mult[1, 1] / (n-k)
var_residuos

# 11. calcular a matriz de variância do beta
df_var_beta <- var_residuos * df_independente_mult_inv
df_var_beta

# 12. calcular o desvio padrão dos betas
desv_pad_pf <- sqrt(df_var_beta["pf", "pf"])
desv_pad_pf

desv_pad_lf <- sqrt(df_var_beta["lf", "lf"])
desv_pad_lf

desv_pad_cte <- sqrt(df_var_beta["output", "output"])
desv_pad_cte

df_desv_pad <- data.frame(desv_pad = c(desv_pad_cte, desv_pad_pf, desv_pad_lf),
                          row.names = c("output", "pf", "lf"))
df_desv_pad

# 13. calcular estatística t
df_merged["estatistica_t"] <- df_merged$coeficientes / df_merged$desv_pad
df_merged

# 14. calcular p_valor
df_merged["p_valor"] <- 2*pt(-abs(df_merged$estatistica_t), df=2) #df = n-1
df_merged
