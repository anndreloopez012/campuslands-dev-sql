# Ejercicio 32: Normalizacion Pedidos Restaurante

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-12

## Descripcion del problema

El restaurante administraba sus pedidos en un archivo plano (`datos/datos-sin-normalizar.csv`) con una sola tabla donde `platos`, `categorias`, `precios` y `cantidades` guardaban varios valores separados por `|` en una misma celda, y los datos de mesa y mesero se repetian en cada pedido. Esto generaba duplicidad, anomalias de insercion/actualizacion/eliminacion y dificultaba los reportes. El detalle completo del analisis (dependencias funcionales, problemas y el proceso de normalizacion 1FN -> 2FN -> 3FN) esta en [`analisis/normalizacion.md`](analisis/normalizacion.md).

## Tablas y relaciones

- `mesas`: catalogo de mesas del restaurante (numero).
- `meseros`: catalogo de meseros (nombre).
- `platos`: catalogo de platos del menu con su categoria y precio.
- `pedidos`: encabezado de un pedido (mesa, mesero, fecha). `mesas` 1—N `pedidos` y `meseros` 1—N `pedidos`.
- `detalle_pedido`: linea de plato de un pedido (cantidad y precio unitario aplicado). `pedidos` 1—N `detalle_pedido` y `platos` 1—N `detalle_pedido`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 5 tablas.
- `FOREIGN KEY`: `pedidos.id_mesa`, `pedidos.id_mesero`, `detalle_pedido.id_pedido`, `detalle_pedido.id_plato`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `mesas.numero`, `meseros.nombre`, `platos.nombre`.
- `CHECK`: `platos.categoria IN ('Comida', 'Bebida', 'Postre', 'Acompanamiento')`, `platos.precio > 0`, `detalle_pedido.cantidad > 0`, `detalle_pedido.precio_unitario > 0`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `dql`) con SQLite:

- Datos base: 5 mesas, 5 meseros, 6 platos, 5 pedidos, 10 lineas de `detalle_pedido`. Los pedidos 1-3 (con su mesa, mesero y platos) son equivalentes fila por fila al CSV original; se agregaron 3 mesas, 3 meseros y 2 pedidos adicionales solo para cumplir el minimo de datos pedido por el ejercicio.
- La consulta 1 (`JOIN` que reconstruye el archivo original) reproduce exactamente las filas del CSV: por ejemplo, el pedido 1 vuelve a mostrar `Mesa 4, Sofia Mendez, Pizza, Comida, 85, 2` seguido de `..., Limonada, Bebida, 18, 2, ...`.
- Total por pedido (consulta 4): pedido 1 = 206.00, pedido 2 = 77.00, pedido 3 = 60.00, pedido 4 = 130.00, pedido 5 = 128.00.
- Plato mas pedido por unidades (consulta 8): `Cafe` con 5 unidades.
- Los 2 casos comentados al final de `dml/inserts.sql` fallan al descomentarlos y ejecutarlos: uno por `UNIQUE (mesas.numero)` y otro por `CHECK (detalle_pedido.cantidad > 0)`.

## Como ejecutar

```bash
sqlite3 ejercicio-32.db < ddl/schema.sql
sqlite3 ejercicio-32.db < dml/inserts.sql
sqlite3 ejercicio-32.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
