
setwd("D:/Desktop/UNMSM/SDC-Learning/R_SDC/Datasets1")

# Importar Modulo 1 de la encuesta anual Enaho 2019, del INEI

# Seleccionar ciertas columnas y registros

library(foreign)

enahoM01 = read.spss('Enaho01-2019-100.sav', to.data.frame = T)

enahoM01 = enahoM01[,c(1:14, 24:32, 34:37, 47:48, 58:59, 69:70, 
                       80:83, 131:133, 141, 191:193, 318:322)] 

enahoM01 = enahoM01[,c(15:18,20:21,25:26,31, 38:41)]

str(enahoM01)
summary(enahoM01)

table(enahoM01$P107B3) # conteo de categorias excepto NA
table(enahoM01$P107B3)/sum(table(enahoM01$P107B3))


# LIMPIEZA DE DATOS ----

# * Identificacion de NA ----

summary(enahoM01)

library(skimr)
skim(enahoM01)

# 1. Seleccionar variables con completitud > 77% ----

s = skim(enahoM01)
mode(s)
class(s)
str(s)

variab_comp = s[s$complete_rate > 0.77, 2:4]
head(variab_comp)

variab_comp$skim_variable

enahoM01_comp77 = enahoM01[,variab_comp$skim_variable]


# 1. Reemplazar NA por media  ----

library(simputation)

summary(enahoM01[,c('P1172.01', 'P1172.02')])

enahoM01_impMedia = impute_lm(enahoM01, P1172.01 + P1172.02 ~ 1) #Imputacion por la media

summary(enahoM01_impMedia[,c('P1172.01', 'P1172.02')])


# 2. Reemplazo NA por moda ----

summary(enahoM01[,'P101'])

library(modeest)

mfv1(enahoM01$P101) # moda

enahoM01_2 = enahoM01 # copia de data

enahoM01_2[is.na(enahoM01_2$P101),'P101'] = mfv1(enahoM01$P101)  

summary(enahoM01_2[,'P101'])


# 3. Reemplazar NA media segun una variable categorica ----

summary(enahoM01_2[,c('P1172.01', 'P1172.02', 'P101')])

enahoM01_2_impMedia_Categ = impute_lm(enahoM01_2, P1172.01 + P1172.02 ~ 1| P101)

summary(enahoM01_2_impMedia_Categ[,c('P1172.01', 'P1172.02', 'P101')])


# 4. Reemplazar NA modelo regresion ----

summary(enahoM01[,c('P1172.01', 'P1172.02')])

enahoM01_impMedia_Regr = impute_lm(enahoM01, P1172.02 ~ P1172.01) #Imputacion por la media

summary(enahoM01_impMedia_Regr[,c('P1172.01', 'P1172.02')])


# * Identificacion y remplazo de Outliers ----

library(ggplot2)

ggplot(enahoM01, aes(x="gasto agua" , y=P1172.01)) + geom_boxplot()

# 1. Identif. x Desviaciones estandar ----

set.seed(2021)
v1 = rnorm(1000)
summary(v1)
hist(v1)

zscore = function(x,k) {
  return(abs(scale(x)) > k)
}

# eliminar valores NA
enahoM01_3 = na.omit(enahoM01)

head(zscore(enahoM01_3$P1172.01,3))
table(zscore(enahoM01_3$P1172.01,3))

# seleccionando los primeros valores atipicos
head(enahoM01_3[zscore(enahoM01_3$P1172.01,3),])

# creando otra data sin valores atipicos
enahoM01_3_SinAtip = enahoM01_3[!zscore(enahoM01_3$P1172.01,3),]


# 2. Identif. x Rango Intercuartil ----

iqrscore = function(x) {
  return(x < quantile(x, 0.25) - 1.5 * IQR(x) | 
           x > quantile(x, 0.75) + 1.5 * IQR(x))
}

# seleccionando los primeros valores atipicos
head(enahoM01_3[iqrscore(enahoM01_3$P1172.01),])

# creando otra data sin valores atipicos
enahoM01_3_SinAtip2 = enahoM01_3[!iqrscore(enahoM01_3$P1172.01),]


# 3. Eliminar datos outliers ----

# 4. Reemplazar datos outliers por los limites del diagrama de cajas----


# DISCRETIZACION DE DATOS ----

# * Discretizacion No Supervisada ----

# 1. Discret. Interv. Igual ancho, rango o amplitud ----

library(skimr)
skim(enahoM01$P1172.01)
hist(enahoM01$P1172.01)

sturges_nbins = nclass.Sturges(enahoM01$P1172.01) #Regla de Sturges para discr.
#Crea intervalos de variables cuantitativas
sturges_nbins #Cantidad de intervalos, por fórmula de Sturges

library(arules) #Para correr la función discretize()

enahoM01$P1172.01_sturges = discretize(enahoM01$P1172.01, #valores a discretizar
                              method="interval", #metodo de intervalos de igual amplitud
                              breaks= sturges_nbins) #puntos c

table(enahoM01$P1172.01_sturges)


# 2. Discret. Interv. Igual frecuencia (cuantiles) ----

enahoM01$P1172.01_cuantil = discretize(enahoM01$P1172.01, #valores
                           method="frequency", #metodo: intervalos de igual frecuencia 
                           breaks= 4) #numero de categorias, cuantile 25, 50, 75, 100

table(enahoM01$P1172.01_cuantil) #Solo salen 3 intervalos por la cantidad de 00.
table(enahoM01$P1172.01_cuantil) / sum(table(enahoM01$P1172.01_cuantil))

# creando otra data pero con valores mayores a cero
enahoM01_4 = enahoM01[enahoM01$P1172.01 > 0 & !is.na(enahoM01$P1172.01),]
summary(enahoM01_4$P1172.01)

enahoM01_4$P1172.01_cuantil = discretize(enahoM01_4$P1172.01, #valores
                                       method="frequency", #metodo: intervalos de igual frecuencia 
                                       breaks= 4) #numero de categorias

table(enahoM01_4$P1172.01_cuantil)
table(enahoM01_4$P1172.01_cuantil) / sum(table(enahoM01_4$P1172.01_cuantil))
