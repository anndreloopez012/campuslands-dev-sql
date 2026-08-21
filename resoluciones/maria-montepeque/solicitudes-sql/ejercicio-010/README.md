# Ejercicio 010: Solicitud de cliente - Biblioteca Sci-Fi

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Una biblioteca especializada presta libros de ciencia ficcion y controla devoluciones. El cliente pidio explicitamente poder detectar errores: registros repetidos, relaciones invalidas o valores fuera de rango.

## Tablas y relaciones

- `libros`: catalogo de libros de ciencia ficcion (titulo unico, autor, ano de publicacion, copias disponibles).
- `prestamos`: registro transaccional de cada prestamo y su devolucion (`libros` 1—N `prestamos`).

No se creo una tabla `autores` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el autor se guarda como texto dentro de `libros` (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en ambas tablas.
- `FOREIGN KEY`: `prestamos.id_libro` -> `libros.id_libro` (evita relaciones invalidas).
- `NOT NULL` en todos los campos obligatorios (excepto `fecha_devolucion`, que es legitimamente opcional mientras el prestamo sigue activo).
- `UNIQUE`: `libros.titulo` (evita registros repetidos).
- `CHECK`: `anio_publicacion BETWEEN 1800 AND 2030` (detecta valores fuera de rango), `copias_disponibles >= 0`, `estado IN ('prestado', 'devuelto', 'atrasado', 'perdido')`.
- `DEFAULT`: `copias_disponibles` en 1, `fecha_prestamo` con la fecha actual, `estado` en `'prestado'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 6 libros y 10 prestamos base (uno de ellos, el prestamo 10, es una entrada de prueba insertada por error).
- `operaciones.sql` corrige un prestamo atrasado a devuelto, reduce el inventario de un libro perdido y elimina la entrada de prueba: quedan 9 prestamos.
- El caso comentado (`anio_publicacion = 3050`) falla al ejecutarlo: `CHECK constraint failed: anio_publicacion BETWEEN 1800 AND 2030`.
- Lector con mas prestamos: Ana Gomez, con 3.
- Libros mas prestados: `Dune`, `Fundacion` y `Neuromante` empatan con 2 prestamos cada uno.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-010.db < ddl/schema.sql
sqlite3 ejercicio-010.db < dml/inserts.sql
sqlite3 ejercicio-010.db < dml/operaciones.sql
sqlite3 ejercicio-010.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
