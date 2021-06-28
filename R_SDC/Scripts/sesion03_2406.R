

# OPERACIONES RELACIONALES ----
10 < 3
10 <= 3
10 > 3
10 >= 3
10 == 3 #5 es igual a tres? T o F
10 != 3 # 10 es diferente de 3

# OPERACIONES LOGICAS ----

FALSE | TRUE
TRUE | FALSE
TRUE & FALSE
!TRUE #  ! negacion
isTRUE(TRUE)
isTRUE(FALSE)
isTRUE(10 < 3)

TRUE + TRUE # 1 + 1
FALSE + FALSE # 0 + 0
TRUE + FALSE # 1 + 0 

# ASIGNACIONES ----

a = 10
b = 20
c <- 30
40 -> d
50 = e
f = 60 ; 70 -> g ; h <- 80

rm(a)
a == 10 # ?a realmente es igual a 10?


# VECTORES NUMERICOS ----

v1 = c(2, 4, 6)
v1

v2 = c(1:20)
v2

v3 = seq(from=1, to=20, by=3)
v3

v4 = seq(from=1, to=20, length=7)
v4

v4[2] - v4[1]
v4[7] - v4[6]

round(v4, 1)

v4 # sigue teniendo 6 decimales, si quiero q tenga 1 decimal, debo reasignar

v4 = round(v4, 1) # reasignando o actualizando el v4 con un decimal
v4

v5 = rep(10, 5)
v5


# ARITMETICA DE VECTORES ----

v6 = c(1:5)
v6
v7 = c(6:10)
v7
v8 = c(6:11)
v8

v6 + v7
v6 + v8
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

v8
mode(v8)
class(v8)

is.na(v8) # genera valores True o False
is.numeric(v8) # genera una sola respuesta, True o False
is.integer(v8) # genera una sola respuesta, True o False


## Ej 2

v11 = round(seq(from=1000,to=10000,length=100),1)
v11

# ?cuantos valores estan en el rango de 5000 a 8000?

vl = v11 >= 5000 & v11 <= 8000
vl

table(vl)


# negando los valores logicos

vl_no = !vl
vl_no
table(vl_no) ######################### FIN SESION 1

# VECTORES DE CADENA ----

a = c("caleb", "terrel", "orellana")
mode(a)

b = rep("A", 20)
b

## crear los valores "Prod1", "Prod2",...,"Prod10"

vc1 = paste(c("Prod"), 1:10, sep = "")
vc1

## crear los valores "Prod-1", "Prod-2",...,"Prod-10"

vc2 = paste(c("Prod"), 1:10, sep = "-")
vc2

paste(c("Prod"), v6, sep = "")
paste("Prod", v6, sep = "")

paste(c("A", "B"), v6, sep = "-")

paste(v6, v7, sep = "-")
paste(v6, v8, sep = "-")

## concatenar los valores anteriores en uno solo

vc3 = paste(c("Prod"), 1:10, sep = "-", collapse = "/")
vc3


# * conteo de caracteres ----

alumno = c("Caleb", "Terrel", "Orellana")
alumno

nchar(alumno)

# * convertir a minusculas o mayusculas ----

tolower(alumno)

toupper(alumno)

# * reemplazar valores ----

# reemplazar "a" por 8

chartr("a", "8", alumno)


# * extracci?n de caracteres ----

alumno = c("caleb", "terrel", "orellana")
alumno

substr(alumno, 2, 4)
substring(alumno, 2, 4)

substr(alumno, 1:3, 1:3)
#            1,2,3  1,2,3   
#           1,1  2,2  3,3    

substr(alumno, 1, 1:3)
#             1   1,2,3
#         1,1  1,2  1,3

substr(alumno, 2, 1:3)
#             2   1,2,3
#            2,1  2,2  2,3


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
# siempre se selecciona los valores en las posiciones de TRUE


# seleccionar a los valores mayores a 35

v13 = seq(10, 50, by=2)
v13

v13 >= 35 # ?qu? valores son mayor o igual a 35?

v13[v13 >= 35]


## reemplazar el valor de NA por el promedio del vector

v12
mean(v12)
mean(v12, na.rm = T)

# 1ro seleccionar a los NA, luego reemplazarlos x el promedio

is.na(v12)
v12[is.na(v12)]

v12[is.na(v12)] = mean(v12, na.rm = T)
v12


# INDEXACION CON VECTORES DE CADENA ----

v13 = c(25, 2000, 5000, 0.7)
v13

names(v13) = c("edad", "ingresos", "deudas", "score")

v13

## seleccionar los valores de los ingresos y score

v13[c("ingresos", "score")]


## 

c(1:10, rep('ABC', 5))

mode(c(1:10, rep('ABC', 5)))


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

cbind(1:4, 5:8, 9:15)

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

m1 ; m2

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


matrix(c(1:3, rep('A',3)), 3, 2)


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

id = 1:10
id
nivel_educ = c(rep('tecnico',3), rep('universitario',7))
nivel_educ
salario = rpois(10, 1500)
salario

df = data.frame(id, nivel_educ, salario)
df

viaje_extranjero = rep('si',4)
viaje_extranjero

df = data.frame(df, viaje_extranjero)  # no crea el campo
df

df2 = cbind(df, viaje_extranjero) # no crea el campo
df2

str(df)

# otra forma de crear un data frame con caracteristicas adicionales

library(tibble)

df2 = data_frame(id, nivel_educ, salario)  # tibble()
df2

str(df2)

# creando columnas de tipo factor

genero = c(rep(1,5), rep(2,5))
genero

df = data.frame(df, genero)
df

str(df)

# convertir de num a factor (variables cualitativas)

df$genero = as.factor(df$genero)
str(df)

# cambiar de nombre a los niveles del factor 

levels(df$genero) = c("hombre", "mujer")
str(df)

df

attributes(df$genero) ######### FIN SESION 2----

# LISTAS ----

v1 = round(seq(from=15, to=50, length=20),1)
v1
m1 = matrix(rpois(20,5), nrow=5, ncol=4)
m1
df

lista_1 = list(v1, m1, df)
lista_1

length(lista_1) #N° de elementos de la lista


# Indexacion en Listas ----

# de la lista obtener la matriz m1

a = lista_1[2]
a
class(a) # ?realmente es una matriz?

a2 = lista_1[[2]]
a2
class(a2)

# obtener de la lista el vector v1

lista_1[[1]]
class(lista_1[[1]])

# seleccionar los primeros 8 valores de v1

lista_1[[1]][1:8]

lista_1[1][1:8]  # NO VA SALIR


# ESTRUCTURAS DE CONTROL ----

# IF ----

x = 6
if(x > 5){
  y = TRUE
}
y

rm(y)

x = 6
if(x > 5){
  y = 'hola'
}
y


x = 6
if(x > 5){w = TRUE}
w

rm(y)

x = 3
if(x > 5){
  y = TRUE
}
y

# IF ELSE ----

x = 3
if(x > 5){
  y = TRUE
} else {
  y = FALSE
}
y

rm(y)

x = 3
if(x > 5){y = TRUE} else {y = FALSE}
y

rm(y)
x = 3
if(x > 5){y = TRUE} else 
{y = FALSE}
y


rm(y)
x = 3
if(x > 5){y = TRUE} 
else {y = FALSE}
y


# IF ELSE anidado ----

x = 5
y = 15

if(x == y){
  cat("iguales")
} else if (x < y){
  cat("x menor a y")
} else {
  cat("x mayor a y")
}

# IFELSE ----

#x = runif(1)
x = 0.1

ifelse(x > 0.5, "mayor", "menor")


# SWITCH ----

x = 1:10
x
type = "min"
switch(type,
       min = min(x),
       median = median(x),
       sd = sd(x))

type = "median"
switch(type,
       min = min(x),
       median = median(x),
       sd = sd(x))

x = switch(3, "a", "b", "c")
print(x)
x

x = switch(3, 1:5, 6:10, matrix(1:20,4,5))
x

# REPEAT & BREAK ----

# este blucle no tiene fin
count = 0
repeat{
  print(count)
  count = count + 1
}


# este bucle si tiene fin
count = 0
repeat{
  print(count)
  count = count + 1
  if(count == 30) break   # aqui se detiene el bucle
}



# FOR ----

for(i in 1:5){
  print(i)
}

for(i in 1:5){
  i             # no se mostrara ningun resultado
}

v = LETTERS[1:10]
v

for(i in v){
  print(i)
}

# el factorial de un numero

# factorial de 1 = 1
# factorial de 2 = 2*1
# factorial de 3 = 3*2*1
# factorial de 4 = 4*3*2*1
# factorial de 5 = 5*4*3*2*1
# factorial de 6 = 6*5*4*3*2*1

n = 6
n_fact = 1
for(i in 1:n){
  n_fact = n_fact * i
}
n_fact

# Imprimir los valores de una matriz segun el orden
# por filas y columnas

x = matrix(1:6, 2, 3)
x

# Manual
print(x[1,1])
print(x[1,2])
print(x[1,3])
print(x[2,1])
print(x[2,2])
print(x[2,3])

#Con iteraciones
nrow(x)
ncol(x)

for(i in 1:nrow(x)){
  for(j in 1:ncol(x)){
    print(x[i,j])
  }
}



1:nrow(x)
seq_len(nrow(x))

1:ncol(x)
seq_len(ncol(x))

for(i in seq_len(nrow(x))){
  for(j in seq_len(ncol(x))){
    print(x[i,j])
  }
}


# Encontrar los indices de un valor especifico
# de una matriz

x = matrix(1:6, 2, 3)
x

valor = 4

for(i in 1:nrow(x)){
  for(j in 1:ncol(x)){
    if(x[i, j] == valor){
      indices = c(i, j)
      print(indices)
    }
  }
}


valor = 2
for(i in seq_len(nrow(x))){
  for(j in seq_len(ncol(x))){
    if(x[i, j] == valor){
      indices = c(i, j)
      print(indices)
    }
  }
}


# WHILE ----

count = 0

while(count < 10){
  print(count)
  count = count + 1
}

# FUNCIONES ----

# ejemplo de funcion rnorm con argumentos predeterminados
rnorm(30)

# ejemplo de funcion rnorm con argumentos modificados

set.seed(24) #  Plantar semilla

#      n  mean  sd .. orden correcto de argumentos
rnorm(30 , 10  , 5)

#      n   sd  mean .. orden asumido incorrectamente
rnorm(30 , 5  , 10)

set.seed(24)
rnorm(mean = 10, n = 30, sd = 5)


# *Con argumentos ----

# Crear una funci?n que devuelva el cuadrado de un vector numerico secuencial (1:n)
# el vector secuencial tiene que ser numerico y positivo

funcion1 = function(a){
  for(i in 1:a){
    b = i^2
    print(b)
  }
}

funcion1(5)
funcion1(5,3) # , NO es un decimal
funcion1(3.2) # . es un decimal

1:3.2
1:3.6

# *Sin argumentos ----

funcion2 = function(){
  for(i in 1:4){
    print(i^2)
  }
}

funcion2()
funcion2(5)

# *Argumentos predeterminados ----

funcion3 = function(a=3, b=6){
  c = a*b
  print(c)
}

funcion3()
funcion3(5, 10)


# *Solucion de funcion cuadratica ----

fun_cuad = function(a, b, c){
  if(b^2-4*a*c == 0){
    sol1 = -b/(2*a)
    print(sol1)
  } else if(b^2-4*a*c < 0){
    print("la ecuacion no tiene sol. reales")
  } else {
    sol1 = (-b-sqrt(b^2-4*a*c))/(2*a)
    sol2 = (-b+sqrt(b^2-4*a*c))/(2*a)
    c(sol1, sol2)
  }
}

fun_cuad(1,2,1)
fun_cuad(2,1,2)
fun_cuad(1,3,1)

getwd() # directorio de trabajo

# setwd("F:/Cursos/SDC/P de Espec en R 2021....")
# setwd("F:\\Cursos\\SDC\\P de Espec en R 2021....")

# setwd('D:/CONSULTORIA/FINANCIERO')

# Session / Set Working Directory / Choose Directory...


# Guardar los objetos creados en R
save.image("objetos1.RData")

# Cargar los objetos
load("objetos1.RData")



