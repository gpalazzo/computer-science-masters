# ********* Resposta ********* 
# Durbin-Watson (DW) test

# INTERPRETAÇÃO DOS VALORES
#   DW = 2: indica que não há autocorrelação na amostra
#   0 <= DW < 2: indica autocorrelação positiva
#   2 < DW <= 4: indica autocorrelação negativa

# RESULTADO DO MODELO
# DW = 1.0476
  # pelo valor de DW tem autocorrelação positiva dos resíduos

# p-value = 0.0008782
  # hipótese nula do DW diz que não há autocorrelação, portanto como p < 1%,
  # pode-se rejeitar H0

# EXEMPLO DE APLICAÇÃO
# se o preço de uma ação indicar autocorrelação positiva, isso sugere que o
# preço de ontem tem correlação positiva com o de hoje, então se ontem o
# preço caiu, é provável que aconteça a mesma coisa hoje

# instala pacotes
install.packages("rstudioapi")
install.packages("stringr")
install.packages("lmtest")

# importa pacotes
library(rstudioapi)
library(stringr)
library(lmtest)

# variáveis
full_file_path <- getSourceEditorContext()$path

current_file_name <- "lista4_exercicioR.R"

data_file <- "autocorr.csv"
full_path <- str_replace(full_file_path, current_file_name, data_file)

# carrega dados
df <- read.csv(file=full_path)
#head(df)

# curiosidade: existe correlação entre x e y? intuitivamente eu diria que sim,
# uma correlação alta e positiva
cor(df)

# modelos
# area ~ preco
#lm_area_preco = lm(area ~ preco, data=df)
#summary(lm_area_preco)

# preco ~ area
lm_preco_area = lm(preco ~ area, data=df)
summary(lm_preco_area)

# autocorrelação dos resíduos
# area ~ preco
#dwtest(lm_area_preco)

# preco ~ area
dwtest(lm_preco_area)