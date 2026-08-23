# Ejercicio 34: Normalizacion Clinica Tratamientos

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Descripcion del problema

La clinica administraba sus historias clinicas en un archivo plano (`datos/datos-sin-normalizar.csv`) con una sola tabla donde `tratamientos` y `costos` guardaban varios valores separados por `|` en una misma celda, y los datos de paciente, medico y especialidad se repetian en cada consulta. Esto generaba duplicidad, anomalias de insercion/actualizacion/eliminacion y dificultaba los reportes. El detalle completo del analisis (dependencias funcionales, problemas y el proceso de normalizacion 1FN -> 2FN -> 3FN) esta en [`analisis/normalizacion.md`](analisis/normalizacion.md).

## Tablas y relaciones

- `pacientes`: catalogo de pacientes (nombre, dpi unico).
- `especialidades`: catalogo de especialidades medicas.
- `medicos`: catalogo de medicos, cada uno con su especialidad (`especialidades` 1—N `medicos`).
- `consultas`: encabezado de una consulta (paciente, medico, fecha). `pacientes` 1—N `consultas` y `medicos` 1—N `consultas`.
- `tratamientos`: detalle de cada tratamiento aplicado dentro de una consulta, con su costo. `consultas` 1—N `tratamientos`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 5 tablas.
- `FOREIGN KEY`: `medicos.id_especialidad`, `consultas.id_paciente`, `consultas.id_medico`, `tratamientos.id_consulta`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `pacientes.dpi`, `especialidades.nombre`, `medicos.nombre`, `(id_paciente, id_medico, fecha_consulta)` en `consultas` (evita registrar la misma consulta dos veces), `(id_consulta, nombre)` en `tratamientos` (evita repetir el mismo tratamiento en una consulta).
- `CHECK`: `consultas.fecha_consulta` con formato `YYYY-MM-DD`, `tratamientos.nombre` no puede quedar vacio (`length(nombre) > 0`), `tratamientos.costo > 0`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `dql`) con SQLite:

- Datos base: 5 pacientes, 5 especialidades, 5 medicos, 6 consultas, 12 lineas de `tratamientos`.
- Las filas 1 y 3 del CSV original (misma paciente Rosa Lima, mismo medico Dr. Perez, fechas distintas) se mantienen como dos consultas separadas (`id_consulta = 1` y `3`), cada una con sus propios tratamientos — verificado con la consulta 1 (`JOIN` que reconstruye el archivo original).
- Paciente con mayor gasto total (consulta 8): `Rosa Lima` con 1080.00.
- Los 2 casos comentados al final de `dml/inserts.sql` fallan al descomentarlos y ejecutarlos: uno por `UNIQUE (pacientes.dpi)` y otro por `CHECK (costo > 0)`.

## Como ejecutar

```bash
sqlite3 ejercicio-34.db < ddl/schema.sql
sqlite3 ejercicio-34.db < dml/inserts.sql
sqlite3 ejercicio-34.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
