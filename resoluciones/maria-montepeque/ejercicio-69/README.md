# Ejercicio 69: DROP Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-21

## Descripcion del problema

Una clinica agenda citas relacionando pacientes con medicos. La lista
de medicos llego en una tabla temporal de importacion que, una vez
migrada a la tabla definitiva, ya no sirve para nada. Ademas, la clinica
necesita entender que pasa si intenta eliminar una tabla (`medicos`) que
todavia tiene citas dependiendo de ella por `FOREIGN KEY`.

## Tablas y relaciones

- `medicos`: catalogo de medicos, tabla definitiva y permanente.
- `pacientes`: catalogo de pacientes.
- `citas`: relaciona un paciente con un medico en una fecha, con un
  estado. `pacientes` 1—N `citas`; `medicos` 1—N `citas`.

## Uso de DROP

En `ddl/schema.sql`, despues de crear las 3 tablas y migrar los datos de
medicos desde una tabla temporal de importacion, y de registrar
pacientes y citas:

1. `DROP TABLE medicos_temporal;`: elimina la tabla temporal una vez que
   sus datos ya se copiaron a `medicos`. El riesgo real de `DROP` se
   explica en un comentario: ejecutarlo antes de migrar los datos
   habria perdido esa informacion para siempre.
2. `CREATE VIEW vista_citas_atendidas ...` seguido de
   `DROP VIEW vista_citas_atendidas;`: se crea una vista de apoyo para
   un reporte puntual y se elimina cuando ya no se va a reutilizar.
   `DROP VIEW` no afecta los datos de `citas`, `pacientes` ni `medicos`.

La consulta 5 en `dql/consultas.sql` confirma, consultando
`sqlite_master`, que la tabla temporal y la vista ya no existen,
mientras que los 2 medicos migrados siguen disponibles en `medicos`.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `citas.id_paciente`, `citas.id_medico`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `medicos.nombre`, `pacientes.telefono`.
- `CHECK`: `citas.estado IN (...)`.
- `DEFAULT` en `citas.estado`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `ddl/schema.sql`)

`DROP TABLE medicos;` falla porque `citas` todavia tiene filas que
dependen de `medicos` por `FOREIGN KEY`, y SQLite (con
`PRAGMA foreign_keys = ON`) no permite eliminar una tabla que sigue
siendo referenciada. Se valido ejecutandolo con Python (`sqlite3`):
lanza `IntegrityError: FOREIGN KEY constraint failed`. Para poder
eliminar `medicos` habria que primero eliminar o reasignar las citas
que dependen de ella (o eliminar `citas` antes que `medicos`).

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 2 medicos, 4 pacientes, 4 citas.

## Como ejecutar

```bash
sqlite3 ejercicio-69.db < ddl/schema.sql
sqlite3 ejercicio-69.db < dml/inserts.sql
sqlite3 ejercicio-69.db < dql/consultas.sql
```
