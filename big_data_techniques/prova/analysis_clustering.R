# INSTALA PACOTES
#install.packages(c("stats","factoextra","gridExtra",
# "cluster", "stringr", "rstudioapi", "tidyverse"))

# IMPORTA PACOTES
library(tidyverse)
library(rstudioapi)
library(stringr)
library(stats)
library(factoextra)

# DEFINE VARIÁVEIS
# data loading
full_file_path <- getSourceEditorContext()$path
current_file_name <- "Prova1_Ex2_GuilhermePalazzo_v1.R"
new_file_name <- "college.csv"
new_full_file_path <- str_replace(full_file_path, current_file_name, new_file_name)

# clustering
QTD_CLUSTERS <- 3

# GLOBAL SETUP
#options(ggrepel.max.overlaps = Inf)

# CARREGA DADOS
college <- read_csv(new_full_file_path, col_types = "nccfffffnnnnnnnnn")
#head(college)

# VISUALIZAÇÃO INICIAL
glimpse(college)

# PREPARAÇÃO DOS DADOS
# filtro do estado de Indiana
indiana_college <- college %>%
  filter(state == "IN") %>%
  column_to_rownames(var = "name")
#head(indiana_college)

# exploração inicial das colunas de interesse
indiana_college %>%
  select(faculty_salary_avg, tuition) %>%
  summary()

# passo extremamente importante: value scaling
indiana_college_scaled <- indiana_college %>%
  select(faculty_salary_avg, tuition) %>%
  scale()
#summary(indiana_college_scaled) #verificação do scaling

# GERAÇÃO DOS CLUSTERS
set.seed(1234) # reprodutibilidade do experimento
k_3 <- kmeans(indiana_college_scaled, centers=QTD_CLUSTERS, nstart = 25)

# VISUALIZAÇÃO
fviz_cluster(k_3,
             data = indiana_college_scaled,
             repel = TRUE,
             ggtheme = theme_minimal()) + theme(text = element_text(size = 14))
