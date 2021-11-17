library(nycflights13)
library(dplyr) 

data(flights) 
flight <- flights

flight <- filter(flight, !is.na(dep_time))

flights_by_plane <- group_by(flight, tailnum)

resumen <- summarize(flights_by_plane, 
maximos = max(arr_delay - dep_delay, na.rm = T))


#Una solución
resumen2 <- summarize(resumen, 
mm = max(maximos))

res = filter(resumen, maximos == resumen2$mm)
head(res)


#Una solución
resumen2 <- arrange(resumen, 
desc(maximos))

head(resumen2)
