library(nycflights13)
library(dplyr) 

data(flights) 
flight <- flights


mi_suma <- function(num_1, num_2){
	return (num_1+num_2)
}

mi_suma_v <- function(v_1, v_2){
	return (v_1+v_2)
}
#517  - 830
#5.17 - 8.30

#6.00 - 8.00 = 2*60 

#8.30 - 8.00 = .3*100

#6.00 - 5.17 = (.83 - .4)*100



#La idea de mutate es crear nuevas columnas, 
#a partir de la existentes

flight <- mutate(flight, col_eje = ceiling(dep_time/100))
#Esta linea es por fines didácticos
flight <- select(flight, col_eje, everything())
head(flights)


#nombre de la función <- function(x){
#	bloque de codigo
#	return ()
#}

print(mi_suma(4,5))

flight <- mutate(flight, 
nuevo_eje = mi_suma_v(dep_time,sched_dep_time))

flight <- select(flight, nuevo_eje, everything())
head(flight)
head(flights)

mi_tiempo_vuelo <- function(c1, c2){
	#Calculo las hora efectivas
	techo <- ceiling(c1/100)
	suelo <- floor(c2/100)
	
	minutos <- 60*(suelo-techo)
	minutos <- minutos + (c2/100 - suelo)*100
	minutos <- minutos + (techo - c1/100 - .4)*100
	
	return(minutos)
}

flight <- mutate(flight, 
tiempo_vuelo = mi_tiempo_vuelo(dep_time,arr_time))

flight <- select(flight, tiempo_vuelo, everything())
head(flight)

###MANDANDO LLAMAR LAS COLUMNAS POR FUERA FUERA DEL CONJUNTO DE DATOS
#Esto no funciona
#mi_suma_v(dep_time,sched_dep_time)

#Esto si funciona
#mi_suma_v(flights$dep_time,flights$sched_dep_time)

#Otra solución
#attach(flights)
#mi_suma_v(dep_time, sched_dep_time)
#detach(flights)

#Otra solución
#with(flights, mi_suma_v(dep_time, sched_dep_time))

