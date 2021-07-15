

# 1. Importar Enaho01-2019-100.sav ----


enahoM01 = 

# seleccionar los campos:
  
enahoM01 = enahoM01[,c(8,13,24, 30, 35, 141, 191)] 

summary(enahoM01)

# 2. Seleccionar encuestas completas ----

# RESULT: Completa


# 3. Convertir los NA de P1172.12 en cero ----

# tip: usar ifelse()


# 4. Crear una variable que sea el Porcentaje del Gasto de Celular ----

# crear la variable con el nombre: PorcGastCel
# calculo: (P1172.12 / P117T2)*100
# gasto celular: P1172.12
# gasto total: P117T2


# 5. Eliminar filas cuando PorcGastCel tenga valores NA ----


# 6. Crear un grafico boxplot de PorcGastCel segun DOMNIO ----
# para visualizar atipicos


# 7. Crear una variable que identifique a los valores atipicos de PorcGastCel

# crear la variable con el nombre: PorcGastCel_Atip
# utilizar la funcion IQR
iqrscore = function(x) {
  return(x < quantile(x, 0.25) - 1.5 * IQR(x) | 
           x > quantile(x, 0.75) + 1.5 * IQR(x))
}
# la variable debe tener dos valores: 1 cuando es atipico y 0 cuando no lo es
# tip: usar ifelse()


# 8. ¿Cual es el porcentaje de valores atipicos? ----

