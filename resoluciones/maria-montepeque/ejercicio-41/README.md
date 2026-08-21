# Ejercicio 41: Tipos de datos Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Tema central

Tipos de datos

## Descripcion del problema

Sistema de inventario de dispositivos tecnologicos en bodega: `categorias`, `productos` y `movimientos` (entradas/salidas). El ejercicio se enfoca en elegir y justificar el tipo de dato correcto para cada columna, incluyendo dos tipos que SQLite no tiene de forma nativa (`DATE` y `BOOLEAN`) y que hay que simular.

## Que aprendi sobre Tipos de datos

- **INTEGER**: para todo lo que es intrinsecamente un numero entero — llaves primarias/foraneas, `stock` (unidades) y `cantidad` en movimientos. Nunca usar `REAL` para cantidades de unidades: aceptaria valores como `2.5`, que no tienen sentido para "2.5 mouses".
- **REAL**: para `precio`, que si necesita decimales (quetzales con centavos). Usar `INTEGER` aqui perderia precision.
- **TEXT**: para nombres y para "enums" simulados (`tipo` en movimientos, restringido con `CHECK (tipo IN ('entrada','salida'))`), ya que SQLite no tiene un tipo `ENUM` nativo.
- **DATE simulado**: SQLite no tiene tipo `DATE`. Se uso `TEXT` en formato ISO `YYYY-MM-DD`, validado con `CHECK ... GLOB`. La ventaja de elegir el formato ISO (y no `DD/MM/YYYY`) es que el orden alfabetico de ese texto coincide exactamente con el orden cronologico, por lo que `WHERE fecha >= '2026-07-10'` y `ORDER BY fecha` funcionan igual que si fuera un tipo fecha real (lo demuestro en la consulta 5.a).
- **BOOLEAN simulado**: SQLite tampoco tiene tipo `BOOLEAN`. Se uso `INTEGER` restringido a `0`/`1` con `CHECK (activo IN (0,1))` y `DEFAULT 1`. Esto permite operarlo como numero (`SUM(activo)` cuenta directamente los productos activos, consulta 5.b) sin conversiones, algo que un `TEXT 'si'/'no'` no permitiria.
- El caso comentado (`activo = 2`) muestra por que el `CHECK` es indispensable: sin el, `INTEGER` aceptaria cualquier numero y la simulacion de booleano dejaria de ser confiable. Lo mismo con la fecha en formato `DD/MM/YYYY`: rompe el orden alfabetico-cronologico y el `CHECK` la rechaza.

## Como ejecutar

```bash
sqlite3 ejercicio-41.db < ddl/schema.sql
sqlite3 ejercicio-41.db < dml/inserts.sql
sqlite3 ejercicio-41.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
