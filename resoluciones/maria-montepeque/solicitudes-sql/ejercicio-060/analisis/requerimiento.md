# Analisis del requerimiento - Ejercicio 060

## Solicitud entendida

Una biblioteca especializada presta libros de ciencia ficcion y controla devoluciones. El cliente quiere detectar tres tipos de error: registros repetidos, relaciones invalidas y valores fuera de rango. Es nivel 3, con 4 tablas: a diferencia de una version mas basica de este mismo caso (donde el autor se guardaba como texto dentro del libro), aqui `autores` es su propia tabla.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| autores | Es el catalogo de autores. | nombre_autor (unico), nacionalidad |
| libros | Es el catalogo de libros, cada uno de un autor. | titulo, id_autor (FK), genero |
| lectores | Es el catalogo de lectores registrados. | nombre_lector (unico), email (unico) |
| prestamos | Es el registro transaccional de cada prestamo: que libro, que lector, cuando y en que estado va. Aqui es donde la biblioteca detecta errores y corrige resultados. | id_libro (FK), id_lector (FK), fecha_prestamo, fecha_devolucion_esperada, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| autores -> libros | 1:N | Un autor puede tener varios libros en el catalogo. |
| libros -> prestamos | 1:N | Un libro puede tener muchos prestamos. |
| lectores -> prestamos | 1:N | Un lector puede tener muchos prestamos. |

## Reglas de negocio

Cada regla ataca uno de los tres errores que el cliente quiere detectar:

- Regla 1 (relaciones invalidas): Todo libro debe apuntar a un autor real; todo prestamo debe apuntar a un libro real y a un lector real (`FOREIGN KEY` en cadena).
- Regla 2 (registros repetidos): `nombre_autor`, `nombre_lector` y `email` no se repiten (`UNIQUE`); un mismo autor no puede repetir el mismo `titulo` dos veces (`UNIQUE` compuesto sobre `titulo` + `id_autor`).
- Regla 3 (valores fuera de rango): `fecha_devolucion_esperada` siempre debe ser posterior a `fecha_prestamo` (`CHECK`).
- Regla 4: `nacionalidad` y `genero` son `NOT NULL`.
- Regla 5: Un prestamo puede estar `prestado`, `devuelto`, `atrasado` o `perdido` (`CHECK`); se corrige con `UPDATE`.
- Regla 6: Solo se permite `DELETE` de un prestamo cuando es un duplicado exacto de otro prestamo ya existente (mismo libro, mismo lector, misma fecha de prestamo). Se conserva siempre el primero que se registro; nunca se borra un prestamo que sea unico.

## Supuestos

- A diferencia de una version mas simple de este mismo caso (donde el autor se guardaba como texto dentro de `libros`), aqui se creo una tabla `autores` real con `FOREIGN KEY`, siguiendo el alcance de este nivel (4 tablas).

## Preguntas que responde la base de datos

1. Que prestamos existen, con que libro, que autor y que lector.
2. Que prestamos no estan devueltos todavia.
3. Que lector tiene mas prestamos.
4. Como se ordenan los prestamos por fecha.
5. Que autor tiene mas prestamos en total, para decidir de cual comprar mas ejemplares.
