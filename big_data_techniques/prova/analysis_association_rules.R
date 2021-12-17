# INSTALA PACOTES
#install.packages(c("arules", "rstudioapi", "stringr"))

# IMPORTA PACOTES
library(arules)
library(rstudioapi)
library(stringr)

# DEFINE VARIÁVEIS
# data loading
full_file_path <- getSourceEditorContext()$path
current_file_name <- "Prova1_Ex1_GuilhermePalazzo_v1.R"
new_file_name <- "groceries.csv"
new_full_file_path <- str_replace(full_file_path, current_file_name, new_file_name)

# CARREGA DADOS
groceries <- read.transactions(new_full_file_path, sep = ",")
#head(groceries)

# VISUALIZAÇÃO INICIAL
inspect(groceries[1:5])

# PREPARAÇÃO DOS DADOS
groceries_frequency <-
  tibble(
    Items = names(itemFrequency(groceries)),
    Frequency = itemFrequency(groceries)
  )
#groceries_frequency

# exploração inicial das frequências
groceries_frequency %>%
  select(Frequency) %>%
  summary()

# ANÁLISES
# Resposta Item 1
groceries_frequency %>%
  arrange(Frequency) %>%
  slice(1:10)

# Resposta Item 2
# considerando itens que foram comprados pelo menos 1 vez nos últimos 30 dias
#   support = 30 / 9835 ~ 0.003
groceryrules_3 <-
  apriori(groceries,
          parameter = list(
            support = 0.003,
            confidence = 0.25,
            minlen = 3
          ))
summary(groceryrules_3)

# Resposta Item 3
groceryrules_2 <-
  apriori(groceries,
          parameter = list(
            support = 0.003,
            confidence = 0.25,
            minlen = 2
          ))
summary(groceryrules_2)

subset_rules <- subset(groceryrules_2, 
                       subset = items %ain% c("soda", "whipped/sour cream"))
df <- DATAFRAME(subset_rules, setStart='', setEnd='', separate=TRUE)
head(df)