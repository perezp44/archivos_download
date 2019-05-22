#- para cargar datos en R hay multitud de paquetes
#- los paquetes q se usan en el tidyverse son: readr y heaven
#- PERO, creo que es mejor que nos centremos en el paquete "rio"
#- veamos "rio" en CRAN: https://cran.r-project.org/web/packages/rio/index.html
#- generalmente los paquetes tienen una version de desarollo en Github, veamosla: https://github.com/leeper/rio
#- bien, vamos a usar "rio"
library(rio)

#- hagamos visibles dos data.frames de R: iris y mtcars
iris <- iris
mtcars <- mtcars

#- vamos a exportarlos a varios formatos. la función es export(). Veamos la yuda de la f. export() apretando F1
export(iris)  #- xq no funciona
export(iris, "./datos/pruebas/my_iris.csv")  
export(iris, "./datos/pruebas/my_iris.xlsx")  
#export(iris, "./datos/pruebas/my_iris.dta")  
export(iris, "./datos/pruebas/my_iris.sav")

#- bonus: exportar 2 df en un único archivo .xlsx
export(list(iris = iris, mtcars = mtcars ), file = "./datos/pruebas/my_iris_mtcars.xlsx")

#- bonus: le añadimos un libro mas al archivo "my_iris_mtcars.xlsx"
export(iris, "./datos/pruebas/my_iris_mtcars.xlsx", which = "iris_2")


#- venga, a importar los ficheros "my_iris"
my_iris.csv <- import("./datos/pruebas/my_iris.csv")
class(my_iris.csv)

my_iris.csv <- import("./datos/pruebas/my_iris.csv", setclass = "tibble") #- como una tibble
class(my_iris.csv)

#- los de SPSS
my_iris.spss <- import("./datos/pruebas/my_iris.sav", setclass = "tibble") #- como una tibble



#- importamos todos los libros de un .xlsx
my_iris_mtcars <- import("./datos/pruebas/my_iris_mtcars.xlsx") #- solo importa el primer libro
my_iris_mtcars <- import("./datos/pruebas/my_iris_mtcars.xlsx", sheet = 2) #- solo importa el segundo libro del archivo
my_iris_mtcars <- import("./datos/pruebas/my_iris_mtcars.xlsx", sheet = "iris_2") #- solo importa el libro llamado "iris_2"

#- importamos todos los libros de un archivo .xlsx
library(readxl)
my_IRIS_list <- lapply(excel_sheets("./datos/pruebas/my_iris_mtcars.xlsx"), read_excel, path = "./datos/pruebas/my_iris_mtcars.xlsx")


#- importamos todos los archivos que hemos creado en "./datos/pruebas/"
library(purrr)
my_carpeta <- "./datos/pruebas/"

lista_de_archivos <- list.files(my_carpeta)  #- Ok con basen ...
lista_de_archivos <- fs::dir_ls(my_carpeta)  #- pero mejor con el pkg "fs"
my_IRIS_list_2 <- map(lista_de_archivos, import)


#- vamos a borar los archivos q hemos creado:
list.files("./datos/pruebas")
file.remove("./datos/pruebas/mtcars.xlsx")
#- las borramos todas
file.remove(file.path("./datos/pruebas", list.files("./datos/pruebas"))) 



#- lo que si hay que saber es que R tiene 2 formatos propios .rds y .RData (o .rda)
#- El formato .RData tienen la ventaja de que puedes guardar varios objetos a la vez
save(mtcars, iris,  file = "./datos/pruebas/mtcars_and_iris.RData")
#- para cargarlos:
load("./datos/pruebas/mtcars_and_iris.RData")
#- Una “desventaja” del formato RData es que al importar un fichero .RData, los objetos que contiene se cargan siempre con el nombre con el que fueron grabados.

#- formato .rds
write_rds(iris, "./datos/pruebas/iris.rds")
rio::export(mtcars, "./datos/pruebas/iris_2.rds")
#- para importar .rds
iris_imp_rds <- readRDS("./datos/pruebas/iris.rds")

