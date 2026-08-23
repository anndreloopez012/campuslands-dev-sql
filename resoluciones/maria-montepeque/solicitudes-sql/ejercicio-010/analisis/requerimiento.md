# Analisis del requerimiento - Ejercicio 010

## Solicitud entendida

Una biblioteca especializada presta libros de ciencia ficcion y controla devoluciones. El cliente pidio explicitamente que el sistema le ayude a detectar errores: registros repetidos (el mismo libro cargado dos veces), relaciones invalidas (un prestamo de un libro que no existe) y valores fuera de rango (por ejemplo, un ano de publicacion imposible).

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| libros | Es el catalogo de libros de ciencia ficcion disponibles para prestamo. | titulo (unico), autor, anio_publicacion, copias_disponibles |
| prestamos | Es el registro transaccional de cada prestamo y su devolucion: que libro, quien lo pidio, cuando y en que estado va (prestado, devuelto, atrasado, perdido). | id_libro (FK), nombre_lector, fecha_prestamo, fecha_devolucion, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| libros -> prestamos | 1:N | Un libro puede prestarse muchas veces a lo largo del tiempo, pero cada prestamo es de un unico libro. |

## Reglas de negocio

- Regla 1: Todo prestamo debe apuntar a un libro real del catalogo (`FOREIGN KEY`); esto evita directamente la "relacion invalida" que preocupa al cliente.
- Regla 2: `anio_publicacion` debe estar en un rango realista (`CHECK BETWEEN 1800 AND 2030`); esto detecta el "valor fuera de rango" que menciona el cliente (por ejemplo, un ano negativo o del futuro lejano por error de digitacion).
- Regla 3: `titulo` no se repite (`UNIQUE`); esto evita el "registro repetido" que preocupa al cliente (cargar el mismo libro dos veces por accidente).
- Regla 4: Un prestamo puede estar `prestado`, `devuelto`, `atrasado` o `perdido` (`CHECK`); el cliente necesita poder corregir este estado (por ejemplo, cuando un libro atrasado finalmente se devuelve).
- Regla 5: `copias_disponibles` nunca puede ser negativo (`CHECK`).

## Supuestos

- No se creo una tabla `autores` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el autor se guarda como texto dentro de `libros`.
- `fecha_devolucion` se deja sin `NOT NULL` a proposito: un prestamo activo todavia no tiene fecha de devolucion real, solo la tendra cuando el libro regrese.
- Un libro marcado como `perdido` se resta manualmente de `copias_disponibles` mediante `UPDATE`, ya que representa una copia que ya no esta disponible para prestar.

## Preguntas que responde la base de datos

1. Que prestamos existen y en que estado quedo cada uno.
2. Que prestamos no estan devueltos todavia (prestados, atrasados o perdidos).
3. Que lector tiene mas prestamos.
4. Como se ordenan los prestamos por fecha.
5. Que libros son los mas prestados historicamente, para decidir si comprar mas copias.
