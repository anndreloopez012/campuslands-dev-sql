# Ejercicio 21: Logistica Envios

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-06

## Descripcion del problema

Una empresa logistica necesita reemplazar el registro manual de clientes, paquetes, rutas y envios por una base de datos relacional que evite duplicidad de datos y permita dar seguimiento al estado y costo de cada envio.

## Tablas y relaciones

- `clientes`: catalogo de clientes que envian paquetes (nombre, telefono, correo).
- `paquetes`: paquete registrado por un cliente (descripcion, peso). `clientes` 1—N `paquetes`.
- `rutas`: ruta disponible entre un origen y un destino (distancia en km).
- `envios`: envio de un paquete a traves de una ruta (fecha, estado, costo). `paquetes` 1—N `envios` y `rutas` 1—N `envios`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `paquetes.id_cliente`, `envios.id_paquete`, `envios.id_ruta`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `clientes.telefono`, `clientes.correo` y `rutas (origen, destino)` para evitar rutas duplicadas.
- `CHECK`: `paquetes.peso > 0`, `rutas.distancia_km > 0`, `envios.costo > 0`, `envios.estado IN ('pendiente', 'en_transito', 'entregado', 'cancelado')`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3` disponible en el entorno:

- Datos base: 5 clientes, 5 paquetes, 5 rutas, 10 envios.
- Tras aplicar `operaciones.sql`: 6 clientes, 5 paquetes, 5 rutas y 9 envios (2 insertados, 2 eliminados).
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al descomentarlas y ejecutarlas: una por `UNIQUE (rutas.origen, destino)` y otra por `CHECK (envios.estado IN (...))`.
- Consulta de decision de negocio (ruta con mayores ingresos por envios entregados): `Ciudad de Guatemala -> Antigua Guatemala` con 150.00.

## Como ejecutar

```bash
sqlite3 ejercicio-21.db < ddl/schema.sql
sqlite3 ejercicio-21.db < dml/inserts.sql
sqlite3 ejercicio-21.db < dml/operaciones.sql
sqlite3 ejercicio-21.db < dql/consultas.sql
```
