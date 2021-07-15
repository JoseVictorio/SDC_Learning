
setwd("..")

# Importacion de datos ----

library(readxl)

##### leer la base de muerte materna

mm = read_excel("muertematerna.xlsx")

#### para ver el encabezado de la base de datos

head(mm)

##### para ver la estructura de la base de datos

str(mm)

?as.Date.character

# Transformacion de variables ----

mm$fecha_notificacion = as.Date.character(mm$fecha_notificacion,
                                          tryFormats = c("%d-%m-%Y", "%d/%m/%Y"))


mm$fecha_defuncion = as.Date.character(mm$fecha_defuncion,
                                       tryFormats = c("%d-%m-%Y", "%d/%m/%Y"))
str(mm)

mm$edad = as.integer(mm$edad)
mm$ano = as.integer(mm$ano)
mm$semana = as.integer(mm$semana)

mm$institucion = as.factor(mm$institucion)
mm$diresa = as.factor(mm$diresa)
mm$nom_eess = as.factor(mm$nom_eess)
mm$nom_depar = as.factor(mm$nom_depar)
mm$nom_provi = as.factor(mm$nom_provi)
mm$nom_ubigeo = as.factor(mm$nom_ubigeo)

str(mm)

summary(mm)

# Crear variables de mes y año 

# options(repos = c(CRAN = "http://cran.rstudio.com"))

library(lubridate)

mm$mes_defun = month(mm$fecha_defuncion)
mm$año_defun = year(mm$fecha_defuncion)

mm$año_mes_def = format(mm$fecha_defuncion, "%Y-%m")

str(mm)

summary(mm)

t = table(mm$institucion)
t
#prop.table(t,1)  # % filas
#prop.table(t,2)  # % columnas
(prop.table(t))*100  # % total

# Eliminar NA y seleccionar ESSALUD y MINSA (más representativo) ----

mm2 = mm[!is.na(mm$institucion),]
summary(mm2)

mm2 = mm2[mm2$institucion=="ESSALUD"|mm2$institucion=="MINSA",]
summary(mm2)

# Estructura de datos segun skimr ----

library(skimr)
skim(mm2)

#library(expss)
#cro(mm2$nom_depar, mm2$institucion)

table(mm2$nom_depar, mm2$institucion)

# Cantidad de defunciones x diresa

library(dplyr)

mm2_dire_ndef = summarise(group_by(mm2, diresa), n_defun = n())
View(mm2_dire_ndef)

## orden descendente x n_defun
mm2_dire_ndef = arrange(mm2_dire_ndef, desc(n_defun))
View(mm2_dire_ndef)

library(ggplot2)

# Tendencia de muertes mensual en todos los diresa
mm2_dire_ndef2 = summarise(group_by(mm2,diresa, año_mes_def), n_muertes= n())

ggplot(mm2_dire_ndef2, aes(x=año_mes_def, y=n_muertes, color=diresa,group=1))+ 
  geom_point() + geom_line() + labs(title="Cantidad de defunciones") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1), legend.position = "none") +
  facet_wrap(~diresa)


# Tendencia de muertes en diresa con mayor cantidad de defunc (Loreto)
mm2_Loreto = summarise(group_by(mm2[mm2$diresa=="LORETO",],año_mes_def), n_muertes= n())
View(mm2_Loreto)

ggplot(mm2_Loreto, aes(x=año_mes_def, y=n_muertes, group=1))+ geom_point() + geom_line()+
  labs(title="Cantidad de defunciones en Loreto") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  scale_y_continuous(breaks = seq(min(mm2_Loreto$n_muertes), 
                                  max(mm2_Loreto$n_muertes), by = 1))


# Tendencia de muertes en diresa con 2do mayor cantidad de defunc (DIRIS LIMA CENTRO)
mm2_LimaCentro = summarise(group_by(mm2[mm2$diresa=="DIRIS LIMA CENTRO",],
                                    año_mes_def), n_muertes= n())

ggplot(mm2_LimaCentro, aes(x=año_mes_def, y=n_muertes, group=1))+ geom_point()+geom_line()+
  labs(title="Cantidad de defunciones en Lima Centro") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  scale_y_continuous(breaks = seq(min(mm2_LimaCentro$n_muertes), 
                                  max(mm2_LimaCentro$n_muertes), by = 1))

