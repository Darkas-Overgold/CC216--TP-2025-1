# BORRA TODAS LAS VARIABLES DE MEMORIA
rm(list=ls(all=TRUE)) 

## Limpia consola
cat("\014")

#limiar el area de gráficos
graphics.off()


##Cambiar la ruta en la que se encuentra el archivo a leer
setwd("C:/Users/ASUS/OneDrive/Escritorio/Quinto ciclo/Fundamento_Data_Science/Trabajo_Parcial")
hotels<- read.csv('hotel_bookings.csv', header = TRUE , sep = ',', dec = '.',stringsAsFactors = FALSE , na.strings = "")
summary(hotels)
names(hotels)
##estas lineas donde se crean los objetos hotels_data_limpia indican que se omitieron los valores NA y que se borró la columna "Company" porque no era de utilidad además eran NA'S
hotels_data.limpia <- na.omit(hotels)
hotels_data.limpia <- subset(hotels, select = -company)
head(hotels_data.limpia)

##PREGUNTA 1
install.packages("ggplot2")
install.packages("dplyr")
library(ggplot2)
library(dplyr)

datos <- data.frame(
  hotels_data.limpia$hotel ,
  hotels_data.limpia$is_canceled 
)
head(datos)
conteo_por_hotel <- table(datos$hotels_data.limpia.hotel)
conteo_por_hotel
barplot(conteo_por_hotel, 
        main = "Preferencia de hotel", 
        xlab = "Tipo de hotel", 
        ylab = "Número de reservas", 
        col = "#CCBC0F", 
        border = "black")

##pregunta 2

##ordenar datos por fecha (año)
datos_agrupados <- group_by(hotels_data.limpia, arrival_date_year)
head(datos_agrupados)
##calcular la suma de cuantas veces se quedaron en fines de semana por año
demanda_por_anio <- summarise(datos_agrupados, total_stays_in_weekend_nights = sum(stays_in_weekend_nights))

ggplot(demanda_por_anio, aes(x = arrival_date_year, y = total_stays_in_weekend_nights)) +
  geom_line() +
  labs(x = "Año de llegada", y = "Total de estancias en fines de semana")

##pregunta 3

## convertir los meses a factor para que puedan ser ordenados
hotels_data.limpia$arrival_date_month <- factor(hotels_data.limpia$arrival_date_month, levels = c("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"))

## se hace un conteo de las reservas por mes
reservas_por_mes <- table(hotels_data.limpia$arrival_date_month)

## sacamos el promedio de la tabla anterior para cada mes
promedio_reservas <- mean(reservas_por_mes)

## le damos valores para definir las temporadas
temporada_alta <- promedio_reservas * 1.2  ## se usó 1.2 y 0.8 para poder generar lo que es una temporada baja y alta
temporada_baja <- promedio_reservas * 0.8  ## si es más del 20% abajo del promedio o si es mas del 20% arriba del promedio.  

## se le da los valores de las temporadas a los meses
temporada <- cut(reservas_por_mes, breaks = c(-Inf, temporada_baja, temporada_alta, Inf), labels = c("baja", "media", "alta"))
##inf y -inf son necesarios en la funcion cut porque indican de donde a donde van los valores de los promedios de las reservas

# resumen final de los meses con su numero de reservas totales y la temporada a la que pertencen 
resumen_temporadas <- data.frame(Mes = names(reservas_por_mes), Total_Reservas = as.numeric(reservas_por_mes), Temporada = temporada)
print (resumen_temporadas)


##pregunta 4
## utilizando la pregunta anterior , filtramos solo con los meses de temporada baja 
meses_temporada_baja <- resumen_temporadas[resumen_temporadas$Temporada == "baja", ]
print(meses_temporada_baja)


##pregunta 5
## filtramos las filas donde hayan niños o bebés
reservas_con_ninos_o_bebes <- hotels_data.limpia[hotels_data.limpia$children > 0 |hotels_data.limpia$babies > 0, ]
##conteo
total_reservas_con_ninos_o_bebes <- nrow(reservas_con_ninos_o_bebes)
print(total_reservas_con_ninos_o_bebes)

##pregunta 6

boxplot(hotels_data.limpia$is_canceled ~ hotels_data.limpia$required_car_parking_spaces, xlab="Espacios de parque necesarios", ylab="Porcentaje de cancelación", col="skyblue")
#pregunta 7

cancelaciones$reservation_status_date <- as.Date(cancelaciones$reservation_status_date)
cancelaciones$mes <- format(cancelaciones$reservation_status_date, "%m")
cancelaciones_por_mes <- cancelaciones %>% group_by(mes) %>% summarise(cantidad = n())
cancelaciones_por_mes$mes <- as.Date(paste("2000", cancelaciones_por_mes$mes, "01", sep = "-"))
ggplot(cancelaciones_por_mes, aes(x = mes, y = cantidad)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  scale_x_date(date_labels = "%b", date_breaks = "1 month") +
  labs(title = "Cantidad de cancelaciones por mes", x = "Mes", y = "Cantidad de cancelaciones")



View(hotels)

str(hotels)

summary(hotels$company)


#--Caso de estudio--

##--Inspecciondar datos--
#Verificar tipos de datos de las columnas y nombres de las columnas:
column_info <- function(hotels_data.limpia) {
  cat("Nombres de las columnas:\n")
  print(names(hotels_data.limpia))
  cat("\nTipos de datos de las columnas:\n")
  print(sapply(hotels_data.limpia, class))
}

column_info(hotels_data.limpia )
#---------------------------------------------------------------
# Generar una tabla de trabajadores con una columna de personal aleatorio entre 100 y 500
trabajadores <- data.frame(personal = sample(100:500, nrow(hotels_data.limpia), replace = TRUE))

# Agregar la tabla de trabajadores al conjunto de datos hotels_data.limpia
hotels_data.limpia <- cbind(hotels_data.limpia, trabajadores)
#----------------------------------------------------------------
#--Procesar Datos--
#Identificación de datos faltantes (NA)
# Convertir la columna "agent" a tipo numérico (si es necesario)
hotels_data.limpia$agent <- as.numeric(as.character(hotels_data.limpia$agent))
# Convertir la columna "agent" a enteros
hotels_data.limpia$agent <- as.integer(hotels_data.limpia$agent)
# Verificar el cambio
Valor_Na <- function(x){
  sum=0
  for(i in 1 :ncol(x))
  {
    cat("en la columna",colnames(x[i]),"total de valores NA",colSums(is.na(x[i])),"\n")
  }
}

Valor_Na(hotels_data.limpia)

#Explicación y aplicación de la técnica utilizada para eliminar o completar los datos faltantes.
# Generar valores aleatorios enteros en el rango de 100 a 400
valores_enteros <- sample(100:400, sum(is.na(hotels_data.limpia$agent)), replace = TRUE)

# Reemplazar los NA en la columna "agent" con los valores aleatorios generados
hotels_data.limpia$agent[is.na(hotels_data.limpia$agent)] <- ifelse(is.na(hotels_data.limpia$agent), valores_enteros, hotels_data.limpia$agent)

str(hotels_data.limpia$agent)
head(hotels_data.limpia$agent)


#Identificación de datos atípicos(Outliers)
# Calcular la media y la desviación estándar de la columna 'adr'
mean_adr <- mean(hotels_data.limpia$adr)
sd_adr <- sd(hotels_data.limpia$adr)

# Definir límites para identificar valores atípicos (por ejemplo, valores más allá de 3 desviaciones estándar de la media)
limite_inferior <- mean_adr - 3 * sd_adr
limite_superior <- mean_adr + 3 * sd_adr

# Identificar valores atípicos
valores_atipicos <- hotels_data.limpia$adr[hotels_data.limpia$adr < limite_inferior | hotels_data.limpia$adr > limite_superior]

# Mostrar los valores atípicos
print(valores_atipicos)

#Explicación y aplicación de la(s) técnica(s) utilizada(s) para transformar los datos atípicos.

# La columna 'assigned_room_type' contiene los tipos de habitación asignados (por ejemplo, 'A', 'B', 'C', etc.).
# La columna 'adr' representa el precio promedio diario.
# Paso 1: Conversión de la columna 'assigned_room_type' a factor
hotels_data.limpia$assigned_room_type <- as.factor(hotels_data.limpia$assigned_room_type)

# Paso 2: Creación de un gráfico de dispersión original
plot(hotels_data.limpia$assigned_room_type, hotels_data.limpia$adr)

# Este gráfico muestra la relación entre los tipos de habitación asignados y los precios promedio diarios.

# Paso 3: Filtrado de datos para valores de 'adr' menores a 5000
HB2 <- hotels_data.limpia %>% filter(hotels_data.limpia$adr < 5000)

# Paso 4: Creación de un segundo gráfico de dispersión con datos filtrados
plot(HB2$assigned_room_type, HB2$adr, main = "assigned_room x adr")

# Este gráfico muestra la relación entre los tipos de habitación asignados y los precios promedio diarios,
# pero solo para aquellos registros con precios menores a 5000.


#--Visualizar datos--

# Selecciona las variables relevantes en hotels_data.limpia
selected_vars <- hotels_data.limpia[, c('lead_time', 'is_canceled', 'arrival_date_year', 'total_of_special_requests')]

# Calcula la matriz de correlación
cor_matrix <- cor(selected_vars)

# Instala y carga el paquete 'pheatmap' si aún no lo has hecho
# install.packages('pheatmap')
library(pheatmap)

# Crea un mapa de calor para visualizar las correlaciones
pheatmap(cor_matrix, scale = 'none', main = "Matriz de Correlación entre Variables")

write.csv(hotels_data.limpia, "hotels_data.limpia.csv", row.names = TRUE)


df <- read.csv('hotels_data.limpia.csv', header = TRUE, sep = ',', dec = '.')


