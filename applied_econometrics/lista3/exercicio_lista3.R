# EXPLICAÇÃO
# o script possui resposta para 3 diferentes perguntas e a referência para as
# perguntas pode ser vista nos comentários ao longo do código e no nome das 
# variáveis, sendo:
# `airline`: refere-se às perguntas 1, 2 e 3
# `alfa`: refere-se à pergunta 4
# `beta`: refere-se à pergunta 5

# instala pacotes
install.packages("rstudioapi")
install.packages("stringr")
install.packages("car")

# importa pacotes
library(rstudioapi)
library(stringr)
library(car)

# variáveis
# base
full_file_path <- getSourceEditorContext()$path
current_file_name <- "exercicio_lista3.R"

# airline
airline_data_file <- "airline3.RDS"
airline_full_path <- str_replace(full_file_path, current_file_name, airline_data_file)

# alfa
alfa_data_file <- "dummy_alfa.csv"
alfa_full_path <- str_replace(full_file_path, current_file_name, alfa_data_file)

# beta
beta_data_file <- "dummy_beta.csv"
beta_full_path <- str_replace(full_file_path, current_file_name, beta_data_file)

# carrega dados
# airline
df_airline <- readRDS(file=airline_full_path)
head(df_airline)

# alfa
df_alfa <- read.csv(file=alfa_full_path)
head(df_alfa)

# beta
df_beta <- read.csv(file=beta_full_path)
head(df_beta)

# modelo inicial
# airline
lm_airline = lm(cost ~ output + pf + lf + extra, data=df_airline)
summary(lm_airline)

# alfa
lm_alfa_modelo1 = lm(y ~ x1, data=df_alfa)
summary(lm_alfa_modelo1)

lm_alfa_modelo2 = lm(y ~ x1 + d1, data=df_alfa)
summary(lm_alfa_modelo2)

# beta
lm_beta_modelo1 = lm(y ~ x1 + x2, data=df_beta)
summary(lm_beta_modelo1)

lm_beta_modelo2 = lm(y ~ x1 + x2 + d1 + d2, data=df_beta)
summary(lm_beta_modelo2)

lm_beta_modelo3 = lm(y ~ x1 + x2 + d1, data=df_beta)
summary(lm_beta_modelo3)

lm_beta_modelo4 = lm(y ~ x1 + x2 + d2, data=df_beta)
summary(lm_beta_modelo4)

# encontra multicolinearidade
# airline
vif(lm_airline)

# alfa
vif(lm_alfa_modelo2)

# beta
vif(lm_beta_modelo1)
vif(lm_beta_modelo2)
vif(lm_beta_modelo3)
vif(lm_beta_modelo4)

# correlação das variávies independentes
# airline
cor(df_airline[ , c("output", "pf", "lf", "extra")])

# alfa
cor(df_alfa[ , c("x1", "d1")])

# beta
cor(df_beta[ , c("x1", "d1", "x2", "d2")])

# modelo apenas com variáveis multicolineares
# airline
lm_airline_vif = lm(cost ~ pf + extra, data=df_airline)
summary(lm_airline_vif)
