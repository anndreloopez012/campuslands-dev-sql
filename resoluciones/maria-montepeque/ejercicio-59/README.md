# Ejercicio 59: DEFAULT Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Tema central

DEFAULT

## Descripcion del problema

Sistema de inventario de dispositivos tecnologicos en bodega: `categorias` (soporte) y `productos` (tabla principal). El ejercicio se enfoca en usar `DEFAULT` para los cuatro tipos de valor que menciona el objetivo: estado, fecha, cantidad y bandera, todos en una sola tabla.

## Que aprendi sobre DEFAULT

- **DEFAULT solo actua cuando el INSERT omite la columna, no cuando se le pasa un valor equivocado**: al insertar `LAP-002`, `MON-002` y `PER-001` sin mencionar `estado`, `stock`, `es_fragil` ni `fecha_registro`, los cuatro quedaron completos automaticamente (`disponible`, `0`, `0` y la fecha/hora actual). El caso comentado (`'dispnible'`, con typo) demuestra lo contrario: si el valor se escribe a mano y tiene un error, `DEFAULT` ya no interviene y el `CHECK` lo rechaza.
- **DEFAULT puede usar un valor literal o una expresion**: `estado`, `stock` y `es_fragil` usan literales fijos (`'disponible'`, `0`, `0`), mientras que `fecha_registro` usa `DEFAULT (datetime('now'))`, una expresion que se evalua en el momento del `INSERT`. Por eso cada producto insertado sin fecha explicita quedo con un valor distinto (el momento real de la carga), pero nunca con `NULL`.
- **DEFAULT reduce la carga de escribir INSERTs repetitivos**: en un sistema real, la mayoria de productos nuevos entran como `disponible`, con `stock` en 0 (todavia no llega mercancia) y sin ser fragiles; escribir esos tres valores en cada `INSERT` es trabajo repetido que `DEFAULT` evita sin perder consistencia.
- La consulta 5 compara explicitamente los tres productos que dependieron de `DEFAULT` contra los dos que trajeron todos los valores a mano (`LAP-001`, `MON-001`), mostrando que ambos casos terminan con datos completos y validos.

## Como ejecutar

```bash
sqlite3 ejercicio-59.db < ddl/schema.sql
sqlite3 ejercicio-59.db < dml/inserts.sql
sqlite3 ejercicio-59.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
