#Ciclos en R via funcionales
#library(tidyverse)
library(ggplot2)
library(dplyr)
library(purrr)

data(mpg)
head(mpg)

#Esto de aquí es un ciclo sobre columnas
mpg_num <- mpg %>% select(where(is.numeric))
head(mpg_num)

#Ciclos sobre columnas
#displ  year   cyl   cty   hwy
mpg_num_sum <- mpg_num %>% summarize(
media_displ = mean(displ),
media_year = mean(year),
media_cyl = mean(cyl),
media_cty = mean(cty),
media_hwy = mean(hwy))

print(mpg_num_sum)

#Hay map_TIPO DE DATO (lgl - logico)
#(int - entero, chr - caracter, dbl - numerico)
#y hay un simplemente map (que de uso general para objetos)
resumen <- map_dbl(mpg_num, mean)
print(resumen)

mpg_select <- map_lgl(mpg, is.numeric)
mpg_purrr <- mpg[, mpg_select]

head(mpg_purrr)

##################################
### Ciclos para generar objetos
data(mtcars)
head(mtcars)

### Por ejemplo se quiere hacer un modelo de regresión lineal
### que relacione mpg con wt
#lm() no forma parte del tidyverse al igual que aov()
mi_lm <- lm(mpg ~ wt, data = mtcars)
summary(mi_lm)

#¿cuántos modelos voy a hacer?
cilindros <- mtcars %>% summarize(cil = n_distinct(cyl))
print(cilindros)

mt4 <- mtcars %>% filter(cyl == 4)
mt6 <- mtcars %>% filter(cyl == 6)
mt8 <- mtcars %>% filter(cyl == 8)

lm4 <- lm(mpg ~ wt, data = mt4)
summary(lm4)

lm6 <- lm(mpg ~ wt, data = mt6)
summary(lm6)

lm8 <- lm(mpg ~ wt, data = mt8)
summary(lm8)

#Esta es la versión rápida usando mapeos de purrr
modelos <- mtcars %>% split(.$cyl) %>% 
map(~ lm(mpg ~ wt + hp, data = .))

print(modelos %>% map(summary) %>% map_dbl(~.$r.squared))


###Manipulando modelos
library(modelr)
library(tibble)

mi_x <- rep(seq(2, 10, 0.3), 3)
n <- length(mi_x)
print(mi_x)
mi_y <- 8 + 1.5 * mi_x + rnorm(n)

#Así se crea una tabla con variables aisladas
datos <- as_tibble(list(x = mi_x, y = mi_y))
head(datos)

grafico <- datos %>% ggplot()
grafico <- grafico + geom_point(aes(x = x, y = y))

ggsave('ejemplo.png', grafico)


###Adivinando el modelo
###Otra forma de definir una tabla
modelos_posibles <- tibble(
b0 = runif(250, -20, 20),
b1 = runif(250, -5, 5))

#Gráfico de mis propuestas, ¿cuál será la mejor?
propuestas <- datos %>% ggplot(aes(x = x, y = y))
propuestas <- propuestas + geom_point()
propuestas <- propuestas + geom_abline(aes(intercept = b0,
slope = b1), data = modelos_posibles, alpha = 0.3)

ggsave('ejemplo.png', propuestas)

mi_modelo <- function(b, data){
	return (b[1] + b[2] * data$x)
}

measure_distance <- function(mod, data){
	diferencia <- data$y - mi_modelo(mod, data)
	return (sqrt(mean(diferencia^2)))
}

evaluate_model <- function(b0, b1){
	measure_distance(c(b0, b1), datos)
}

modelos_posibles <- modelos_posibles %>% mutate(
evaluacion = map2_dbl(b0, b1, evaluate_model))

head(modelos_posibles)




