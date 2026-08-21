# Ejercicio 43: Tipos de datos Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Tema central

Tipos de datos

## Descripcion del problema

Sistema de ventas diarias de una cafeteria: `clientes`, `productos` y `ventas`. Nivel aplicado: cierra la serie de tipos de datos (41 basico, 42 intermedio) con un caso de negocio completo que combina todos los tipos vistos y agrega uno nuevo (`TIME` simulado), terminando en un reporte final.

## Tablas y relaciones

- `clientes`: catalogo de clientes registrados (correo opcional, si son frecuentes).
- `productos`: catalogo del menu (categoria, precio, disponibilidad).
- `ventas`: cada venta registrada, con producto, cantidad, precio cobrado, fecha, hora y forma de pago. `clientes` 1—N `ventas` (opcional: `id_cliente` puede ser `NULL` para ventas de mostrador) y `productos` 1—N `ventas`.

## Que aprendi sobre Tipos de datos

- **INTEGER**: llaves, `cantidad` vendida (siempre unidades enteras).
- **REAL**: `precio` del producto y `precio_unitario` de la venta (el precio cobrado se guarda aparte del precio de catalogo, por si cambia despues). `cantidad * precio_unitario` combina INTEGER y REAL sin perder precision (consulta 5.a).
- **TEXT nullable vs. NOT NULL**: `clientes.correo` es `TEXT` pero sin `NOT NULL`, porque no todos los clientes lo dan; en cambio `clientes.nombre` si es obligatorio. Elegir cuando una columna puede ser `NULL` es parte de decidir bien el tipo de dato, no solo el tipo en si.
- **DATE simulado**: `TEXT` ISO `YYYY-MM-DD` en `fecha_registro` y `fecha_venta`, validado con `CHECK GLOB`, permite `GROUP BY fecha_venta` para el reporte diario (consulta 5.b) sin funciones de conversion.
- **TIME simulado (nuevo en este ejercicio)**: SQLite tampoco tiene tipo `TIME`. Se uso `TEXT` en formato `HH:MM` (24 horas), validado con `CHECK GLOB '[0-2][0-9]:[0-5][0-9]'`. Igual que con `DATE`, el texto ordena correctamente (`ORDER BY fecha_venta, hora_venta` en la consulta 3 da el orden cronologico real).
- **BOOLEAN simulado**: `INTEGER` 0/1 con `CHECK` + `DEFAULT` en `clientes.frecuente`, `productos.disponible` y `ventas.pagado_tarjeta`.
- **NULL en una llave foranea**: `ventas.id_cliente` puede ser `NULL` (venta de mostrador, sin cliente registrado). El reporte final usa `LEFT JOIN` + `COALESCE` para no perder esas ventas del reporte y mostrarlas como "Cliente no registrado" en vez de excluirlas.
- Los dos casos comentados muestran limites distintos: `hora_venta = '25:99'` viola el patron `HH:MM` (el `CHECK GLOB` exige minutos entre `00` y `59`); `cantidad = 0` viola la regla de negocio de que toda venta mueve al menos una unidad.

## Como ejecutar

```bash
sqlite3 ejercicio-43.db < ddl/schema.sql
sqlite3 ejercicio-43.db < dml/inserts.sql
sqlite3 ejercicio-43.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
