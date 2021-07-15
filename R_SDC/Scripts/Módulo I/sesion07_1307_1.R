
# BALANCEO DE DATOS ---- 
#No corren los balanceos >>> Chequear el video de la sesion 7

setwd("D:/Desktop/UNMSM/SDC-Learning/R_SDC/Datasets1")

# Importar Modulo 1 de la encuesta anual Enaho 2019, del INEI

# Seleccionar ciertas columnas y registros

library(foreign)

enahoM01 = read.spss('Enaho01-2019-100.sav', to.data.frame = T)

enahoM01 = enahoM01[,c(1:14, 24:32, 34:37, 47:48, 58:59, 69:70, 
                       80:83, 131:133, 141, 191:193, 318:322)] 

enahoM01 = enahoM01[,c(15:18,20:21,25:26,31, 38:41)]


# 1. Distribucion categorias de variable objetivo ----

# P107B3	
# ?Ud. o alg?n miembro del hogar ha obtenido alg?n cr?dito o pr?stamo 
#  destinado a: Mejoramiento y/o ampliaci?n de la vivienda?

table(enahoM01$P107B3) # conteo de categorias excepto NA
table(enahoM01$P107B3)/sum(table(enahoM01$P107B3))

str(enahoM01$P107B3)
levels(enahoM01$P107B3)

# 2. Dividir data train y test ----

library(caTools)

set.seed(2021) #semilla
generar = sample.split(enahoM01$P107B3, #data$target
                       SplitRatio = 0.9) #proporcion de datos de entrenamiento

table(generar)
table(generar) / sum(table(generar))

#######################

data(iris)
head(iris)
table(iris$Species)

set.seed(2021) #semilla
generar = sample.split(iris$Species, #data$target
                       SplitRatio = 0.7) #proporcion de datos de entrenamiento

table(generar)
table(generar) / sum(table(generar))

#######################

d_entrenamiento = subset(enahoM01, generar == TRUE)
d_prueba = subset(enahoM01, generar == FALSE)

table(d_entrenamiento$P107B3)
table(d_entrenamiento$P107B3)/sum(table(d_entrenamiento$P107B3))

table(d_prueba$P107B3)
table(d_prueba$P107B3)/sum(table(d_prueba$P107B3))

# 70% train, 30% test

nrow(d_entrenamiento) / nrow(enahoM01)

library(ROSE)

# 3. Balanceo under-sampling ----

data.balanced1 = ovun.sample(P107B3 ~ ., #targe~.(ese punto significa que considere todas las var.)
                              data=d_entrenamiento, #data de entrenamiento
                              p=0.5, #proporcion de la etique menos representada
                              seed=2021, #semilla utilizada en casos aleatoridad
                              method="under",#metodo de balanceo
                              na.action=na.pass)
mode(data.balanced1)
class(data.balanced1)

ls(data.balanced1)
head(data.balanced1$data)

d_train_b = data.balanced1$data

nrow(d_entrenamiento)
nrow(d_train_b)

prop.table(table(d_entrenamiento$P107B3))
prop.table(table(d_train_b$P107B3))

# 4. Balanceo over-sampling ----

data.balanced2 = ovun.sample(P107B3 ~ ., #target~.
                              data=d_entrenamiento, #data de entrenamiento 
                              p=0.5, #proporcion que ahora representara la P107B3 minoritaria
                              seed=2021, #semilla
                              method="over",#metodo
                              na.action=na.pass)

d_train_b2 = data.balanced2$data

nrow(d_entrenamiento)
nrow(d_train_b2)

prop.table(table(d_entrenamiento$P107B3))
prop.table(table(d_train_b2$P107B3))


# 5. Balanceo combination of over- and under-sampling (both) ----

data.balanced3 = ovun.sample(P107B3 ~ ., #target~.
                              data=d_entrenamiento, #data de entrenamiento 
                              p=0.5, #proporcion para los datos de poca representacion
                              seed=2021, #semilla
                              method="both", #metodo
                              na.action=na.pass)

d_train_b3 = data.balanced3$data

nrow(d_entrenamiento)
nrow(d_train_b3)

prop.table(table(d_entrenamiento$P107B3))
prop.table(table(d_train_b3$P107B3))
