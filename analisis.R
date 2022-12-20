#!/usr/bin/Rscript

# Lectura de datos de la encuesta (en CSV)
alumnos <- read.csv("alumnos.csv", colClasses = c("numeric", "factor",
  "numeric", "factor", "factor", "logical"))
editores <- read.csv("editores.csv", colClasses = c("character", "logical",
  "factor", "logical", "logical", "logical", "factor"))

# Definicion de variables derivadas directamente de los datos
alumnos$Experimentado <- alumnos$Trabajador | alumnos$TipoEstudios == "M" |
  alumnos$InicioEstudios <= 2020
editores$EditorCompleto <- editores$Extensiones & editores$ControlVersiones &
  editores$Debugger

# Muestra un resumen de los datos
cat("== Resumen de los datos cargados ==\n")
cat("= Alumnos =\n")
summary(alumnos)
cat("= Editores =\n")
summary(editores)
cat("== Fin del resumen ==\n\n")

# Creación de un data frame que une todos los datos
datos <- merge(x = alumnos, y = editores, by.x = "Editor", by.y = "Nombre")

# Subconjuntos de datos
experimentados <- subset(datos, Experimentado)
no_experimentados <- subset(datos, !Experimentado)

# Hipotesis nulas
experimentados_completos <- subset(experimentados, EditorCompleto)
no_experimentados_completos <- subset(no_experimentados, EditorCompleto)

# Test de hipotesis nula
cat("== Resultados ==\n")
cat("Alumnos experimentados usando editores completos:",
  nrow(experimentados_completos), "/", nrow(experimentados), "\n")
cat("Alumnos no experimentados usando editores completos:",
  nrow(no_experimentados_completos), "/", nrow(no_experimentados), "\n")
cat("= Test de proporciones =\n")
prop.test(
  x = c(nrow(experimentados_completos), nrow(no_experimentados_completos)),
  n = c(nrow(experimentados), nrow(no_experimentados)),
  alternative = "greater",
  p = NULL,
  conf.level = 0.95,
  correct = FALSE
)
cat("== Fin de los resultados ==\n")