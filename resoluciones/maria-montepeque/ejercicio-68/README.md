# Ejercicio 68: DROP Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-21

## Descripcion del problema

Una biblioteca tecnica recibio un listado de libros nuevos en una tabla
temporal de importacion, sin las restricciones finales del modelo.
Despues de migrar esos datos a la tabla definitiva `libros`, la tabla
temporal ya no sirve para nada y debe eliminarse. Lo mismo ocurre con un
indice y una vista que se usaron para un analisis puntual: una vez que
cumplieron su proposito, se eliminan sin afectar los datos reales.

## Tabla principal

- `libros`: tabla definitiva y permanente (titulo, categoria,
  disponible).

## Uso de DROP

En `ddl/schema.sql`, despues de crear `libros` y migrar datos desde una
tabla temporal de importacion:

1. `DROP TABLE libros_importacion_temporal;`: elimina la tabla temporal
   una vez que sus datos ya se copiaron a `libros`. El riesgo real de
   `DROP` se explica en un comentario: si se ejecutara antes de migrar
   los datos, esa informacion se perderia para siempre, porque `DROP`
   no se puede deshacer.
2. `CREATE INDEX idx_libros_categoria ...` seguido de
   `DROP INDEX idx_libros_categoria;`: se crea un indice para un
   analisis puntual y se elimina despues, porque con pocos libros no
   aporta beneficio. Los datos de `libros` no se ven afectados.
3. `CREATE VIEW vista_libros_programacion ...` seguido de
   `DROP VIEW vista_libros_programacion;`: se crea una vista de apoyo
   para un reporte puntual y se elimina cuando ya no se va a
   reutilizar. `DROP VIEW` solo borra la definicion de la vista, nunca
   los datos de la tabla base.

La consulta 5 en `dql/consultas.sql` confirma, consultando
`sqlite_master`, que los 3 objetos (tabla temporal, indice y vista) ya
no existen, mientras que los 3 libros que se migraron desde la tabla
temporal siguen disponibles en `libros`.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental.
- `NOT NULL` en todas las columnas.
- `UNIQUE`: `libros.titulo`.
- `CHECK`: `categoria IN (...)`, `disponible IN (0, 1)`.
- `DEFAULT` en `disponible`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `ddl/schema.sql`)

`DROP TABLE libros_importacion_temporal;` (una segunda vez) falla
porque la tabla ya no existe: se elimino antes en el mismo script. Se
valido ejecutandolo con Python (`sqlite3`): lanza
`OperationalError: no such table: libros_importacion_temporal`. Esto
demuestra por que en un script real conviene usar
`DROP TABLE IF EXISTS` cuando no se esta seguro de si el objeto ya fue
eliminado.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 6 libros (3 migrados desde la tabla temporal, 3
  agregados directamente en `dml/inserts.sql`).

## Como ejecutar

```bash
sqlite3 ejercicio-68.db < ddl/schema.sql
sqlite3 ejercicio-68.db < dml/inserts.sql
sqlite3 ejercicio-68.db < dql/consultas.sql
```
