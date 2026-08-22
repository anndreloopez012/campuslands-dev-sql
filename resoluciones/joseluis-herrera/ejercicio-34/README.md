# Ejercicio 34: Normalización Clínica Tratamientos

## Información

- Ejercicio: 34
- Tema: Normalización de datos
- Nivel: Intermedio
- Estudiante: Jose Luis Herrera

## Descripción

El ejercicio parte de un archivo plano utilizado para administrar historias clínicas.

La estructura original mezcla pacientes, médicos, especialidades, tratamientos, costos y fechas de consulta.

La solución transforma esta información hasta tercera forma normal (3FN), separando las entidades principales y sus relaciones.

## Modelo original sin normalizar

La estructura de partida contiene:

```text
paciente
dpi
medico
especialidad
tratamientos
costos
fecha_consulta
```

Los campos `tratamientos` y `costos` pueden contener múltiples valores dentro de una misma fila.

Esto genera repetición de datos y dificulta la gestión de consultas con múltiples tratamientos.

## Modelo implementado

El modelo final está compuesto por:

```text
PACIENTES
ESPECIALIDADES
MEDICOS
TRATAMIENTOS
CONSULTAS
DETALLE_TRATAMIENTO
```

Las consultas relacionan pacientes y médicos.

Los médicos pertenecen a especialidades.

Los tratamientos aplicados se relacionan con las consultas mediante `detalle_tratamiento`.


## Consultas

El archivo `dql/consultas.sql` contiene consultas para:

1. Reconstruir una vista similar al archivo original utilizando `JOIN`.
2. Listar pacientes, médicos y especialidades sin duplicados.
3. Contar médicos por especialidad.
4. Calcular el costo total de tratamientos por consulta.
5. Obtener costo promedio, mínimo y máximo.
6. Buscar pacientes mediante `LIKE`.
7. Filtrar consultas por fecha y tratamientos por rango de costo.
8. Obtener los cinco tratamientos con mayor monto.
9. Detectar consultas sin tratamientos asociados.
10. Generar un reporte final con alias legibles.