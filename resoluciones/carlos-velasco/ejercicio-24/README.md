# Ejercicio 24: Recursos Humanos

## Información

- **Nombre:** Carlos Velasco
- **Fecha:** 2026-08-20
- **Motor:** SQLite
- **Ejercicio:** 24
- **Tema:** Recursos Humanos

## Descripción

El ejercicio implementa una base de datos relacional para administrar información básica de recursos humanos. El modelo permite registrar departamentos, cargos, empleados y contratos, facilitando consultas sobre estructura organizacional, salarios y contratación.

## Modelo implementado

La solución utiliza cuatro tablas:

| Tabla | Responsabilidad |
| --- | --- |
| `departamentos` | Registra las áreas de la organización. |
| `cargos` | Registra los cargos disponibles y su salario base. |
| `empleados` | Registra la información laboral y organizacional de cada empleado. |
| `contratos` | Registra las condiciones contractuales y salariales de los empleados. |

### Relaciones

- `departamentos` se relaciona con `empleados` mediante `id_departamento`.
- `cargos` se relaciona con `empleados` mediante `id_cargo`.
- `empleados` se relaciona con `contratos` mediante `id_empleado`.

## Restricciones

Se implementaron:

- Llaves primarias mediante `PRIMARY KEY`.
- Relaciones mediante `FOREIGN KEY`.
- Campos obligatorios mediante `NOT NULL`.
- Identificadores únicos mediante `UNIQUE`.
- Validaciones mediante `CHECK`.
- Valores predeterminados mediante `DEFAULT`.
- Fechas en formato ISO `YYYY-MM-DD`.
- Integridad referencial mediante `PRAGMA foreign_keys = ON`.

Entre las validaciones principales se encuentran:

```text
departamentos.presupuesto_anual >= 0
cargos.salario_base > 0
contratos.salario > 0
empleados.estado IN ('ACTIVO', 'INACTIVO')
contratos.tipo_contrato IN ('INDEFINIDO', 'FIJO', 'PRACTICAS')
fecha_fin >= fecha_inicio
```

## Datos registrados

La carga inicial contiene:

- 5 departamentos.
- 5 cargos.
- 10 empleados.
- 10 contratos.

La información fue diseñada para que existan relaciones suficientes entre las tablas y todas las consultas solicitadas produzcan resultados.

## Operaciones DML

El archivo `dml/operaciones.sql` contiene:

- 2 operaciones `INSERT` adicionales.
- 2 operaciones `UPDATE`.
- 2 operaciones `DELETE`.
- 2 operaciones inválidas comentadas para demostrar restricciones.

Las operaciones inválidas corresponden a:

1. Un salario negativo que incumple un `CHECK`.
2. Un contrato asociado a un empleado inexistente que incumple una `FOREIGN KEY`.

## Consultas

El archivo `dql/consultas.sql` contiene consultas para:

1. Listar empleados.
2. Seleccionar columnas específicas.
3. Filtrar empleados por fecha.
4. Ordenar empleados.
5. Obtener los cinco salarios más altos.
6. Contar empleados.
7. Calcular promedio, mínimo y máximo salarial.
8. Agrupar empleados por departamento.
9. Relacionar las entidades mediante `JOIN`.
10. Combinar `WHERE`, `ORDER BY` y `LIMIT`.
11. Generar un reporte con alias.
12. Identificar los departamentos con mayor salario promedio.

## Ejecución

Desde la raíz de `ejercicio-24`:

```bash
sqlite3 ejercicio-24.db < ddl/schema.sql
sqlite3 ejercicio-24.db < dml/inserts.sql
sqlite3 ejercicio-24.db < dml/operaciones.sql
sqlite3 ejercicio-24.db < dql/consultas.sql
```

No se debe incluir ningún archivo `.db`, `.sqlite` ni `.sqlite3` en el repositorio.

## Validaciones esperadas

Después de ejecutar `schema.sql` e `inserts.sql`, se esperan:

```text
departamentos: 5 registros
cargos: 5 registros
empleados: 10 registros
contratos: 10 registros
```

Después de ejecutar `operaciones.sql`, los registros adicionales utilizados para las operaciones de prueba son eliminados de forma controlada.

## Decisiones de diseño

Se mantuvo el límite de cuatro tablas solicitado por el ejercicio.

`empleados` funciona como entidad central porque relaciona la estructura organizacional con la información contractual. Los datos de departamentos y cargos se mantienen separados para evitar duplicidad, mientras que `contratos` conserva la información específica de la relación laboral.

Las restricciones `UNIQUE`, `CHECK`, `NOT NULL` y `FOREIGN KEY` permiten validar los datos directamente desde la base de datos y mantener la integridad del modelo.