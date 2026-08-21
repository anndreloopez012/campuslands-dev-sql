### README.md

# Ejercicio 03: Biblioteca Tech

## Información

- Nombre: Jose Luis Herrera
- Fecha: 2026-08-20
- Motor: SQLite
- Ejercicio: 03
- Rama: `alumno/joseluis-herrera/ejercicio-03`

## Descripción

La organización necesita reemplazar el registro manual de libros, autores, campers y prestamos por una base de datos relacional que permita controlar los prestamos y devoluciones, reducir duplicidad de información y facilitar la generación de reportes.

## Modelo implementado

La solución utiliza cuatro tablas:

- `autores`: almacena la información de los autores.
- `libros`: almacena los libros y su disponibilidad.
- `campers`: almacena los usuarios de la biblioteca.
- `prestamos`: registra los prestamos y devoluciones.

## Relaciones

```text
AUTORES 1 ─────── N LIBROS
LIBROS  1 ─────── N PRESTAMOS
CAMPERS 1 ─────── N PRESTAMOS
```

## Restricciones

- Todas las tablas poseen `PRIMARY KEY`.
- `libros.id_autor` referencia `autores.id_autor`.
- `prestamos.id_libro` referencia `libros.id_libro`.
- `prestamos.id_camper` referencia `campers.id_camper`.
- `libros.isbn` posee restricción `UNIQUE`.
- `autores.nombre_completo` posee restricción `UNIQUE`.
- `campers.email` posee restricción `UNIQUE`.
- Los campos obligatorios utilizan `NOT NULL`.
- `libros.anio_publicacion` utiliza `CHECK`.
- `libros.ejemplares_disponibles` utiliza `CHECK`.
- `campers.estado` utiliza `CHECK`.
- `prestamos.estado` utiliza `CHECK`.
- `prestamos.fecha_devolucion` utiliza `CHECK`.
- Las llaves foráneas se activan mediante `PRAGMA foreign_keys = ON`.

## Datos

```text
Autores: 5 registros base
Libros: 5 registros base
Campers: 5 registros base
Prestamos: 10 registros base
```

Los datos contienen prestamos devueltos y prestamos activos para permitir consultas sobre historial, estados y disponibilidad.

## Decisiones de diseño

La tabla `prestamos` funciona como entidad transaccional central porque conecta los libros con los campers y registra las fechas y el estado de cada operación.

La información de autores, libros y campers se mantiene separada para evitar duplicidad y permitir relaciones mediante llaves foráneas.

Las restricciones garantizan la integridad de identificadores, correos, ISBN, estados, disponibilidad y fechas.