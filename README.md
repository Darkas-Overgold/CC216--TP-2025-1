# CC216-TP-2024-1-CC52
# Trabajo Parcial Fundamentos de Data Science: Hotel booking demand

# Participantes:

* Joaquín Eduardo Velarde Leyva          U202212510

* Victor Daniel Chipana Gutierrez        U202115805

* Daniel Ivan Carbajal Robles          	U20221B751

* Ian Joaquin Sanchez Alva               U202124676


# Objetivo del trabajo

Este trabajo se realizó con la meta de extraer y analizar las reservas de hoteles de los datos extraidos de [Hotel booking demand dataset](https://www.sciencedirect.com/science/article/pii/S2352340918315191)
A la par, los participantes del analisis aprenden y mejoran sus capacidades en el entorno del analisis explotario de Datos.

# Descripción del dataset

Se adjunta la descripcion del data set en el documento a presentar: [upc-pre-2401-3-tp1](https://github.com/Nemesisian/CC216--TP-2024-1-/blob/main/upc-pre-2401-3-tp1.pdf]

# Conclusiones
- La limpieza de dataset es un paso importante para poder recuperar valores que están encubiertos por un “NA”, también se puede usar el método de eliminación de columnas ya que no son datos relevantes para el análisis del dataset.

- Se observa que la gente prefiere el tipo "City Hotel" en comparación con "Resort Hotel". Esto se evidencia por el mayor número de reservas realizadas en City Hotel en comparación con Resort Hotel.

- Después de un aumento en la demanda hasta 2016, se observa una tendencia a la baja en las estancias en fines de semana a partir de entonces. Esto puede indicar un cambio en las preferencias de los clientes o cambios en el mercado que podrían afectar la demanda.

- Se identifican tres temporadas: baja, media y alta. Los meses de temporada baja son enero, noviembre y diciembre. La temporada alta abarca julio y agosto, mientras que el resto de los meses se consideran de temporada media.

- Un total de 9336 reservas incluyen niños o bebés. Esto sugiere que hay una demanda considerable de alojamientos que puedan acomodar a familias.

- Se observa que las cancelaciones de reservas son más frecuentes cuando no hay espacios de estacionamiento disponibles. Esto indica que contar con espacios de estacionamiento puede influir significativamente en la decisión de reserva de los clientes.

- Para futuros análisis, una recomendación precisa es usar la función pasar variables a factor para se puedan hacer reportes o resúmenes de las tablas del dataset, por el contrario lo leería como un “character” y por ende no te daría los datos que buscas de forma ordenada.

- Como lección nos queda que todo reporte de datos, nos sirve poder gestionar de una manera correcta y precisa el análisis de los futuros datasets a utilizar. Además la creación de una matriz de correlación de variables, es de vital importancia ya que sirve para entender la naturaleza y la fuerza de las relaciones lineales entre variables en un conjunto de datos.

# Licencia
António, N., Almeida, A., & Nunes, L. (2019). Hotel booking demand datasets. Data in Brief, 22, 41–49. [https://doi.org/10.1016/j.dib.2018.11.126](https://doi.org/10.1016/j.dib.2018.11.126)
