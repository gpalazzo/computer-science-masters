# Instala bibliotecas
#install.packages("dbplyr")
#install.packages("DBI")
#install.packages("RJDBC")
#install.packages("sparklyr")

# Carregamento de Bibliotecas
library(dbplyr)
library(DBI)
library(RJDBC)
library(sparklyr)

# Configuração do ambiente do R
Sys.setenv(SPARK_HOME = '/usr/local/spark/spark-3.0.0')
Sys.setenv(HADOOP_COMMON_LIB_NATIVE_DIR = '/srv/hadoop/lib/native')
Sys.setenv(HADOOP_CONF_DIR = '/srv/hadoop/etc/hadoop/conf')
Sys.setenv(YARN_CONF_DIR = '/srv/hadoop/etc/hadoop/conf')
Sys.setenv(JAVA_HOME = '/usr/lib/jvm/java-8-openjdk-amd64/jre')
Sys.setenv(HADOOP_OPTS = '-Djava.library.path=/srv/hadoop/lib')
Sys.setenv(SPARK_DIST_CLASSPATH = '/etc/hadoop/share/hadoop/common/lib:/etc/hadoop/share/hadoop/common:/srv/hadoop/li
bexec:/srv/hadoop/share/hadoop/hdfs/*:/srv/hadoop/share/hdfs/lib:/srv/hadoop/share/had
oop/mapreduce:/srv/hadoop/share/hadoop/mapreduce/lib:/srv/hadoop/share/hadoop/yarn/
lib:/srv/hadoop/share/hadoop/yarn:/srv/hadoop/share/hadoop/yarn/lib')
Sys.setenv(HADOOP_HOME = '/srv/hadoop')
Sys.setenv(SPARK_CONF_DIR = '/usr/local/spark/spark-3.0.0/conf')
JAVA_HOME_BIN <- paste0(Sys.getenv("JAVA_HOME"), "/bin")
SPARK_HOME_BIN <- paste0(Sys.getenv("SPARK_HOME"), "/bin")
HADOOP_HOME_BIN <- paste0(Sys.getenv("HADOOP_HOME"), "/bin")
#Sys.getenv() #verifica as variáveis de ambiente existentes

# Configurar a conexão do R com o Spark
config <- spark_config()
config$sparklyr.log.console <- TRUE
config$spark.env.SPARK_LOCAL_IP.local <- "<ip_address>"
config$spark_home <- "/usr/local/spark/spark-3.0.0"
config$sparklyr.gateway.start.timeout <- 120
config$spark.executor.cores <- 2
config$spark.executor.instances <- 3
config$spark.dynamicAllocation.enabled <- "false"
config$spark.yarn.stagingDir <- "hdfs://hadoopmaster:<port>/user/"

# Conexão com Spark em modo de execução local
system("$SPARK_HOME/bin/spark-submit --driver-memory 8g --class sparklyr.Shell /usr/local/lib/R/site-library/sparklyr/java/sparklyr-3.0.0-preview-2.12.jar <port1> <port2>", wait = FALSE)
sc <- spark_connect(master = "sparklyr://127.0.0.1:<port1>/<port2>")

# Leitura de arquivos local direto para a sessão spark local
titanic_local = spark_read_csv(sc, name = "titanic.csv", header = TRUE, delimiter = ";")

# Gravação de arquivos no hdfs com formato de saída de Jobs de MapReduce
spark_write_csv(df, "hdfs://hadoopmaster:<port>/user/gpalazzo/etl/data_domains/estacoes/raw", delimiter = ",")
