# Ejercicio 029: Solicitud de cliente - Tienda Sneakers

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Una tienda de ropa urbana vende sneakers en distintas tallas y necesita guardar historico porque en auditorias le preguntan que paso y cuando paso con cada pedido.

## Tablas y relaciones

- `clientes`: catalogo de clientes (nombre unico, email unico).
- `pedidos`: catalogo/cabecera de cada pedido, con sus datos permanentes (`clientes` 1—N `pedidos`).
- `eventos_pedido`: historico/bitacora de auditoria, un evento por fila con su fecha exacta (`pedidos` 1—N `eventos_pedido`).

No se crearon tablas `productos` ni `tallas` separadas: el modelo y la talla se guardan dentro de `pedidos`, ya que cada pedido es de un modelo y talla especificos (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las tres tablas.
- `FOREIGN KEY`: `pedidos.id_cliente` -> `clientes.id_cliente`, `eventos_pedido.id_pedido` -> `pedidos.id_pedido`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `clientes.nombre_cliente`, `clientes.email`.
- `CHECK`: `talla BETWEEN 20 AND 46`, `precio > 0`, `tipo_evento IN (...)`, `estado IN ('valido', 'anulado')`.
- `DEFAULT`: `eventos_pedido.fecha_evento` con la fecha/hora actual, `eventos_pedido.estado` en `'valido'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 clientes, 5 pedidos y 10 eventos base en el historico (uno de ellos, el evento 10, es una entrada de prueba insertada por error).
- `operaciones.sql` confirma un evento que estaba anulado en espera de stock, actualiza el correo de un cliente y elimina la entrada de prueba (la unica fila del historico que se borra): quedan 9 eventos.
- El caso comentado (`tipo_evento = 'extraviado'`) falla al ejecutarlo: `CHECK constraint failed: tipo_evento IN (...)`.
- Reporte de auditoria (ultimo evento por pedido): responde en un vistazo en que quedo cada pedido sin revisar todo el historico.
- Pedido con mas eventos: el de Ana Gomez, con 4 (ciclo de vida completo: creado, pagado, enviado, entregado).

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-029.db < ddl/schema.sql
sqlite3 ejercicio-029.db < dml/inserts.sql
sqlite3 ejercicio-029.db < dml/operaciones.sql
sqlite3 ejercicio-029.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
