# instala pacotes
install.packages("rstudioapi")
install.packages("stringr")
install.packages("ggplot2")
install.packages("pastecs")
install.packages("urca")
install.packages("tseries")
install.packages("vars")

# importa pacotes
library(rstudioapi)
library(stringr)
library(ggplot2)
library(pastecs)
library(urca)
library(tseries)
library(vars)

# variáveis
# base
full_file_path <- getSourceEditorContext()$path
current_file_name <- "cointegracao.R"

# preço minério
filename <- "minerio.RDS"
full_path <- str_replace(full_file_path, current_file_name, filename)

# carrega dados
df <- readRDS(file=full_path)
head(df)

# preparação dos dados
df["vale_log"] <- log(df$vale)
df["ferro_log"] <- log(df$ferro)
df["idx"] <- as.numeric(row.names(df))

# plots
## timeseries
ggplot(aes(x = idx, y = vale), data = df) +
  geom_line(color="red") +
  ggtitle("Vale prices over time") +
  xlab("Time index") +
  ylab("Prices") +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(aes(x = idx, y = ferro), data = df) +
  geom_line(color="blue") +
  ggtitle("Iron prices over time") +
  xlab("Time index") +
  ylab("Prices") +
  theme(plot.title = element_text(hjust = 0.5))

## histogramas
hist(df$vale_log)
hist(df$ferro_log)

# estatística descritiva
summary(df)
stat.desc(df)

# análises
## estacionariedade
### se tiver raiz unitária, então é não-estacionário
### quanto mais negativo o valor do teste DF, maior a chance de rejeitar a
###   hipótese de existir raiz unitária, ou seja, quanto mais negativo o valor
###   do teste DF, maior a chance de ser estacionário
adf.test(df$vale_log)
adf.test(df$ferro_log)

## causalidade
### tirando a 1a diferença
vale_log_diff <- diff(df$vale_log, differences=1)
ferro_log_diff <- diff(df$ferro_log, differences=1)
### validando se as séries são estacionárias
adf.test(vale_log_diff)
adf.test(ferro_log_diff)

### combinando as séries para o modelo VAR
df_log_diff <- cbind(vale_log_diff, ferro_log_diff)
head(df_log_diff)
### teste de Granger é muito sensível ao lag, podendo mudar o resultado
### dito isso, vamos estabelecer um critério de informação e deixar o modelo
###   decidir o melhor lag
df_var <- VAR(df_log_diff, type="const", lag.max=12, ic = "AIC")
df_var

causality(df_var, cause = "vale_log_diff")$Granger
causality(df_var, cause = "ferro_log_diff")$Granger

## valor futuro com resíduo em 10%
model <- lm(vale_log ~ ferro_log, data=subset(df, idx<=60))
summary(model)

ferro_log <- df[61,]$ferro_log
new_data <- data.frame(ferro_log)

value_pred <- predict(model, newdata = new_data)
value_pred <- as.numeric(value_pred)
value_real <- as.numeric(df[61,]$vale_log)

### variação percentual do preço real e predito
value_real / value_pred - 1


