# importa pacotes
library(rstudioapi)
library(stringr)

# define variáveis
full_file_path <- getSourceEditorContext()$path

current_file_name <- "multiple_regression_test.R"
new_file_name <- "heart.data.csv"

new_full_file_path <- str_replace(full_file_path, current_file_name, new_file_name)

# carrega dados
data <- read.csv(file=new_full_file_path)

# explora dados
summary(data)

# premissas de regressão linear
# 1. independência das observações, ou seja, sem autocorrelação
#   - testando correlação entre as variáveis independentes
cor(data$biking, data$smoking) 
#1,5% correlação, ok para usa-las em conjunto

# 2. normalidade da variável dependente
hist(data$heart.disease)
#   - mais observações no centro do que nas extremidades, então podemos 
#       prosseguir

# 3. linearidade
plot(heart.disease ~ biking, data=data) #parece linear
plot(heart.disease ~ smoking, data=data) #inconclusivo, mas parece linear

# 4. homocedasticidade (homogeneidade de variância)
#   - isso significa que o erro de predição não muda significativamente ao
#       longo do intervalo de predicão do modelo

# aplicando o modelo
data.lm <- lm(heart.disease ~ biking + smoking, data=data)
summary(data.lm)
