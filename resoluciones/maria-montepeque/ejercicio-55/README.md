# Ejercicio 55: NOT NULL Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Tema central

NOT NULL

## Descripcion del problema

Sistema de inventario de dispositivos tecnologicos en bodega: `categorias`, `productos` y `movimientos` (entradas y salidas, tabla principal). El caso de negocio requiere un reporte final confiable de stock actual por producto, lo cual solo es posible si los campos que alimentan ese calculo (`cantidad`, `fecha_movimiento`) son obligatorios.

## Que aprendi sobre NOT NULL

- **NOT NULL protege la integridad de un reporte agregado, no solo la de una fila individual**: el reporte de stock (consulta 4) usa `SUM(cantidad)` sobre todos los movimientos. Si `cantidad` pudiera quedar `NULL`, `SUM()` la ignoraria sin avisar y el stock calculado seria incorrecto sin que se note el error. Por eso `movimientos.cantidad` es `NOT NULL`.
- **Un caso de negocio aplicado obliga a pensar en que dato es minimo para poder auditar, no solo para poder guardar el registro**: `fecha_movimiento` es `NOT NULL` porque sin fecha no se puede reconstruir el historial de bodega ni confiar en el reporte final.
- **Lo opcional en este modelo es informacion de excepcion, no de rutina**: `observaciones` en `movimientos` solo se llena quando hay algo particular que anotar (una devolucion, un producto defectuoso); de 12 movimientos de prueba, solo 3 tienen observaciones, y eso es exactamente lo esperado porque no lleva `NOT NULL`.
- Confirme la obligatoriedad con datos: la consulta 5.a compara `COUNT(*)` contra `COUNT(cantidad)` (12 y 12, coinciden), mientras que 5.b hace el mismo contraste con `observaciones` (12 y 3, no coinciden porque es opcional).
- Los dos casos comentados muestran `NOT NULL` en columnas de tablas distintas: `productos.nombre_producto` y `movimientos.cantidad`. Ambos fallan con `NOT NULL constraint failed` sobre la columna correspondiente.

## Como ejecutar

```bash
sqlite3 ejercicio-55.db < ddl/schema.sql
sqlite3 ejercicio-55.db < dml/inserts.sql
sqlite3 ejercicio-55.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
