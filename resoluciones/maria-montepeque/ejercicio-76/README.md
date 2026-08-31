# Ejercicio 76: UPDATE Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-24

## Tema central

UPDATE

## Descripcion del problema

Un sistema de registro de campers administra inscripciones a rutas de
entrenamiento con cupo limitado. Cada vez que un camper se inscribe o
cancela, el cupo disponible de la ruta debe corregirse de inmediato
con `UPDATE`, y al final se necesita poder confirmar que ese cupo
guardado sigue siendo confiable: un caso de negocio con validacion
final, propio del nivel aplicado.

## Tablas y relaciones

- `campers`: catalogo de campers registrados.
- `rutas`: catalogo de rutas, cada una con `cupo_maximo` y
  `cupo_disponible` (este ultimo se corrige con `UPDATE`).
- `inscripciones`: relaciona un camper con una ruta. `campers` 1—N
  `inscripciones`; `rutas` 1—N `inscripciones`.

## Uso de UPDATE

En `dml/inserts.sql`, por cada inscripcion nueva:

1. `UPDATE` con expresion: `cupo_disponible = cupo_disponible - 1` en
   la ruta correspondiente, repetido 6 veces (una por cada
   inscripcion), demostrando que el mismo patron de `UPDATE` se aplica
   de forma consistente cada vez que ocurre el evento de negocio.
2. Cancelacion: dos `UPDATE` en cadena, uno por tabla. Primero
   `inscripciones.estado = 'cancelada'`, despues
   `cupo_disponible = cupo_disponible + 1` en la ruta, para devolver
   el cupo liberado.

La consulta 5 en `dql/consultas.sql` es el reporte final: compara el
`cupo_disponible` que quedo guardado contra un calculo independiente
(`cupo_maximo` menos el conteo de inscripciones `activa`), confirmando
que los `UPDATE` mantuvieron la columna consistente.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `inscripciones.id_camper`, `inscripciones.id_ruta`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `campers.email`, `rutas.nombre_ruta`.
- `CHECK`: `rutas.cupo_maximo > 0`, `rutas.cupo_disponible >= 0`,
  `inscripciones.estado IN (...)`.
- `DEFAULT` en `rutas.cupo_maximo`, `inscripciones.estado` y
  `fecha_inscripcion`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dml/inserts.sql`)

Cumbre Extrema tiene cupo para solo 3 campers; una vez lleno
(`cupo_disponible = 0`), inscribir a un cuarto camper y restar 1 al
cupo dejaria la columna en -1, lo que viola el `CHECK` de
`cupo_disponible >= 0`. Se valido con Python (`sqlite3`), reproduciendo
el estado exacto de la secuencia en ese punto: lanza
`CHECK constraint failed`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

- Datos finales: 6 campers, 3 rutas, 6 inscripciones (5 activas, 1
  cancelada). Reporte final: cupo guardado y cupo calculado coinciden
  en las 3 rutas.

## Como ejecutar

```bash
sqlite3 ejercicio-76.db < ddl/schema.sql
sqlite3 ejercicio-76.db < dml/inserts.sql
sqlite3 ejercicio-76.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
