library(nycflights13)
library(dplyr) 

data(flights) 
data(airports) 

head(flights)
#n sirve para indicar el total de filas a mostrar
head(airports, n=10)

#Imprimir la columna dep_time
mi_columna <- flights$dep_time # Esto genera un objeto vector con los valores de la columna
mis_columnas <- flights[, 4:6] # Se genera un subconjunto que sigue siendo 'tibble' con las columnas seleccionadas

#head(mi_columna)
#head(mis_columnas)


#filtros (requiere dplyr)
#Los retrasos en la salida es si dep_delay > 0
vuelos_con_retraso <- filter(flights, dep_delay > 0)
head(vuelos_con_retraso)

#Las condiciones sobre columnas son un vector de valores SI o NO.
#head(flights$dep_delay > 0)

# y --- &
# o --- |
# no -- !
# xor - xor() 
vuelos_con_retraso_2 <- filter(flights, (dep_delay > 0) & 
(month == 3))
head(vuelos_con_retraso_2)

##Quisiera quedarme solo con vuelos existentes
vuelos_realizados <- filter(flights, !is.na(dep_time))
#print(vuelos_realizados$dep_time)

##
#Para seleccionar se escriben las columnas separadas por coma
vuelos_realizados_2 <- select(flights, month, year)
head(vuelos_realizados_2)

#Seleccionar un rango de columnas
vuelos_realizados_3 <- select(flights, dep_time:arr_time)
head(vuelos_realizados_3)

#Un uso de select para reordenar columnas de posición
vuelos_realizados_4 <- select(flights, month, everything())
head(vuelos_realizados_4)

#Puedo quitar una columna así
vuelos_realizados_5 <- select(flights, -(year:day))
head(vuelos_realizados_5)

###Mutate crea nuevas columnas
###Queremos crear el tiempo de vuelo
#517  - 830
#5.17 - 8.30

#6.00 - 8.00 = 2*60 

#8.30 - 8.00 = .3*100

#6.00 - 5.17 = (.83 - .4)*100

#Funciona solo para vuelos del mismo día y no es 
#humanamente facil de leer
#Entonces funcione o no, no es muy bueno que dentro
#mutate la función de creación sea compleja
vuelos_realizados_5 <- mutate(flights, 
tiempo_vuelo = (ceiling(dep_time/100) - 
floor(arr_time/100))*60 + 100*(floor(arr_time/100) - 
arr_time/100 + 100*(ceiling(dep_time/100) - dep_time/100 - .4))
)

print(vuelos_realizados_5$tiempo_vuelo)
#print(flights$dep_time)

















#Esto para más adelante lo explicamos a detalle
#meses <- c('Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul',
#'Ago', 'Sep', 'Oct', 'Nov', 'Dic')

#asignar_mes <- function(x){
#	return(meses[x])
#}

#vuelos_realizados_4 <- mutate(flights, 
#month_word = asignar_mes(month))
#print(vuelos_realizados_4$month_word)







