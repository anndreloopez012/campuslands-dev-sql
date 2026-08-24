# Ejercicio 33: Normalización Matrículas Académicas

## Información

- Ejercicio: 33
- Tema: Normalización de datos
- Nivel: Intermedio
- Estudiante: Jose Luis Herrera

## Descripción

El ejercicio parte de un archivo plano utilizado para administrar matrículas académicas.

La estructura original reúne información de estudiantes, documentos, rutas, trainers, módulos, horarios y notas en una misma tabla.

La solución transforma esta estructura hasta tercera forma normal (3FN), separando las entidades académicas y las relaciones entre ellas.


## Consultas

El archivo `dql/consultas.sql` contiene consultas para:

1. Reconstruir una vista similar al archivo original mediante `JOIN`.
2. Listar estudiantes, rutas y trainers sin duplicados.
3. Contar matrículas por ruta y estado.
4. Calcular el promedio de notas por matrícula.
5. Obtener promedio, mínimo y máximo de notas.
6. Buscar estudiantes mediante `LIKE`.
7. Filtrar matrículas por fecha y notas por rango.
8. Obtener las cinco matrículas con mejor promedio.
9. Detectar matrículas sin notas.
10. Generar un reporte académico final con alias legibles.

El modelo permite consultar la información académica sin almacenar listas de valores dentro de una misma celda.

La separación de entidades reduce la duplicidad y evita anomalías de inserción, actualización y eliminación.