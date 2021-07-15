
# MANEJO DE DATOS ----

setwd("D:/Desktop/UNMSM/SDC-Learning/R_SDC/Datasets1")

library(readxl)

clientes = read_excel("Clientes_2016_2017.xlsx")
str(clientes)
clientes

colnames(clientes) # Nombre de las columnas
rownames(clientes) # Nombre de las filas

# Seleccionar registros ----

summary(clientes) #Resumen estadistico de cada variable
#Mediana es el segundo quartil

# 1st Qu. = Q1 = P25

#Transformar a factor para convertir a variables seudocuantitativas

clientes$SEXO = as.factor(clientes$SEXO)
clientes$REGION = as.factor(clientes$REGION)
clientes$CASADO = as.factor(clientes$CASADO)
clientes$AUTO = as.factor(clientes$AUTO)

str(clientes)

#*RETO* ----
# transformar todas las variables 'caracter' a 'factor'
# tapply, lapply ....

summary(clientes)

# crear una data, donde figure a las clientes mujeres
# con ingresos superiores a 24 mil y con hijos

#           clientes[ registros , columnas ]

clientes2 = clientes[clientes$SEXO=="FEMENINO" &
                       clientes$INGRESOS >= 24000 &
                       clientes$HIJOS>=1,]
summary(clientes2)


# crear una data, donde figure a las clientes mujeres
# con ingresos superiores a 24 mil, con hijos y que vivan
# en lima norte o lima este

clientes3 = clientes[clientes$SEXO=="FEMENINO" & 
                       clientes$INGRESOS >= 24000 &
                       clientes$HIJOS>=1 &
                       (clientes$REGION=="LIMA_NORTE" |
                          clientes$REGION=="LIMA_ESTE") ,]
summary(clientes3)

#Seleccionar con attach

attach(clientes)
clientes3_2 = clientes[SEXO=="FEMENINO" & 
                         INGRESOS >= 24000 &
                         HIJOS>=1 &
                         (REGION=="LIMA_NORTE" |
                            REGION=="LIMA_ESTE"), ]
summary(clientes3_2)
detach(clientes) #Quitar attach

rm(clientes3_2)

# borrar columna: df$columna1 = NULL

# Formas de seleccionar campos y registros ----

# Seleccionar la variable SEXO
head(clientes$SEXO)

head(clientes[,"SEXO"])

head(clientes[,3])

# Seleccionar las variables desde SEXO hasta CASADO

head(clientes[,"SEXO":"CASADO"]) # en python si sale
head(clientes[,c("SEXO","REGION","INGRESOS","CASADO")])

head(clientes[,3:6])
head(clientes[,3:6], 20)
tail(clientes[,3:6])

# Creacion de variables ----

# Crear la variable M1 = INGRESOS / (EDAD*10), en clientes

clientes$M1 = clientes$INGRESOS / (clientes$EDAD*10)


# Combinacion de datasets ----

band = read.csv("band.csv")
instrument = read.csv("instrument.csv")
band
instrument

library(dplyr)

left_join(band, instrument, by="name")

right_join(band, instrument, by="name")

inner_join(band, instrument, by="name")

full_join(band, instrument, by="name")

# REVISAR: outer join - inner join


# Importar Depositos_2016.csv y Depositos_2017.csv

dep2016 = read.csv("Depositos_2016.csv")
dep2017 = read.csv("Depositos_2017.csv")

dep_2016_2017 = rbind(dep2016, dep2017)


# Reestructurar datasets ----

paises = data.frame(country = c("FR", "DE", "US"),
                    a2011 = c(7000, 5800, 15000),
                    a2012 = c(6900, 6000, 14000),
                    a2013 = c(7000, 6200, 13000))
paises
str(paises)

library(tidyr)

paises2 = gather(paises, key = "años", value = "cant", 2:4)
paises2

paises3 = spread(paises2, key = "años", value = "cant")
paises3


# Agrupacion de datos ----

# calcular el minimo, maximo, promedio, suma, desviacion
# estandar y mediana de "cant" por "a?os", en la data paises2

str(paises2)

library(dplyr)

paises2_resumen1 = summarise(group_by(paises2, años), 
          cant_min = min(cant), 
          cant_max = max(cant), 
          cant_prom = mean(cant),
          cant_sum = sum(cant),
          cant_desv = sd(cant),
          cant_med = median(cant))

paises2_resumen1 = paises2 %>% group_by(años) %>% 
  summarize(cant_min = min(cant), 
            cant_max = max(cant), 
            cant_prom = mean(cant),
            cant_sum = sum(cant),
            cant_desv = sd(cant),
            cant_med = median(cant))

paises2_resumen1

# de "clientes", calcular el minimo, maximo, promedio y rango de 
# ingresos por sexo y region

clientes_calc <- clientes %>% 
  group_by(SEXO, REGION) %>% 
  summarise(Ingr_min = min(INGRESOS),
            Ingr_max = max(INGRESOS),
            Ingr_prom = mean(INGRESOS),
            Ingr_rang = Ingr_max - Ingr_min)

clientes_calc

clientes_rep = summarise(group_by(clientes, SEXO, REGION),
          Ingr_min = min(INGRESOS),
          Ingr_max = max(INGRESOS),
          Ingr_prom = mean(INGRESOS),
          Ingr_rango = (Ingr_max-Ingr_min))

clientes_rep

# exportar tablas agrupadas

write.csv(clientes_rep, 'cliente_rep_exp.csv', row.names = F)

#Para escribir un excel

install.packages("openxlsx")
library(openxlsx)

write.xlsx() 