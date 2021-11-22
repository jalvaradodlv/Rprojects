library(readr)
#Para abrir csv se usa read_csv()
#No confundir con read.csv(). Ambos cargan el archivo csv
#Pero el primero genera un objeto tibble y el segundo
#genera un objeto data.frame.
mi_tabla <- read_csv('home/wilfridovich/Documentos/credito.csv')

head(mi_tabla)
