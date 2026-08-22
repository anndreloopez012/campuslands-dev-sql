# Análisis de normalización

## Tabla original sin normalizar

La estructura inicial contiene:

```text
libro
autores
generos
usuario
prestamos
fechas_devolucion
```

Los campos `autores`, `generos`, `prestamos` y `fechas_devolucion` pueden contener múltiples valores relacionados dentro de una misma fila.

## Problemas detectados

La estructura original presenta:

- Múltiples autores almacenados en una misma celda.
- Múltiples géneros almacenados en una misma celda.
- Información repetida de libros.
- Información repetida de usuarios.
- Varios préstamos representados dentro de una misma estructura.
- Fechas de devolución asociadas a múltiples préstamos.
- Dificultad para actualizar un autor.
- Dificultad para actualizar un género.
- Anomalías de inserción.
- Anomalías de actualización.
- Anomalías de eliminación.
- Dificultad para consultar libros de un autor específico.
- Dificultad para contar préstamos por usuario.

## Clave candidata

En la tabla original, una combinación de libro, usuario y fecha de préstamo puede identificar un préstamo.

En el modelo normalizado se utiliza `id_prestamo` como identificador único de cada préstamo.

## Dependencias funcionales

Las principales dependencias funcionales son:

```text
id_autor -> nombre_completo, nacionalidad, fecha_nacimiento

id_genero -> nombre, descripcion

id_libro -> titulo, isbn, anio_publicacion, editorial, ejemplares, estado

id_usuario -> nombre_completo, documento, email, telefono, estado

id_prestamo -> id_usuario, fecha_prestamo, fecha_devolucion_prevista, estado

id_detalle -> id_prestamo, id_libro, fecha_devolucion_real
```

Las relaciones muchos a muchos producen además:

```text
(id_libro, id_autor) -> relación libro-autor

(id_libro, id_genero) -> relación libro-genero
```

## Primera Forma Normal

La tabla original viola 1FN porque existen grupos repetidos.

Por ejemplo:

```text
autores = "Autor A, Autor B"
generos = "Genero A, Genero B"
prestamos = "Prestamo 1, Prestamo 2"
```

Se separan los valores en registros individuales.

El resultado incluye:

```text
LIBRO_AUTOR
id_libro
id_autor

LIBRO_GENERO
id_libro
id_genero

DETALLE_PRESTAMO
id_detalle
id_prestamo
id_libro
fecha_devolucion_real
```

Cada atributo contiene un valor atómico.

## Segunda Forma Normal

En 2FN se eliminan dependencias parciales.

Los datos propios de los libros se separan de las relaciones con autores y géneros.

Los datos propios de los autores se mantienen en `autores`.

Los datos propios de los géneros se mantienen en `generos`.

Los datos propios de los usuarios se mantienen en `usuarios`.

Los datos del préstamo se mantienen en `prestamos`.

Las relaciones de muchos a muchos utilizan tablas puente.

## Tercera Forma Normal

En 3FN se eliminan dependencias transitivas.

Los datos de cada autor aparecen solamente en `autores`.

Los datos de cada género aparecen solamente en `generos`.

Los datos de cada libro aparecen solamente en `libros`.

Los datos del usuario aparecen solamente en `usuarios`.

La información de cada préstamo aparece solamente en `prestamos`.

Los libros asociados a cada préstamo se registran mediante `detalle_prestamo`.

## Justificación de las tablas finales

### autores

Almacena la información propia de cada autor.

### generos

Centraliza los géneros disponibles para evitar repetir nombres y descripciones.

### libros

Almacena la información bibliográfica de cada libro.

### usuarios

Almacena los datos de las personas que realizan préstamos.

### prestamos

Representa cada operación de préstamo realizada por un usuario.

### detalle_prestamo

Relaciona cada préstamo con los libros que contiene.

### libro_autor

Resuelve la relación muchos a muchos entre libros y autores.

Un libro puede tener varios autores y un autor puede participar en varios libros.

### libro_genero

Resuelve la relación muchos a muchos entre libros y géneros.

Un libro puede pertenecer a varios géneros y un género puede estar asociado a varios libros.

## Resultado de la normalización

El modelo final queda compuesto por:

```text
AUTORES
GENEROS
LIBROS
USUARIOS
PRESTAMOS
DETALLE_PRESTAMO
LIBRO_AUTOR
LIBRO_GENERO
```

La estructura permite administrar libros multiautor, múltiples géneros y préstamos con uno o varios libros sin almacenar listas de valores dentro de una misma celda.