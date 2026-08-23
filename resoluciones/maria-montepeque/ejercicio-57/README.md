# Ejercicio 57: CHECK Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Tema central

CHECK

## Descripcion del problema

Sistema de inventario de dispositivos tecnologicos en bodega con tres tablas relacionadas: `categorias`, `productos` (cada producto pertenece a una categoria) y `movimientos` (entradas y salidas, tabla principal). El ejercicio se enfoca en aplicar `CHECK` en varias tablas del mismo modelo: valores permitidos en `categorias` y rangos numericos en `productos` y `movimientos`.

## Que aprendi sobre CHECK

- **La misma tecnica de CHECK se repite en tablas distintas porque cada una tiene su propia regla de dominio**: `categorias.tipo_categoria` usa `CHECK (... IN (...))` para limitar el dominio a una lista cerrada (`hardware`, `software`, `accesorio`), mientras que `productos.precio_unitario` y `movimientos.cantidad` usan `CHECK (... > 0)` para exigir un rango numerico valido.
- **El tipo de dato no basta para expresar una regla de negocio**: `REAL` acepta `0` o `-50` sin quejarse, pero un precio de bodega negativo no tiene sentido; por eso `precio_unitario > 0` es una regla que solo `CHECK` puede imponer, no el tipo de columna.
- **CHECK protege calculos que dependen de esos valores**: si `cantidad` pudiera ser cero o negativa, cualquier reporte de stock que sume movimientos quedaria mal sin que nadie lo note. Exigir `cantidad > 0` en `movimientos` garantiza que cada fila representa un movimiento real de bodega.
- Confirme cada regla con datos: la consulta 5.a muestra que la cantidad minima registrada en movimientos es 5 (nunca cero o negativa) y la 5.b muestra que el precio minimo registrado en productos es 24.75 (nunca cero o negativo).
- Los tres casos comentados prueban cada `CHECK` por separado (tipo de categoria invalido, precio en cero, cantidad negativa) y los tres fallan con `CHECK constraint failed` mostrando la condicion exacta que se violo.

## Como ejecutar

```bash
sqlite3 ejercicio-57.db < ddl/schema.sql
sqlite3 ejercicio-57.db < dml/inserts.sql
sqlite3 ejercicio-57.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
