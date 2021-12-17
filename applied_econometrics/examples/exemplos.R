# atribuição de variável
a <- 10
a #print valor

b <- a
b

c <- "gui"
c

d <- "palazzo"
d

# operações
e = b + a
e

1 == 1
1 != 1
1 >= 2
2 >= 1 & 2 == 2
1 != 2 | 7 == 7
!6 == 6 #! é negação

f = c + d #erro, não pode concatenar strings assim

# funções
# usando funções de pacotes padrão
f = c(c, d) #função c para combinar em uma lista ou vetor
f

g = c(1, 2, 3, 4, 5)
g

summary(g)

# usando funções de pacote não padrão
?str_c

install.packages("stringr")
library(stringr)

?str_c

nome <- "gui"
sobrenome <- "palazzo"
nome_completo <- str_c(nome, sobrenome, sep=" ")

# help com funções
?c
?summary