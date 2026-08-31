# Ejercicio 78: DELETE Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Tema central

DELETE

## Descripcion del problema

Un sistema de registro de campers necesita limpiar inscripciones
duplicadas y canceladas sin arriesgar el resto de los datos, y tambien
poder descontinuar una ruta de entrenamiento sin perder el historial
de quien esta inscrito en ella.

## Tablas y relaciones

- `campers`: catalogo de campers registrados.
- `rutas`: catalogo de rutas, con una bandera `activa` para la baja
  logica.
- `inscripciones`: relaciona un camper con una ruta. `campers` 1—N
  `inscripciones`; `rutas` 1—N `inscripciones`.

## Uso de DELETE

En `dml/inserts.sql`:

1. `DELETE` de una sola fila: Mario Ixtabalan quedo inscrito dos veces
   en Cumbre Extrema por error de digitacion; se elimina solo la copia
   duplicada con `WHERE id_inscripcion = 3`.
2. `DELETE` multiple: todas las inscripciones `'cancelada'` de
   cualquier ruta se eliminan de una sola vez con
   `WHERE estado = 'cancelada'`, sin listar cada id a mano. Este es el
   diferenciador de nivel intermedio frente al DELETE de una sola fila
   del nivel basico.
3. Baja logica (sin `DELETE`): Cumbre Extrema se descontinua, pero
   todavia tiene inscripciones activas. En vez de intentar borrarla,
   se marca `activa = 0` con `UPDATE`.

La consulta 5 en `dql/consultas.sql` confirma que ya no queda ninguna
inscripcion cancelada y que el total final es el esperado.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `inscripciones.id_camper`, `inscripciones.id_ruta`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `campers.email`, `rutas.nombre_ruta`.
- `CHECK`: `rutas.cupo_maximo > 0`, `rutas.activa IN (0, 1)`,
  `inscripciones.estado IN (...)`.
- `DEFAULT` en `rutas.cupo_maximo`, `rutas.activa`,
  `inscripciones.estado` y `fecha_inscripcion`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dml/inserts.sql`)

`DELETE FROM rutas WHERE id_ruta = 1;` falla porque Cumbre Extrema
todavia tiene inscripciones activas que dependen de ella por
`FOREIGN KEY`. Se valido con Python (`sqlite3`): lanza
`FOREIGN KEY constraint failed`. Esto justifica usar baja logica
(`UPDATE activa = 0`) en vez de `DELETE` para rutas con inscripciones
vigentes.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 3 inscripciones (todas activas), Cumbre Extrema dada
  de baja logica.

## Como ejecutar

```bash
sqlite3 ejercicio-78.db < ddl/schema.sql
sqlite3 ejercicio-78.db < dml/inserts.sql
sqlite3 ejercicio-78.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
