
# IMPORTACION DE DATASETS ----

# Session / Set Working Directory / Choose Directory...

setwd("D:/Desktop/UNMSM/SDC-Learning/R_SDC/Datasets1")

# *delimitado por comas ----

ifd = read.csv("insurance_fraud_data.txt", header = T)
str(ifd)

View(ifd)

#fc=file.choose() 

# *excel ----

library(readxl)

ed = read_excel("Employee data.xlsx")
str(ed)
View(ed)
ed

# *spss ----

library(foreign)

enaho = read.spss("404-Modulo01-muestra2.sav",
                  to.data.frame = T)
str(enaho)


# *json ----
library(rjson)
library(jsonlite)

subv = fromJSON("subvenciones.json")
str(subv)

rm(data_json)

colnames(ed)
colnames(enaho)
colnames(ifd)
colnames(subv)

# *bases de datos ----

# Mencionar que las credenciales de la BD nos deberian 
# proporcionar los DBA


'Rol: Administrador de bases de datos (DBA)'

'PostgreSQL'
'Usuario: postgres; password: sdc2019PERU; 
host: 69.164.192.245; puerto: 5432, data base:alumno,
tabla:books'

library(RPostgreSQL)

pw = {"sdc2019PERU"}
drv = dbDriver("PostgreSQL")

con = dbConnect(drv, #driver
                dbname = "alumno",
                host = "69.164.192.245",
                port = 5432,
                user = "postgres",
                password = pw)

data_postgresql = dbGetQuery(con, "SELECT * from books")

'SQL Server'
'Usuario: SA; password: SdC2019PERU!; 
host: 69.164.192.245; puerto: 1433, data base:sbs,
tabla:anexo6'

library(DBI) # proyectos georeferenciados
library(odbc)

server = "69.164.192.245"
database = "alumno"
uid = "sdc_read"
pwd = "#sDc_Read#21"

conexion = dbConnect(odbc(),
                     Driver = "ODBC Driver 13 for SQL Server",
                     Database = database,
                     Uid = uid,
                     Pwd = pwd,
                     Server = server,
                     Port = 1433)

data_sqlserver = dbGetQuery(conexion, "SELECT * from anexo6")

# *html ----

# "extraer - estructurar y almacenar datos de la web"

library(rvest)

empleo = read_html("http://www.elempleo.com/cr/ofertas-empleo/c-1-1-5-millones")
empleo

name_job = empleo %>%
  html_nodes(".text-ellipsis") %>%
  html_text()

name_job
name_job[1:5]

name_company = empleo %>%
  html_nodes(".info-company-name") %>%
  html_text()

name_company
name_company[1:5]

data_empleo = data.frame('nombre_empresa' = name_company,
                         'nombre_puesto_laboral'= name_job)

# Tarea eliminar espacios en blanco al inicio y al final de las variables...

# *twitter ----

# install.packages("rtweet")
# install.packages("twitteR")
library("rtweet")
library("twitteR")

appname ="Analasis" #nombre de la API

key = "eMcnfrsrAgghHJCCBdP8QStYj"
access_token ="587863980-j6aJNJaXotnCuYF5rBZ8myUYF8kCet61E5sgWWHC"

## api secret (example below is not a real key)
secret = "M2FwH7ARB8MK6hq0n8HTrVErWanAsTST0nkmw11VfvuMjn8fel"
access_secret ="TbSQ6OVufSk0LH6iiRpSAJBwffggEOR2Ah1ToXRQghRIV"


twitter_token = create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret,
  access_token = access_token,
  access_secret = access_secret )

#Extrae tweets y seguidores del sitio web de Twitter con R y el paquete rtweet
rt = search_tweets("#elecciones2021", #hashtag 
                    n = 1000, #numero de tweets y retweets
                    include_rts = FALSE) #TRUE descarga tweets y retweets / FALSE descarga solo tweets

dim(rt)

head(rt)

#                         cuenta de Rafael Correa, expresidente Ecuador
rafaelcorrea= search_users("MashiRafael", token = twitter_token)

rafaelcorrea= as.data.frame(search_users("MashiRafael", #cuenta
                                          token = twitter_token))[,c("created_at","text")]
mode(rafaelcorrea)




# EXPORTACION DE DATASETS ----

head(ifd)
tail(ifd)

# suponiendo q hemos realizado diversos procesos en la data ifd...
# ahora queremos exportar ifd a una carpeta..

write.csv(ifd, file = 'ifd_exportar.csv', row.names = F)

getwd()



data()

mtcars2 = data.frame(mtcars)
View(mtcars2)

# exportar en .csv
write.csv(mtcars2, file = "mtcars2_exp.csv", row.names = F)

# exportar en .txt
write.table(mtcars2, file = "data_autos.txt", row.names = F)




