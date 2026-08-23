# Ejercicio 47: FOREIGN KEY Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Tema central

FOREIGN KEY

## Descripcion del problema

Sistema de ventas diarias de una cafeteria: `clientes`, `productos` y `ventas` (tabla principal). El ejercicio se enfoca en como una `FOREIGN KEY` protege la integridad referencial: no deja registrar una venta de un cliente o producto que no existe, y tampoco deja borrar un producto mientras siga referenciado por ventas.

## Que aprendi sobre FOREIGN KEY

- **SQLite no aplica las `FOREIGN KEY` por defecto**: hay que activarlas con `PRAGMA foreign_keys = ON;` en cada conexion. Es lo primero que puse en `ddl/schema.sql`, con un comentario explicando que sin ese PRAGMA, ninguna de las validaciones de este ejercicio fallaria realmente — las llaves foraneas quedarian declaradas mas nunca se harian cumplir.
- **La FOREIGN KEY protege al insertar**: intentar registrar una venta con `id_producto = 999` (que no existe en `productos`) falla con `FOREIGN KEY constraint failed`. Sin esta restriccion, `ventas` podria terminar con referencias a productos inexistentes ("filas huerfanas"), y cualquier reporte que hiciera `JOIN` simplemente perderia esas filas sin avisar.
- **La FOREIGN KEY tambien protege al eliminar**: intentar `DELETE FROM productos WHERE id_producto = 1` falla, porque ese producto todavia esta referenciado por varias ventas. SQLite no permite dejar esas ventas "colgando" de un producto que ya no existe.
- Verifique con una consulta (5.a) que el total de ventas y el total de ventas con `JOIN` exitoso a `clientes` y `productos` es exactamente el mismo (10 y 10): eso demuestra, con datos reales, que ninguna fila de `ventas` quedo con una referencia invalida.

## Como ejecutar

```bash
sqlite3 ejercicio-47.db < ddl/schema.sql
sqlite3 ejercicio-47.db < dml/inserts.sql
sqlite3 ejercicio-47.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
