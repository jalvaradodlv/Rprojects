library(ggplot2)
library(nycflights13)
library(dplyr) 

data(flights) 

g1 <- ggplot(data = flights)
g1 <- g1 + geom_point(mapping = aes(x = dep_time, y = arr_time))
g1

ggsave('grafico.png', g1)

