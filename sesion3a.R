library(ggplot2)
library(nycflights13)
library(dplyr) 

### g1 <- ggplot(data = CONJUTO DE DATOS)
### g1 <- g1 + GEOM_FUNCTION(mapping = aes(COLUMNAS))
#g1 <- ggplot(data = flights)
#g1 <- g1 + geom_point(mapping = aes(x = dep_time, y = arr_time))
#g1

#ggsave('grafico.png', g1)

data(mpg)
head(mpg)

#Gráfico de dispersión simple
g1 <- ggplot(data = mpg)
g1 <- g1 + geom_point(mapping = aes(x = displ, y = hwy))

ggsave('mpg1.png', g1)

#Gráfico de dispersión con lor por categorías
g2 <- ggplot(data = mpg)
g2 <- g2 + geom_point(mapping = aes(x = displ, y = hwy,
color = class))

ggsave('mpg2.png', g2)

#Gráfico 'facets'
g3 <- ggplot(data = mpg)
g3 <- g3 + geom_point(mapping = aes(x = displ, y = hwy)) +
facet_wrap(~ class, nrow = 2)

ggsave('mpg3.png', g3)


g4 <- ggplot(data = mpg)
g4 <- g4 + geom_point(mapping = aes(x = displ, y = hwy)) +
facet_grid(cyl ~ drv)

ggsave('mpg4.png', g4)


##lowess o loess (local weighted spline)
##GAM (Generalized Additive Model)

g5 <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy))
g5 <- g5 + geom_point() + geom_smooth()

ggsave('mpg5.png', g5)


#Se puede limitar los datos empleados en el suavizamiento

g6 <- ggplot(data = mpg, mapping = aes(x = displ, y = hwy))
g6 <- g6 + geom_point(position = 'jitter') + geom_smooth(
data = filter(mpg, class == 'compact'),
se = TRUE)

ggsave('mpg6.png', g6)


####GRAFICAS DE BARRAS
g7 <- ggplot(data = mpg)
g7 <- g7 + geom_bar(mapping = aes(x = class, fill = 3))

ggsave('mpg7.png', g7)

#Dos clásicas para position son dodge y fill
g8 <- ggplot(data = mpg)
g8 <- g8 + geom_bar(mapping = aes(x = class, fill = drv),
position = 'dodge')

ggsave('mpg8.png', g8)

####Combinando manipulación con gráficos

data(flights) 

by_dest <- group_by(flights, dest)

delay <- summarize(by_dest,
conteos = n(),
dist = mean(distance, na.rm = TRUE),
delay = mean(arr_delay, na.rm = TRUE))

delay <- filter(delay, conteos > 20, dest != 'HNL')

g9 <- ggplot(data = delay, mapping = aes(x = dist, y = delay))
g9 <- g9 + geom_point(aes(size = conteos), alpha=1/2) + geom_smooth()

ggsave('g9.png', g9)

head(filter(delay, delay > 25))

###
g10 <- ggplot(data = flights, mapping = aes(x = arr_delay))
g10 <- g10 + geom_freqpoly(binwidth = 10)

ggsave('g10.png', g10)


g10 <- ggplot(data = flights, mapping = aes(x = arr_delay))
g10 <- g10 + geom_freqpoly(binwidth = 500)

ggsave('g11.png', g10)


g10 <- ggplot(data = flights, mapping = aes(x = arr_delay))
g10 <- g10 + geom_freqpoly(binwidth = 2000)

ggsave('g12.png', g10)


g10 <- ggplot(data = flights, mapping = aes(x = arr_delay))
g10 <- g10 + geom_freqpoly(binwidth = 0.1)

ggsave('g13.png', g10)
