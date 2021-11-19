library(dplyr)
library(ggplot2)
library(forcats)

data(gss_cat)
head(gss_cat)

maritalg <- gss_cat %>% ggplot()
maritalg <- maritalg + geom_bar(aes(marital))

ggsave('maritalg.png', maritalg)

print(levels(gss_cat$marital))


#Gráfico de barras de factores por orden de frecuencia
gss_cat <- gss_cat %>% mutate(
marital = marital %>% fct_infreq())

maritalg <- gss_cat %>% ggplot()
maritalg <- maritalg + geom_bar(aes(marital))

ggsave('maritalg.png', maritalg)

#
gss_cat <- gss_cat %>% mutate(
marital = fct_recode(marital,
'M' = 'Married',
'NM' = 'Never married',
'D' = 'Divorced',
'W' = 'Widowed',
'S' = 'Separated',
'N' = 'No answer'
))

head(gss_cat)

maritalg <- gss_cat %>% ggplot()
maritalg <- maritalg + geom_bar(aes(marital))

ggsave('maritalg.png', maritalg)
#### Un primer ANOVA
datos <- gss_cat %>% filter(!is.na(tvhours))
head(datos)

fit_aov <- aov(tvhours ~ race, data = datos)
summary(fit_aov)

mi_pred <- predict(fit_aov, se.fit = TRUE)

datos <- datos %>% mutate(tvhourpred = mi_pred$fit,
sefit = mi_pred$se.fit)
head(datos)

aov_dataplot <- datos %>% group_by(race) %>% summarize(
prediccion = mean(tvhourpred),
error = mean(sefit))

head(aov_dataplot)

aov_plot <- aov_dataplot %>% ggplot(aes(
race, prediccion, ymin = prediccion - 2*error, 
ymax = prediccion + 2*error))
aov_plot <- aov_plot + geom_errorbar()

ggsave('aov_plot.png', aov_plot)

mi_vector <- c('a', 'b')
###Bucles o Iteraciones
#for (counter in VECTOR){

for (i in mi_vector){
	print(i)
}

counter <- 0
# while (condicion)
while (counter < 10){
	print(counter)
	counter <- counter + 1
}

#
datos <- as.data.frame(datos)

columnas <- c('year', 'age', 'tvhours')
promedios <- vector()
for (cname in columnas){
	print(mean(datos[,cname], na.rm=T))
}








