### README.md

# Ejercicio 08: Clinica de Citas

## Información

- Nombre: Jose Luis Herrera
- Fecha: 2026-08-20
- Motor: SQLite
- Ejercicio: 08
- Rama: `alumno/joseluis-herrera/ejercicio-08`

## Descripción

La organización necesita reemplazar el registro manual de pacientes, médicos, consultorios y citas por una base de datos relacional que permita administrar la agenda médica, controlar la disponibilidad y generar reportes sobre las citas programadas y atendidas.

## Modelo implementado

La solución utiliza cuatro tablas:

- `pacientes`: almacena los datos de los pacientes.
- `medicos`: registra los médicos, sus especialidades y licencias.
- `consultorios`: controla los espacios disponibles para atención.
- `citas`: registra las citas médicas y relaciona pacientes, médicos y consultorios.

## Relaciones

```text
PACIENTES    1 ───────── N CITAS
MEDICOS      1 ───────── N CITAS
CONSULTORIOS 1 ───────── N CITAS
```

La tabla `citas` funciona como entidad transaccional central porque registra cada atención o reserva y conecta las tres entidades relacionadas con la agenda.

## Datos

```text
Pacientes: 5 registros base
Médicos: 5 registros base
Consultorios: 5 registros base
Citas: 10 registros base
```

Los datos contienen citas distribuidas entre diferentes médicos, pacientes y consultorios para permitir consultas de agenda, disponibilidad y carga de trabajo.

## Consultas

El archivo `dql/consultas.sql` contiene las doce consultas requeridas:

```text
1. Listado completo de citas.
2. Selección de dos columnas relevantes.
3. Filtrado de citas por fecha.
4. Ordenamiento cronológico.
5. Top 5 médicos según cantidad de citas.
6. Conteo total de citas.
7. Primera y última fecha registrada.
8. Agrupación de citas por estado.
9. JOIN entre citas, pacientes y médicos.
10. WHERE + ORDER BY + LIMIT.
11. Reporte completo de agenda con alias.
12. Consulta de decisión sobre carga de trabajo de médicos.
```

## Decisiones de diseño

La tabla `citas` funciona como entidad transaccional central porque registra cada evento de agenda y relaciona al paciente, médico y consultorio.

Las restricciones `UNIQUE` sobre médico-fecha y consultorio-fecha ayudan a evitar conflictos de agenda.

La estructura mantiene separadas las responsabilidades de pacientes, médicos y consultorios para evitar duplicidad de información.