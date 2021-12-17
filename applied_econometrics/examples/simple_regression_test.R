# importa pacotes
library(rstudioapi)
library(stringr)

# define variáveis
full_file_path <- getSourceEditorContext()$path

current_file_name <- "simple_regression_test.R"
new_file_name <- "income.data.csv"

new_full_file_path <- str_replace(full_file_path, current_file_name, new_file_name)

# carrega dados
data <- read.csv(file=new_full_file_path)

# explora dados
summary(data)

# premissas de regressão linear
# 1. independência das observações, ou seja, sem autocorrelação
#   - como só há 1 variável dependente e 1 independente, não há necessidade de 
#       encontrar relações entre variáveis

# 2. normalidade
hist(data$happiness)
#   - mais observações no centro do que nas extremidades, então podemos 
#       prosseguir

# 3. linearidade
plot(happiness ~ income, data=data)
#   - relação parece linear, então podemos prosseguir
cor(data$happiness, data$income)
#   - teste adicional: cálculo da intensidade da correlação

# 4. heterocedasticidade (homogeneidade de variância)
#   - isso significa que o erro de predição não muda significativamente ao
#       longo do intervalo de predicão do modelo

# aplicando o modelo
data.lm <- lm(happiness ~ income, data=data)
summary(data.lm)