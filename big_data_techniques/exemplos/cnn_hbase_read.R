# instalação de bibliotecas
#install.packages(c("RJDBC", "dplyr", "moments"))

# import de bibliotecas
library(RJDBC)
library(dplyr)
library(moments)
library(data.table)

# Data Loading
## Conexão com HBase
driverh <- JDBC(driverClass = "cdata.jdbc.apachehbase.ApacheHBaseDriver",
                classPath = "/home/hadoop/CData/lib/cdata.jdbc.apachehbase.jar",
                identifier.quote = "'")

chbase <- dbConnect(driverh, "jdbc:apachehbase:Server=<ip_address>;Port=<port>")

## Teste de conexão
dbListTables(chbase)

## Raw data loading
raw_df <- dbGetQuery(chbase, "SELECT financeiro:cc_saldo_atual,
                        financeiro:cc_saldo_medio,
                        financeiro:credit_card_limite,
                        financeiro:qtd_fin_imobiliario,
                        financeiro:qtd_mensal_cheques,
                        financeiro:qtd_pag_automovel,
                        financeiro:qtd_trans_atm,
                        financeiro:qtd_trans_kiosk,
                        financeiro:qtd_trans_teller,
                        financeiro:qtd_trans_web,
                        financeiro:retirada_mensal,
                        financeiro:valor_fin_imobiliario,
                        financeiro:valor_fundos_bancarios,
                        ltv:classe_ltv,
                        ltv:ltv,
                        pessoal:estado,
                        pessoal:estado_civil,
                        pessoal:idade,
                        pessoal:n_dependentes,
                        pessoal:nome,
                        pessoal:profissao,
                        pessoal:proprietario_casa,
                        pessoal:proprietario_veiculo,
                        pessoal:regiao,
                        pessoal:salario,
                        pessoal:sexo,
                        pessoal:sobrenome,
                        pessoal:tem_filho,
                        seguro:tem_seguro_imobiliario,
                        seguro:tempo_cliente_anos
                        FROM customer")

dbDisconnect(chbase)