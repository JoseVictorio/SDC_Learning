


# OPERACIONES RELACIONALES ----
10 < 3
10 <= 3
10 > 3
10 >= 3
5 == 3 #5 es igual a tres? T o F
10 != 3 # 10 es diferente de 3

# OPERACIONES LOGICAS ----
FALSE | TRUE # "O"
TRUE | FALSE
TRUE & FALSE # "Y"
!TRUE #  ! negacion
isTRUE(TRUE)
TRUE + TRUE # 1 + 1
FALSE + FALSE # 0 + 0
TRUE + FALSE # 1 + 0 

# ASIGNACIONES ----

a = 10
b = 20
c <- 30
40 -> d
50 = e #Invalido
f = 60 ; 70 -> g ; h <- 80

rm(a) #Borrar <- a

# VECTORES NUMERICOS ----

v1 = c(2, 4, 6)
v1

v2 = c(1:20)
v2

v3 = seq(from=1, to=20, by=3)
v3

v4 = seq(from=1, to=20, length=7)
v4

v4[2] - v4[1] #Indexacion
v4[7] - v4[6]

round(v4, 1) #Redondear decimales
v4 #Se debe reasignar
v4 = round(v4, 1) #Reasignacion
v4

x = round(v4, 1)
x

v5 = rep(10, 5) #rep <- 10 se repite 5 veces
v5

# ARITMETICA DE VECTORES ----

v6 = c(1:5)
v6
v7 = c(6:10)
v7
v8 = c(6:11)
v8

v6 + v7
v6 + v8 #Diferentes dimensiones <- suma v6 1er + v8 6to
v6 - v8
v6 * v8
v6 / v8
round(v6 / v8, 2)

v8
sum(v8)
mean(v8)
min(v8)
max(v8)
sd(v8)


v9 = c(v8, NA) # not available
v9

sum(v9)
mean(v9)

sum(v9, na.rm = T)
mean(v9, na.rm = T)
min(v9, na.rm = T)
max(v9, na.rm = T)
sd(v9, na.rm = T)


# VECTORES LOGICOS ----

## Ej 1

v9

# ?cuales son los valores NA?
v10 = is.na(v9)
v10

## Ej 2

v11 = round(seq(from=1000,to=10000,length=100),1)
v11

# ?cuantos valores estan en el rango de 5000 a 8000?

vl = v11 >= 5000 & v11 <= 8000
vl

table(vl) #Tabla de frecuencias


# negando los valores logicos

vl_no = !vl
vl_no
table(vl_no)

# FIN DE PRIMERA CLASE ----

# VECTORES DE CADENA ----

## crear los valores "Prod1", "Prod2",...,"Prod10"

vc1 = paste(c("Prod"), 1:10, sep = "")
vc1

## crear los valores "Prod-1", "Prod-2",...,"Prod-10"

vc2 = paste(c("Prod"), 1:10, sep = "-")
vc2

paste(c("Prod"), v6, sep = "")
paste("Prod", v6, sep = "")

paste(c("caleb", "terrel"), v6, sep = "-")

paste(v6, v7, sep = "-")
paste(v6, v8, sep = "-")

## concatenar los valores anteriores en uno solo

vc3 = paste(c("Prod"), 1:10, sep = "-", collapse = "/")
vc3


# * conteo de caracteres ----

alumno = c("caleb", "terrel", "orellana")
alumno

nchar(alumno)

# * convertir a minusculas o mayusculas ----

tolower(alumno)

toupper(alumno)

# * reemplazar valores ----

# cambiar "a" por 8

chartr("a", "8", alumno)


# * extracci?n de caracteres ----

alumno = c("caleb", "terrel", "orellana")
alumno

substr(alumno, 2, 4)
substring(alumno, 2, 4)

substr(alumno, 1:3, 1:3)

substr(alumno, 1, 1:3)
substr(alumno, 2, 1:3)

# * intersecci?n de caracteres ----

c1 = c("hoy", "almorce", "chaufa")
c2 = c("hoy", "almorce", "arroz con pollo")
c3 = c("papa a la huancaina", "ma?ana", "almorce")
c1
c2
c3

intersect(c1, c3)

# * igualdad de caracteres ----

c1 = c("caleb", "terrel", "orellana")
c2 = c("terrel", "orellana", "caleb")
c3 = c("sandra", "terrel", "orellana")

setequal(c1, c2)
setequal(c1, c3)

# * igualdad exacta de caracteres ----

identical(c1, c2)

# INDEXACION DE VECTORES NUMERICOS ----

v12 = c(10:20, NA, 40:50, NA)
v12

## seleccionar los primeros 5 valores

v12[1:5]

## NO seleccionar los primeros 5 valores

v12[-(1:5)]

## seleccionar los ultimos 5 valores

n = length(v12)
n

v12[(n-4):n]

v12[20:24]

## seleccionar todos los valores excepto los NA

v12
is.na(v12)
!is.na(v12)

v12[!is.na(v12)]

## reemplazar el valor de NA por el promedio
## del vector

v12[is.na(v12)] = mean(v12, na.rm = T)
v12

# INDEXACION CON VECTORES DE CADENA ----

v13 = c(25, 2000, 5000, 0.7)
v13

names(v13) = c("edad", "ingresos", "deudas", "score")

v13

## seleccionar los valores de los ingresos y score

v13[c("ingresos", "score")]


# MATRICES ----

m1 = matrix(1:20, nrow=5, ncol=4, byrow = F)
m1

m2 = matrix(1:20, nrow=5, ncol=4, byrow = T)
m2

m3 = cbind(1:4,5:8,9:12)  # x columnas
m3

m4 = rbind(1:4,5:8,9:12) # x filas
m4

matrix(1:13, nrow=5, ncol=4, byrow = F)

nrow(m4)
ncol(m4)
dim(m4)

set.seed(123)
m5 = matrix(rpois(16,5), 4, 4)
m5

det(m5)


library(MASS)
ginv(m5)  # matriz inversa

eigen(m5)

m1 + m2
m1 - m2
m1 * m2 

# m1 .. 5x4
# m3 .. 4x3
m1 %*% m3

# m1 .. 5x4
# m2 .. 5x4
m1 %*% m2

# INDEXACION DE MATRICES ----

m1

## seleccionar el valor de 15 y reemplazarlo por 999

m1[5,3] = 999
m1
class(m1)

# ARRAYS ----

v1 = 1:42
v1

dim(v1) = c(7,3,2)
v1
class(v1)

# Indexacion de arrays ----

# seleccionar el valor 10

v1[3,2,1]

# seleccionar el valor 39

v1[4,3,2]

# seleccionar los valores 16 y 37

v1[2,3,]

# seleccionando todos los valores de las 3ras columnas
v1[,3,]

# DATAFRAMES ----

a = 1:10
a
b = paste("educ", 1:10, sep="-")
b
c = rnorm(10)
c

df = data.frame(a,b,c)
df

str(df)

library(tibble)

df2 = data_frame(a,b,c)  # tibble()
df2
str(df2)



d = c(rep(1,5), rep(2,5))
d

df = data.frame(df, d)
df

str(df)

df$d = as.factor(df$d)
str(df)

levels(df$d) = c("hombre", "mujer")
str(df)
df

# LISTAS ----

v1 = round(seq(from=15, to=50, length=20),1)
v1
m1 = matrix(rpois(20,5), nrow=5, ncol=4)
m1
df

lista_1 = list(v1, m1, df)
lista_1

length(lista_1)

