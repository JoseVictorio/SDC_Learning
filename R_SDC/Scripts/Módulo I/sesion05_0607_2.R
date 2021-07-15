
# ENTENDIMIENTO DE DATOS ----

setwd("F:/Cursos/SDC/P de Espec en R 2021/Modulo1/datasets")

# Importar Modulo 1 y 2 del enahoM01-2019-anual

# Seleccionar ciertas columnas y registros

install.packages("foreign")
library(foreign)

enahoM01 = read.spss('Datasets1/Enaho01-2019-100.sav', to.data.frame = T)
#enahoM02 = read.spss('687-Modulo02/Enaho01-2019-200.sav', to.data.frame = T)

enahoM01 = enahoM01[,c(1:14, 24:32, 34:37, 47:48, 58:59, 69:70, 
                        80:83, 131:133, 141, 191:193, 318:322)] 

#enahoM02 = enahoM02[,c(1:15, 18:19, 21)]

# seleccionar encuestas completas

table(enahoM01$RESULT)
table(enahoM01$RESULT)/sum(table(enahoM01$RESULT))

enahoM01 = enahoM01[enahoM01$RESULT == 'Completa',]


# Resumenes estadisticos ----

str(enahoM01)

summary(enahoM01)

library(psych)
describe(enahoM01) # espacio en console

library(skimr)
skim(enahoM01) # espacio en console

head(enahoM01$NOMCCPP)
tail(enahoM01$NOMCCPP)


#library(devtools)
library(visdat)

vis_miss(enahoM01, warn_large_data = F)
vis_dat(enahoM01, warn_large_data = F)


library(VIM)
aggr(enahoM01)

# Num. valores perdidos en la base de datos ----

head(is.na(enahoM01))
sum(is.na(enahoM01))

# Num. de valores perdidos por columna ----

Colna = colSums(is.na(enahoM01))
Colna
sort(Colna, decreasing = T)

# Num. de valores perdidos por filas ----

Filna = rowSums(is.na(enahoM01))
head(Filna, 50)

summary(Filna)

# Mostrar las columnas que tienen valores perdidos ----

colSums(is.na(enahoM01))
colSums(is.na(enahoM01)) > 0

head(enahoM01[,colSums(is.na(enahoM01)) > 0])

F + F
F + T
T + T

# explorar los datos del dataset enahoM01

# P101: tipo de vivienda
# P103: material en los pisos
# P104: nro habitaciones x vivienda
# P105B: monto mensual por alquiler o compra de la vivienda
# P1172$01: gasto mensual consumo agua
# P1172$02: gasto mensual consumo electricidad
# P1172$12: gasto mensual consumo celular


library(ggplot2)
library(plotly)

# Histograma ----

# Graficar la distribuci?n del gasto mensual del consumo agua

ggplot(enahoM01,aes(x=P1172.01)) + geom_histogram()

# creando enahoM01_2 ...
summary(enahoM01$P1172.01)

enahoM01_2 = enahoM01[enahoM01$P1172.01 > 0,]
summary(enahoM01_2$P1172.01)

ggplot(enahoM01_2,aes(x=P1172.01)) + geom_histogram(color="black", fill="green")

ggplotly(ggplot(enahoM01_2,aes(x=P1172.01)) +
           geom_histogram(color="red", fill="yellow"))

# graficar la distribucion mensual del consumo de
# de agua, pero por tipo de vivienda

table(enahoM01_2$P101)

ggplot(enahoM01_2,aes(x=P1172.01,fill=P101))+geom_histogram()
ggplotly(ggplot(enahoM01_2,aes(x=P1172.01,fill=P101))+geom_histogram())

ggplot(enahoM01_2,aes(x=P1172.01))+geom_histogram()+facet_grid(.~P101)
ggplotly(ggplot(enahoM01_2,aes(x=P1172.01))+geom_histogram()+facet_grid(.~P101))
ggplotly(ggplot(enahoM01_2,aes(x=P1172.01))+geom_histogram()+facet_wrap(~P101))

# Diagramas de cajas ----

# graficar la distribucion mensual del consumo de agua

ggplot(enahoM01_2,aes(x="gasto mensual agua",y=P1172.01))+geom_boxplot()
ggplotly(ggplot(enahoM01_2,aes(x="gasto mensual agua",y=P1172.01))+geom_boxplot())


# graficar la distribucion mensual del consumo de
# de agua, pero por tipo de vivienda

ggplot(enahoM01_2,aes(x=P101,y=P1172.01))+geom_boxplot()
ggplotly(ggplot(enahoM01_2,aes(x=P101,y=P1172.01))+geom_boxplot())

ggplot(enahoM01_2,aes(x=P101,y=P1172.01,fill=P101))+geom_boxplot()
ggplotly(ggplot(enahoM01_2,aes(x=P101,y=P1172.01,fill=P101))+geom_boxplot())


# Dispersion ----

# graficar la relacion entre el consumo de agua y electricidad

summary(enahoM01_2$P1172.02)

enahoM01_3 = enahoM01_2[enahoM01_2$P1172.02 > 0,]

summary(enahoM01_3$P1172.02)

ggplot(enahoM01_3,aes(x=P1172.01, y=P1172.02))+geom_point()

ggplot(enahoM01_3,aes(x=P1172.01, y=P1172.02))+geom_point()+
  stat_smooth(method = "lm")

# graficar la relacion entre el consumo de agua
# y electricidad, por tipo de vivienda

ggplot(enahoM01_3,aes(x=P1172.01, y=P1172.02))+geom_point()+
  stat_smooth(method = "lm")+facet_grid(.~P101)

ggplotly(ggplot(enahoM01_3,aes(x=P1172.01, y=P1172.02))+geom_point()+
           stat_smooth(method = "lm")+facet_grid(.~P101))

ggplot(enahoM01_3,aes(x=P1172.01, y=P1172.02))+geom_point()+
  stat_smooth(method = "lm")+facet_wrap(~P101)



# Matrices de dispersion ----

library(GGally)

# visualizar las relaciones de consumos de agua, electricidad y celular

summary(enahoM01_3$P1172.12)
enahoM01_4 = enahoM01_3[enahoM01_3$P1172.12 > 0,]
summary(enahoM01_4$P1172.12)

ggpairs(enahoM01_4, columns = c("P1172.01", "P1172.02", "P1172.12"))

# visualizar las relaciones de consumos de agua, electricidad
# y celular, por tipo de vivienda

#enahoM01_5 = enahoM01_4[enahoM01_4$P101 != 'Choza o caba?a',]
#table(enahoM01_5$P101)

ggpairs(enahoM01_4, columns = c("P1172.01", "P1172.02", "P1172.12"),
        mapping = aes(color=P101))

table(enahoM01_4$P101)
summary(enahoM01_4$P101)

# otros tripos de graficos

enahoM01_5 = na.omit(enahoM01_4[,c("P1172.01", "P1172.02", "P1172.12", 'P101')])

ggpairs(enahoM01_5, mapping = aes(color=P101, alpha=0.5))

ggpairs(enahoM01_5, mapping = aes(color=P101, alpha=0.5), 
        lower = list(continuous ='smooth'))


# Diagrama de barras ----

# graficar la distribuci?n de los tipos de vivienda

ggplot(enahoM01_5, aes(x=P101)) + geom_bar()

# graficar la distribuci?n de los tipos de vivienda, segun 
# el material de los pisos

summary(enahoM01_4$P103)

enahoM01_6 = na.omit(enahoM01[,c('P101','P103')])

ggplot(enahoM01_6, aes(x=P101, fill=P103)) + geom_bar()

ggplotly(ggplot(enahoM01_6, aes(x=P101, fill=P103)) + geom_bar())
