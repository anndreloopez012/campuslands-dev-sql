# Ejercicio 03: Biblioteca Tech

## Información

**Nombre:** Carlos Elias Tzoy Velasco  
**Fecha:** 2026-08-20  
**Tecnología:** SQLite  
**Ejercicio:** 03 - Biblioteca Tech

## Descripción del problema

Biblioteca Tech necesita reemplazar el manejo manual de información mediante hojas sueltas por una base de datos relacional.

El sistema permite administrar autores, libros, campers y préstamos, manteniendo relaciones entre las entidades y aplicando restricciones para evitar información inválida o inconsistente.

## Modelo implementado

La solución utiliza cuatro tablas:

- `autores`: almacena la información de los autores.
- `libros`: almacena los libros disponibles en la biblioteca.
- `campers`: almacena los usuarios que realizan préstamos.
- `prestamos`: registra los préstamos y devoluciones.

La tabla `prestamos` relaciona `campers` y `libros`, mientras que `libros` mantiene una relación con `autores`.

## Restricciones aplicadas

### PRIMARY KEY

Todas las tablas poseen una clave primaria:

- `autores.id_autor`
- `libros.id_libro`
- `campers.id_camper`
- `prestamos.id_prestamo`

### FOREIGN KEY

Se implementaron las siguientes relaciones:

- `libros.id_autor` → `autores.id_autor`
- `prestamos.id_libro` → `libros.id_libro`
- `prestamos.id_camper` → `campers.id_camper`

También se habilitó:

```sql
PRAGMA foreign_keys = ON;
```

### NOT NULL

Los campos obligatorios utilizan `NOT NULL`, evitando registros incompletos en datos esenciales.

### UNIQUE

Se aplicaron restricciones `UNIQUE` para:

- ISBN de los libros.
- Correo electrónico de los campers.
- Nombre completo de los autores.

### CHECK

Se aplicaron restricciones para:

- Validar el rango del año de publicación.
- Evitar libros con cero o menos páginas.
- Limitar los niveles de los campers.
- Limitar los estados de los préstamos.
- Evitar fechas de devolución anteriores a la fecha del préstamo.

## Datos registrados

Los datos base contienen:

| Tabla | Registros |
| --- | ---: |
| autores | 5 |
| libros | 5 |
| campers | 5 |
| prestamos | 10 |

Adicionalmente, `operaciones.sql` contiene:

- 2 `INSERT` adicionales.
- 2 `UPDATE` válidos.
- 2 `DELETE` controlados.
- 3 operaciones inválidas comentadas.

## Operaciones realizadas

Las operaciones adicionales permiten demostrar:

- Inserción de información nueva.
- Actualización de registros existentes.
- Eliminación controlada mediante `WHERE`.
- Protección frente a datos duplicados.
- Protección mediante restricciones `CHECK`.
- Protección de relaciones mediante `FOREIGN KEY`.

Las operaciones inválidas están comentadas para que `operaciones.sql` pueda ejecutarse completamente sin detenerse.

## Consultas implementadas

`dql/consultas.sql` contiene 12 consultas que cubren:

1. Listado de préstamos.
2. Selección de dos columnas.
3. Filtrado por fecha.
4. Ordenamiento por fecha.
5. Top 5 de libros más prestados.
6. Conteo total de préstamos.
7. Promedio, mínimo y máximo de páginas.
8. Agrupación por estado.
9. JOIN entre varias tablas.
10. Uso combinado de `WHERE`, `ORDER BY` y `LIMIT`.
11. Reporte con alias legibles.
12. Consulta para identificar libros que requieren priorización de ejemplares.

## Ejecución

Desde la raíz de `ejercicio-03`:

```bash
sqlite3 ejercicio-03.db < ddl/schema.sql
sqlite3 ejercicio-03.db < dml/inserts.sql
sqlite3 ejercicio-03.db < dml/operaciones.sql
sqlite3 ejercicio-03.db < dql/consultas.sql
```

El archivo `.db` utilizado durante las pruebas es únicamente temporal y **no debe subirse al repositorio**.

## Validación

Para comprobar que las cuatro tablas fueron creadas:

```bash
sqlite3 ejercicio-03.db ".tables"
```

Salida esperada:

```text
autores  campers  libros  prestamos
```

Para comprobar las tablas y sus restricciones:

```bash
sqlite3 ejercicio-03.db ".schema"
```

Para comprobar la cantidad de registros:

```sql
SELECT 'autores' AS tabla, COUNT(*) AS registros FROM autores
UNION ALL
SELECT 'libros', COUNT(*) FROM libros
UNION ALL
SELECT 'campers', COUNT(*) FROM campers
UNION ALL
SELECT 'prestamos', COUNT(*) FROM prestamos;
```

Salida esperada después de ejecutar los scripts:

```text
autores|5
libros|5
campers|5
prestamos|10
```

Los dos registros adicionales insertados mediante `operaciones.sql` son posteriormente eliminados mediante los `DELETE`, por lo que el estado final conserva los datos base.

## Resultado final

La solución implementa una base de datos SQLite de cuatro tablas para gestionar una biblioteca académica.

El modelo mantiene integridad referencial mediante claves foráneas, controla datos inválidos mediante `CHECK`, evita duplicados mediante `UNIQUE` y permite demostrar operaciones CRUD y consultas analíticas sobre los préstamos.

El sistema queda preparado para generar reportes sobre utilización de libros, actividad de campers y demanda de material bibliográfico.