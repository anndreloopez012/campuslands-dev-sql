# Ejercicio 96: JOIN Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-31

## Tema central

JOIN

## Descripcion del problema

Un programa de entrenamiento necesita saber que campers todavia no se
han inscrito a ninguna ruta, para darles seguimiento, combinando datos
de campers, rutas e inscripciones.

## Tablas y relaciones

- `campers`: catalogo de campers.
- `rutas`: catalogo de rutas de entrenamiento.
- `inscripciones`: tabla principal, cada fila conecta un camper con
  una ruta y su `estado`. `campers` 1—N `inscripciones`; `rutas` 1—N
  `inscripciones`.

## Uso de JOIN

En `dql/consultas.sql`:

1. `INNER JOIN` de 3 tablas (consulta 1): combina `inscripciones` con
   `campers` y `rutas` para mostrar nombre de camper y nombre de ruta
   en vez de solo los ids.
2. `LEFT JOIN` con patron "anti-join" (consulta 5): parte de `campers`
   (tabla izquierda) con `LEFT JOIN` hacia `inscripciones`; los
   campers sin ninguna inscripcion quedan con `id_inscripcion` en
   `NULL`, y `WHERE i.id_inscripcion IS NULL` se queda solo con esos,
   revelando a "Elena Ruiz" como la unica sin inscripciones.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `inscripciones.id_camper`, `inscripciones.id_ruta`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `campers.email`, `rutas.nombre_ruta`.
- `CHECK`: `inscripciones.estado IN ('activo', 'retirado', 'completado')`.
- `DEFAULT` en `inscripciones.estado`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

Usar `LEFT JOIN campers -> inscripciones` pero filtrar con
`WHERE i.estado = 'activo'`, esperando ver a todos los campers con su
estado activo (o vacio si no tienen ninguno). Como `WHERE` se evalua
despues del `JOIN` y descarta las filas con `NULL`, esto elimina
exactamente a los campers sin inscripcion o solo con inscripciones
retiradas, y el `LEFT JOIN` termina comportandose igual que un
`INNER JOIN`. Se verifico con Python (`sqlite3`) que la consulta
devuelve solo 3 campers (Ana, Byron, Diego) en vez de los 6 esperados,
perdiendo justo a "Elena Ruiz" (sin inscripciones), "Carla Gomez" y
"Fernando Diaz" (solo con inscripciones `retirado`). La condicion
sobre la tabla derecha debe ir en el `ON`, no en el `WHERE`, para
conservar el efecto de `LEFT JOIN`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-96.db < ddl/schema.sql
sqlite3 ejercicio-96.db < dml/inserts.sql
sqlite3 ejercicio-96.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
