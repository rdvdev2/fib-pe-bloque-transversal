#!/usr/bin/Rscript

# Lectura de datos de la encuesta (en CSV)
alumnos <- read.csv("alumnos.csv", colClasses = c("numeric", "factor",
  "numeric", "factor", "factor", "logical"))
editores <- read.csv("editores.csv", colClasses = c("character", "logical",
  "factor", "logical", "logical", "logical", "factor"))

# Creación de un data frame que une todos los datos
datos <- merge(x = alumnos, y = editores, by.x = "Editor", by.y = "Nombre")

# Muestra un resumen de los datos
cat("== Resumen de los datos cargados ==\n")
summary(datos)
cat("== Fin del resumen ==\n")