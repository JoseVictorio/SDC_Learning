
# ANALISIS DE COMPONENTES PRINCIPALES ----

setwd("D:/Desktop/UNMSM/SDC-Learning/R_SDC/Datasets1")

percep = read.csv("rintro-chapter8.csv")

head(percep)
tail(percep)

summary(percep)

aggregate(percep[, 1:9], list(percep$brand), mean)



# transformando los datos ----

percep_est = data.frame(scale(percep[,1:9]), brand = percep[,10])

summary(percep_est)

aggregate(percep_est[, 1:9], list(percep_est$brand), mean)

# matriz de correlaciones ----

round(cor(percep_est[,1:9]),4)

library(corrplot)

corrplot(cor(percep_est[,1:9]), order = "hclust")

percep_est_mean = aggregate(.~ brand, data = percep_est, mean)

head(percep_est_mean)
View(percep_est_mean)

# mapa de calor ----

library(gplots)
library(RColorBrewer)

row.names(percep_est_mean) = percep_est_mean[,1]

head(percep_est_mean)

heatmap.2(as.matrix(percep_est_mean[,-1]), col = brewer.pal(9, "GnBu"),
          trace = "none", key = F, dend = "none", main = "Percepciones de marcas")


# Analisis de Componentes principales ----

dim(percep_est)

dim(percep_est_mean)

percep_est_ACP = prcomp(percep_est[,1:9])
percep_est_ACP

length(percep_est_ACP)

percep_est_ACP[1]
percep_est_ACP[2]
percep_est_ACP[3]
percep_est_ACP[4]
percep_est_ACP[5]

summary(percep_est_ACP)

biplot(percep_est_ACP)


percep_est_mean_ACP = prcomp(percep_est_mean[,-1])
summary(percep_est_mean_ACP)
biplot(percep_est_mean_ACP)


# ANALISIS FACTORIAL EXPLORATORIO ----

# cantidad de factores a escoger ----

library(nFactors)

nScree(percep_est[,-10]) 

# A.F.E con 3 factores ----

percep_est_AFE = factanal(percep_est[,-10], factors = 3)
percep_est_AFE

length(percep_est_AFE)
ls(percep_est_AFE)
percep_est_AFE$loadings

heatmap.2(percep_est_AFE$loadings, col = brewer.pal(9, "Greens"),
          trace = "none", key = F, dend = "none", Colv = F,
          cexCol = 1.2, main = "Cargas de factores sobre percepciones")


# calcular las puntuaciones factoriales ----

percep_est_AFE = factanal(percep_est[,-10], factors = 3, scores = "Bartlett")
percep_est_AFE

ls(percep_est_AFE)

head(percep_est_AFE$scores)

percep_est_2 = data.frame(percep_est, percep_est_AFE$scores)
