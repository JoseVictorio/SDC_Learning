
# 1. Importar WB-DATA.csv y WB-METADATA.csv ----


df1 = 
df2 = 

# 2. Crear una tabla, que sea la union (inner_join) de las dos tablas anteriores  ----

# nota: la variable llave en ambas tablas es series_id


df12 = 

# 3. ¿Cuantos indicadores (series_id) unicos tiene df12? ----


# 4. ¿Cuantos registros tiene cada indicador? ----



# 5. Crear una data, que considere la siguiente seleccion de registros: ----

# series_id: VC.IHR.PSRC.P5
# country_name: Peru y Brazil
# year: mayor o igual a 2008

df3 = 
  
# 6. ¿Qué significa el indicador VC.IHR.PSRC.P5? ----


# 7. En la data, ordenar los registros por country_name y year (ascendente) ----

# tip: usar arrange()

df3 = 


# 8. En la data, redondear value a dos decimales ----


# 9. Hacer un grafico de lineas (tendencia) de value por año y pais ----

# tip: revisar el script: Caso_TendenciaMuertes.R , en la ultima parte
# se desarrollan diversos graficos de lineas (tendencia)


