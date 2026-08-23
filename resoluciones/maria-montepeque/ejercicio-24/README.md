# Ejercicio 24: Recursos Humanos

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-06

## Descripcion del problema

Un area de talento humano necesita reemplazar el registro manual de departamentos, cargos, empleados y contratos por una base de datos relacional que evite duplicidad de datos y permita controlar la vigencia y el salario de cada contrato.

## Tablas y relaciones

- `departamentos`: catalogo de departamentos de la organizacion (nombre).
- `cargos`: catalogo de cargos con su salario base (nombre, salario base).
- `empleados`: empleado asignado a un departamento y un cargo (nombre, dpi, fecha de ingreso). `departamentos` 1—N `empleados` y `cargos` 1—N `empleados`.
- `contratos`: contrato laboral de un empleado (tipo, salario, fecha de inicio y fin, estado). `empleados` 1—N `contratos`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `empleados.id_departamento`, `empleados.id_cargo`, `contratos.id_empleado`.
- `NOT NULL` en todos los campos obligatorios (`contratos.fecha_fin` permite `NULL` para contratos vigentes).
- `UNIQUE`: `departamentos.nombre`, `cargos.nombre`, `empleados.dpi`.
- `CHECK`: `cargos.salario_base > 0`, `contratos.salario > 0`, `contratos.tipo IN ('indefinido', 'temporal', 'por_servicios')`, `contratos.estado IN ('activo', 'finalizado', 'suspendido')`.
- `PRAGMA foreign_keys = ON;` activado al inicio del script.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con Python (modulo `sqlite3`), ya que no se tenia el binario `sqlite3` disponible en el entorno:

- Datos base: 5 departamentos, 5 cargos, 5 empleados, 10 contratos.
- Tras aplicar `operaciones.sql`: 6 departamentos, 5 cargos, 5 empleados y 9 contratos (2 insertados, 2 eliminados).
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al descomentarlas y ejecutarlas: una por `UNIQUE (empleados.dpi)` y otra por `CHECK (contratos.tipo IN (...))`.
- Consulta de decision de negocio (departamento con mayor gasto en salarios de contratos activos): `Ventas` con 8000.00.

## Como ejecutar

```bash
sqlite3 ejercicio-24.db < ddl/schema.sql
sqlite3 ejercicio-24.db < dml/inserts.sql
sqlite3 ejercicio-24.db < dml/operaciones.sql
sqlite3 ejercicio-24.db < dql/consultas.sql
```
