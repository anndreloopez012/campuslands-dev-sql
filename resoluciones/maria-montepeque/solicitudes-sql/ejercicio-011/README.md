# Ejercicio 011: Solicitud de cliente - Delivery de Comida

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Un negocio de comida a domicilio recibe pedidos, tiene repartidores, menu y calificaciones. Hoy todo se maneja en hojas de calculo y varias personas duplican datos sin darse cuenta.

## Tablas y relaciones

- `menus`: catalogo de platillos (nombre unico, categoria, precio).
- `pedidos`: registro transaccional de cada pedido, con repartidor, estado y calificacion opcional (`menus` 1—N `pedidos`).

No se crearon tablas de `clientes` ni `repartidores` separadas: el alcance de este nivel pide 1 a 2 tablas, asi que ambos se guardan como texto dentro de `pedidos` (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en ambas tablas.
- `FOREIGN KEY`: `pedidos.id_menu` -> `menus.id_menu`.
- `NOT NULL` en todos los campos obligatorios, excepto `calificacion` (opcional, solo aplica a pedidos entregados).
- `UNIQUE`: `menus.nombre_platillo` (evita el problema de duplicados que menciona el cliente).
- `CHECK`: `precio > 0`, `cantidad > 0`, `monto_total > 0`, `calificacion BETWEEN 1 AND 5`, `categoria IN (...)`, `estado IN (...)`.
- `DEFAULT`: `fecha_pedido` con la fecha/hora actual, `estado` en `'recibido'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 6 platillos y 10 pedidos base (uno de ellos, el pedido 10, es una entrada de prueba insertada por error).
- `operaciones.sql` marca un pedido como entregado, ajusta el precio de un platillo y elimina la entrada de prueba: quedan 9 pedidos.
- El caso comentado (`calificacion = 9`) falla al ejecutarlo: `CHECK constraint failed: calificacion BETWEEN 1 AND 5`.
- Cliente con mas pedidos: Ana Gomez, con 3.
- Repartidor con mas entregas completadas: Pedro Gomez y Carlos Ruiz empatan con 2.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-011.db < ddl/schema.sql
sqlite3 ejercicio-011.db < dml/inserts.sql
sqlite3 ejercicio-011.db < dml/operaciones.sql
sqlite3 ejercicio-011.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
