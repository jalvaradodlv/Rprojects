library(nycflights13)
library(dplyr) 

data(flights) 
flight <- flights

#Esto NA porque hay registros con NA
resumen <- summarize(flight, retraso_medio = mean(dep_delay))
print(resumen)

#Algunas funciones pueden lidiar con NA's de manera nativa
resumen <- summarize(flight, 
retraso_medio = mean(dep_delay, na.rm = TRUE))
print(resumen)

#La solución clásica sería filtrar
flight <- filter(flight, !is.na(dep_time))

otro_resumen <- summarize(flight, 
retraso_medio = mean(dep_delay),
retraso_minino = min(dep_delay))
print(otro_resumen)


#Resumen limitado
#Hacer resumen de solo datos con retrasos reales (es decir
#dep_delay > 0)

flight_r <- filter(flight, dep_delay > 0)
head(flight_r)
otro_resumen <- summarize(flight_r, 
var_retraso = var(dep_delay))
print(otro_resumen)


###Resumenes por grupo
### En este caso generaremos dos grupos: 
###   1. Retrasados - dep_delay > 0
###   2. No retrasados - dep_delay <= 0

flight <- mutate(flight, 
class_delay = ifelse(dep_delay > 0, 'retrasados', 'no retrasados'))

flight <- select(flight, class_delay, everything())
flight <- arrange(flight, desc(month), desc(day))

head(flight)

flight_g <- group_by(flight, class_delay)

otro_resumen <- summarize(flight_g, 
var_retraso = var(dep_delay))
print(otro_resumen)





