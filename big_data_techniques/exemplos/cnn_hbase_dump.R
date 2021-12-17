"""
Passos para subir arquivo para o Hive
1. subir arquivo para o HDFS
    - hdfs dfs -put <path_origem> <path_destino>
    
2. criar schema da tabela no hbase
    - entrar no shell do hbase digitando hbase shell
    - digitar o comando de tal forma que o 1o parâmetro é o nome da tabela e o outro é a familia de colunas
        create 'cerrado_dummy', {NAME => 'cf'}
            --> cria uma tabela chamada `cerrado_dummy` com familia de colunas chamada `cf`
"""

library(RJDBC)

df <- read.csv("dummy.csv", sep=",")
df <- df[, 1:5]

head(df)

colnames(df) <- c("RowKey", "cc_saldo_atual", "cc_saldo_medio",
                  "credit_card_limite", "qtd_fin_imobiliario",
                  "qtd_mensal_cheques")

driverh <- JDBC(driverClass = "cdata.jdbc.apachehbase.ApacheHBaseDriver",
                classPath = "/home/hadoop/CData/lib/cdata.jdbc.apachehbase.jar", 
                identifier.quote = "'")

chbase <- dbConnect(driverh, "jdbc:apachehbase:Server=<ip_address>;Port=<port>")

dbListTables(chbase)

rs <- sqlAppendTable(chbase, "cerrado_teste", df, row.names = FALSE)

dbSendUpdate(chbase, rs)
