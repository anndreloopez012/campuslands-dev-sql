# Ejercicio 94: HAVING Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-31

## Tema central

HAVING

## Descripcion del problema

Un programa de entrenamiento inscribe campers en distintas rutas, cada
una con un cupo maximo de campers activos. El negocio necesita un
reporte final que detecte automaticamente que rutas estan en
sobrecupo real (mas inscripciones activas que cupo disponible), sin
contar a mano quienes ya se retiraron o ya completaron la ruta.

## Tablas y relaciones

- `campers`: catalogo de campers.
- `rutas`: catalogo de rutas de entrenamiento, con su `cupo_maximo`.
- `inscripciones`: tabla principal, cada fila es la inscripcion de un
  camper a una ruta, con su `estado` (`activo`, `retirado` o
  `completado`). `campers` 1—N `inscripciones`; `rutas` 1—N
  `inscripciones`.

## Uso de HAVING

En `dql/consultas.sql`:

1. Conteo simple (consulta 4): total de inscripciones por ruta sin
   distinguir estado, solo para ver el volumen bruto.
2. Caso de negocio (consulta 5): primero `WHERE estado = 'activo'`
   deja solo las inscripciones que realmente ocupan un cupo (filtro
   por fila, antes de agrupar), luego `GROUP BY id_ruta` agrupa esas
   inscripciones activas por ruta, y `HAVING COUNT(*) > r.cupo_maximo`
   filtra los grupos resultantes quedandose solo con las rutas
   verdaderamente sobrecupadas: "Ruta Backend Nivel 1" (4 activos,
   cupo 3) y "Ruta DevOps Nivel 2" (3 activos, cupo 2). Este es el
   reporte/validacion final que pide el negocio.

## Otras restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 3 tablas.
- `FOREIGN KEY`: `inscripciones.id_camper`, `inscripciones.id_ruta`.
- `NOT NULL` en todas las columnas obligatorias.
- `UNIQUE`: `campers.email`, `rutas.nombre_ruta`.
- `CHECK`: `rutas.cupo_maximo > 0`,
  `inscripciones.estado IN ('activo', 'retirado', 'completado')`.
- `DEFAULT` en `inscripciones.estado`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Caso que falla / no recomendable (comentado en `dql/consultas.sql`)

Omitir el `WHERE estado = 'activo'` y contar TODAS las inscripciones
(incluyendo retiradas y completadas) para decidir el sobrecupo. La
consulta no falla, pero se verifico con Python (`sqlite3`) que produce
un reporte de negocio incorrecto: "Ruta Frontend Nivel 1" aparece como
sobrecupada (4 inscripciones totales > cupo 3), cuando en realidad
solo tiene 2 inscripciones activas y le sobra cupo, porque las otras 2
son un retiro y una ruta ya completada que no ocupan un lugar activo.
La version correcta es la de la consulta 5, que filtra con `WHERE`
antes de agrupar y contar.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `consultas`) con
Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3`
disponible en el entorno. Detalle completo en
[`evidencias/resultados.md`](evidencias/resultados.md).

## Como ejecutar

```bash
sqlite3 ejercicio-94.db < ddl/schema.sql
sqlite3 ejercicio-94.db < dml/inserts.sql
sqlite3 ejercicio-94.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
