# Ejercicio 39: Normalizacion Recursos Humanos

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Descripcion del problema

El area de recursos humanos administraba sus contratos en un archivo plano (`datos/datos-sin-normalizar.csv`) con una sola tabla donde `beneficios` guardaba varios valores separados por `|`, y el jefe de cada empleado se registraba como texto libre en vez de como una relacion real con otro empleado. El detalle completo del analisis (dependencias funcionales, problemas y el proceso de normalizacion 1FN -> 2FN -> 3FN) esta en [`analisis/normalizacion.md`](analisis/normalizacion.md).

## Tablas y relaciones

- `empleados`: catalogo de personas de la organizacion (empleados y jefes).
- `cargos`: catalogo de cargos.
- `departamentos`: catalogo de departamentos.
- `beneficios`: catalogo de beneficios.
- `contratos`: contrato de un empleado (cargo, departamento, jefe, salario, fecha). `empleados` 1—N `contratos`, `cargos` 1—N `contratos`, `departamentos` 1—N `contratos`, y `empleados` 1—N `contratos` otra vez via `id_jefe` (auto-referencia, el jefe tambien es un empleado).
- `asignaciones`: tabla puente para la relacion N:M entre `contratos` y `beneficios`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 6 tablas.
- `FOREIGN KEY`: `contratos.id_empleado/id_cargo/id_departamento/id_jefe` (esta ultima apunta de nuevo a `empleados`), `asignaciones.id_contrato/id_beneficio`.
- `NOT NULL` en todos los campos obligatorios (`contratos.id_jefe` es la unica excepcion intencional, para el cargo mas alto que no reporta a nadie).
- `UNIQUE`: `empleados.nombre`, `cargos.nombre`, `departamentos.nombre`, `beneficios.nombre`, `(id_empleado, fecha_contrato)` en `contratos`, `(id_contrato, id_beneficio)` en `asignaciones`.
- `CHECK`: `contratos.salario > 0`, `contratos.fecha_contrato` con formato `YYYY-MM-DD`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `dql`) con SQLite:

- Datos base: 5 empleados, 5 cargos, 5 departamentos, 5 beneficios (catalogos), 6 contratos, 12 lineas de `asignaciones`.
- La consulta 1 (`JOIN` con subconsulta `GROUP_CONCAT`) reconstruye el CSV original, incluyendo el jefe resuelto por auto-referencia a `empleados`.
- La cadena de mando quedo consistente: Karen Xitumul reporta a Luis Bran, que reporta a Ingrid Paz, que no reporta a nadie (`id_jefe = NULL`).
- Empleado con mayor salario (consulta 8): `Ingrid Paz` con 12000.00.
- Los 2 casos comentados al final de `dml/inserts.sql` fallan al descomentarlos y ejecutarlos: uno por `UNIQUE (empleados.nombre)` y otro por `CHECK (salario > 0)`.

## Como ejecutar

```bash
sqlite3 ejercicio-39.db < ddl/schema.sql
sqlite3 ejercicio-39.db < dml/inserts.sql
sqlite3 ejercicio-39.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
