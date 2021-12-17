library("RJDBC")

drv = JDBC("org.apache.hive.jdbc.HiveDriver", c("/usr/local/hive/apache-hive-3.1.2-bin/lib/hive-jdbc-3.1.2.jar", "libthrift-0.9.3.jar"))

conn = dbConnect(drv, "jdbc:hive2://<ip_address>:<port>/<database>", identifier.quote="`")

df <- dbGetQuery(conn, "select cerrado.hora_medicao,
                        cerrado.precipitacao_total_horariomm,
                        cerrado.pressao_atmosferica_ao_nivel_da_estacao_horariamb,
                        cerrado.pressao_atmosferica_reduzida_nivel_do_mar_autmb,
                        cerrado.pressao_atmosferica_maxna_hora_ant_autmb,
                        cerrado.pressao_atmosferica_min_na_hora_ant_autmb,
                        cerrado.radiacao_globalk,
                        cerrado.temperatura_da_cpu_da_estacaoc,
                        cerrado.temperatura_do_ponto_de_orvalhoc,
                        cerrado.temperatura_maxima_na_hora_ant_autc,
                        cerrado.temperatura_minima_na_hora_ant_autc,
                        cerrado.temperatura_orvalho_max_na_hora_ant_autc,
                        cerrado.temperatura_orvalho_min_na_hora_ant_autc,
                        cerrado.tensao_da_bateria_da_estacaov,
                        cerrado.umidade_rel_max_na_hora_ant_aut,
                        cerrado.umidade_rel_min_na_hora_ant_aut,
                        cerrado.umidade_relativa_do_ar_horaria,
                        cerrado.vento_direcao_horaria_gr_gr,
                        cerrado.temperatura_do_ar_bulbo_seco_horariac,
                        cerrado.vento_velocidade_horariampors,
                        cerrado.vento_rajada_maximampors,
                        cerrado.dia_inmet,
                        cerrado.mes_inmet,
                        cerrado.ano_inmet,
                        cerrado.hora_inmet,
                        cerrado.ano,
                        cerrado.mes,
                        cerrado.dia,
                        cerrado.hora,
                        cerrado.estado,
                        cerrado.sigla,
                        cerrado.bioma,
                        cerrado.latitude,
                        cerrado.longitude,
                        cerrado.dc_nome,
                        cerrado.cd_situacao,
                        cerrado.vl_altitude,
                        cerrado.cd_estacao,
                        cerrado.estacao,
                        cerrado.uf,
                        cerrado.incendio
                 from cerrado
                 limit 1000")

head(df)

write.csv(df, "/home/guilherme/incendios100k.csv")