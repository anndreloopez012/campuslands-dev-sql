# Ejercicio 015: Solicitud de cliente - Laboratorio Quimico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-18

## Descripcion del problema

Un laboratorio quimico registra formulas, muestras, reactivos y resultados. El cliente no piensa en tablas, solo describe su operacion diaria: llega una muestra, se analiza con un reactivo, y se obtiene un resultado (o la muestra se contamina).

## Tablas y relaciones

- `reactivos`: catalogo de reactivos disponibles (nombre unico, unidad de medida, stock).
- `muestras`: registro transaccional de cada muestra analizada (`reactivos` 1—N `muestras`).

No se creo una tabla `formulas` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el modelo se centra en `reactivos` y `muestras` (documentado como supuesto en `analisis/requerimiento.md`).

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en ambas tablas.
- `FOREIGN KEY`: `muestras.id_reactivo` -> `reactivos.id_reactivo`.
- `NOT NULL` en todos los campos obligatorios (excepto `resultado`, opcional mientras la muestra sigue en analisis).
- `UNIQUE`: `reactivos.nombre_reactivo`, `muestras.codigo_muestra`.
- `CHECK`: `unidad_medida IN ('ml', 'g', 'mol', 'L')`, `stock_disponible >= 0`, `estado IN ('en_analisis', 'completado', 'contaminada')`.
- `DEFAULT`: `stock_disponible` en 0, `fecha_analisis` con la fecha actual, `estado` en `'en_analisis'`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python/sqlite3:

- 5 reactivos y 9 muestras base (una de ellas, la muestra 9, es una entrada de prueba insertada por error).
- `operaciones.sql` completa una muestra con su resultado, descuenta stock consumido y elimina la entrada de prueba: quedan 8 muestras.
- El caso comentado (`unidad_medida = 'kg'`) falla al ejecutarlo: `CHECK constraint failed: unidad_medida IN ('ml', 'g', 'mol', 'L')`.
- Reporte de control de calidad (muestras por estado): 5 completadas, 2 en analisis, 1 contaminada (12.5% de tasa de contaminacion).
- Reactivo mas usado: tres reactivos empatan con 2 usos cada uno.

Detalle completo en [evidencias/resultados.md](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-015.db < ddl/schema.sql
sqlite3 ejercicio-015.db < dml/inserts.sql
sqlite3 ejercicio-015.db < dml/operaciones.sql
sqlite3 ejercicio-015.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
