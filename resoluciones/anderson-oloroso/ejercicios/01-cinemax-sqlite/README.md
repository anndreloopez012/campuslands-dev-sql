# Solucion Ejercicio 01: 01 Cinemax Sqlite

## Informacion del Estudiante
- **Nombre**: Anderson Oloroso
- **Fecha**: 2026-08-24
- **Ejercicio**: 01-cinemax-sqlite

## Descripcion de la Solucion
Se ha construido un modelo relacional en SQLite alineado con las especificaciones del ejercicio. El modelo implementa llaves primarias, llaves foraneas con cascada, restricciones UNIQUE, CHECK y valores predeterminados DEFAULT.

## Estructura de las tablas del sistema de cine

1. `peliculas`: Catálogo de películas disponibles en el cine. Contiene
   información como el nombre, la duración, la clasificación, el género y la
   fecha de estreno.

2. `salas`: Registro de las salas de proyección. Contiene el nombre de la sala,
   su capacidad, el tipo de proyección y su estado.

3. `funciones`: Registro de las funciones programadas. Cada función está
   relacionada con una película y una sala mediante llaves foráneas. También
   almacena la fecha, la hora, el precio, el idioma, el formato y el estado de
   la función.

4. `boletos`: Registro de los boletos vendidos o reservados. Cada boleto está
   relacionado con una función mediante una llave foránea y contiene el número
   de asiento, el comprador, el precio pagado y el estado del boleto.
