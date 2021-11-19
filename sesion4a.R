library(nycflights13)
library(dplyr)

data(flights)

##BREVE EXPLICACIÓN DE COMO FUNCIONA LA SELECCIÓN
##SLICES

mi_vector <- c(5,4,3,2,1)
seleccion <- c(F,T,F,F,F)

print(mi_vector)
#Hay dos formas de seleccionar elementos de R
#1) Por posición
print(mi_vector[2])
#2) Indicando cuáles sí y cuáles no
print(mi_vector[seleccion])

#El método 2 es útil para hacer selecciones condicionadas
cond <-(mi_vector > 3) & (mi_vector < 5)
print(mi_vector[cond])
#El método 1 permite hacer selecciones por índices. 
#El comando seq(1,3,1) se puede cambiar por 1:3
print(mi_vector[seq(1,3,1)])

###################
###El método clásico
flight <- group_by(flights, year, month, day) 
resumen <- summarize(flight, 
retraso_medio = mean(arr_delay, na.rm = T),
retraso_medio_sin_sesgo = mean(arr_delay[arr_delay > 0], 
na.rm = T))

head(resumen)

#Lo mismo con tuberías
resumen_t <- flights %>% group_by(year, month, day) %>%
summarize(retraso_medio = mean(arr_delay, na.rm = T),
retraso_medio_sin_sesgo = mean(arr_delay[arr_delay > 0], 
na.rm = T))

head(resumen_t)


cobertura <- flights %>% filter(!is.na(arr_delay)) %>% 
group_by(dest) %>%
summarize(aerolinea = n_distinct(carrier)) %>% 
arrange(desc(aerolinea))

head(cobertura)

### Tidy Tables y NonTidy Tables

library(tidyverse)
data(table4a)
print(table4a)

tidy4 <- table4a %>% gather(`1999`, `2000`, key = 'periodo', 
value = 'casos')

data(table4b)
print(table4b)

tidy5 <- table4b %>% gather(`1999`, `2000`, key = 'periodo', 
value = 'poblacion')

tidy4 <- tidy4 %>% mutate(periodo = as.integer(periodo) + 2)  

tidy5 <- tidy5 %>% mutate(periodo = as.integer(periodo))  

tidy5 <- left_join(tidy5, tidy4)
print(tidy5)
print(tidy5)
print(tidy4) 


data(table2)
print(table2)

tidy6 <- table2 %>% spread(key = type, value = count)
print(tidy6)

data(table3)
print(table3)

tidy7 <- table3 %>% separate(rate, into = c('casos', 'pobl'),
sep = '/')
print(tidy7)


#########
#library(forcats)

tidy7 <- tidy7 %>% mutate(casos = as.factor(casos))
print(tidy7)





