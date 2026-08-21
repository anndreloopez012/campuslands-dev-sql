# Analisis del requerimiento - Ejercicio 035

## Solicitud entendida

Una biblioteca especializada presta libros de ciencia ficcion y controla devoluciones. El cliente no habla en terminos de tablas, solo describe su operacion diaria: prestar libros, marcar devoluciones, saber quien tiene atrasos. Pide explicitamente no guardar solo texto: quiere poder consultar datos, corregir estados y registrar movimientos.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| libros | Es el catalogo de libros de ciencia ficcion que la biblioteca puede prestar. | titulo (unico), autor, genero, anio_publicacion |
| lectores | Es el catalogo de personas registradas que pueden pedir prestamos. | nombre_lector (unico), email |
| prestamos | Es el registro transaccional de cada prestamo: que libro, que lector, cuando salio, cuando debe volver y en que estado va. Aqui es donde la biblioteca controla las devoluciones y los atrasos. | id_libro (FK), id_lector (FK), fecha_prestamo, fecha_devolucion_esperada, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| libros -> prestamos | 1:N | Un libro puede tener muchos prestamos a lo largo del tiempo. |
| lectores -> prestamos | 1:N | Un lector puede tener muchos prestamos. |

## Reglas de negocio

- Regla 1: Todo prestamo debe apuntar a un libro real y a un lector real (`FOREIGN KEY` doble).
- Regla 2: `email`, `genero` y `autor` son `NOT NULL`: son datos que, si faltaran, romperian el contacto con el lector o la clasificacion del catalogo.
- Regla 3: `fecha_devolucion_esperada` siempre debe ser posterior a `fecha_prestamo` (`CHECK`), porque un prestamo con fecha de devolucion invertida no tiene sentido.
- Regla 4: Un prestamo puede estar `prestado`, `devuelto`, `atrasado` o `perdido` (`CHECK`); la biblioteca necesita poder corregir este estado cuando un lector devuelve, se atrasa o pierde un libro.
- Regla 5: `titulo` y `nombre_lector` no se repiten (`UNIQUE`).

## Supuestos

- El `autor` se guardo como un campo de texto dentro de `libros` (no como tabla `autores` aparte), porque cada libro tiene un unico autor principal y el alcance de este nivel es relaciones basicas. Una version mas avanzada necesitaria una tabla `autores` propia para manejar coautorias o biografias.
- `genero` se limito a un catalogo cerrado (`space_opera`, `cyberpunk`, `distopia`, `hard_sci_fi`) porque son los subgeneros que aparecen en los datos de prueba de la biblioteca.

## Preguntas que responde la base de datos

1. Que prestamos existen, con que libro y que lector.
2. Que prestamos no estan devueltos todavia.
3. Que lector tiene mas prestamos en total.
4. Como se ordenan los prestamos por fecha de prestamo.
5. Que lectores tienen libros atrasados o perdidos (para decidir a quien contactar esta semana).
