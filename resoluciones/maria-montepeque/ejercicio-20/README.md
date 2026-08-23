# Ejercicio 20: Eventos Boletos

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-06

## Descripcion del problema

Una plataforma de eventos necesita reemplazar el registro manual de lugares, eventos, asistentes y boletos por una base de datos relacional que evite duplicidad de datos y permita controlar la venta y el estado de cada boleto.

## Tablas y relaciones

- `lugares`: catalogo de lugares donde se realizan los eventos (nombre, ciudad, capacidad).
- `eventos`: evento realizado en un lugar (nombre, fecha, precio base). `lugares` 1—N `eventos`.
- `asistentes`: catalogo de personas que compran boletos (nombre, correo).
- `boletos`: boleto comprado por un asistente para un evento (precio, estado, fecha de compra). `eventos` 1—N `boletos` y `asistentes` 1—N `boletos`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `eventos.id_lugar`, `boletos.id_evento`, `boletos.id_asistente`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `lugares.nombre`, `asistentes.correo`.
- `CHECK`: `lugares.capacidad > 0`, `eventos.precio_base > 0`, `boletos.precio > 0`, `boletos.estado IN ('vendido', 'reservado', 'cancelado')`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3` disponible en el entorno:

- Datos base: 5 lugares, 5 eventos, 5 asistentes, 10 boletos.
- Tras aplicar `operaciones.sql`: 5 lugares, 5 eventos, 6 asistentes y 9 boletos (2 insertados, 2 eliminados).
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al descomentarlas y ejecutarlas: una por `UNIQUE (asistentes.correo)` y otra por `CHECK (boletos.estado IN (...))`.
- Consulta de decision de negocio (evento con mayores ingresos por boletos vendidos): `Concierto Rock Nacional` con 450.00.

## Como ejecutar

```bash
sqlite3 ejercicio-20.db < ddl/schema.sql
sqlite3 ejercicio-20.db < dml/inserts.sql
sqlite3 ejercicio-20.db < dml/operaciones.sql
sqlite3 ejercicio-20.db < dql/consultas.sql
```
