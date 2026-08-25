# Ejercicio 39: Normalizacion Recursos Humanos

## Información

| Campo | Valor |
|---|---|
| Ejercicio | 39 |
| Tema | Normalización |
| Nivel | Intermedio |
| Estudiante | Jose Luis Herrera |

## Descripción

El ejercicio parte de una estructura plana utilizada para administrar información de empleados, cargos, departamentos, jefes, beneficios, salarios y fechas de contratación.

La estructura original presenta duplicidad de datos, valores múltiples en una misma celda y dependencias que dificultan las operaciones de inserción, actualización y eliminación.

El objetivo es transformar la estructura original hasta alcanzar un modelo relacional en Tercera Forma Normal.

## Modelo implementado

El modelo final está compuesto por las siguientes tablas:

```text
departamentos
cargos
empleados
contratos
beneficios
asignaciones_beneficios
```

## Relaciones

```text
departamentos 1 ──── N empleados
cargos        1 ──── N empleados
empleados     1 ──── N contratos
empleados     1 ──── N empleados
empleados     N ──── N beneficios
```

La relación muchos a muchos entre empleados y beneficios se implementa mediante `asignaciones_beneficios`.

La relación jerárquica entre empleados se implementa mediante la clave foránea `id_jefe`.


## Consultas

El archivo `dql/consultas.sql` contiene consultas para:

1. Reconstruir una vista similar a la tabla original.
2. Listar entidades principales sin duplicados.
3. Contar empleados por departamento y cargo.
4. Calcular costos mensuales por empleado.
5. Obtener promedio, mínimo y máximo salarial.
6. Buscar empleados mediante `LIKE`.
7. Filtrar contratos por fecha.
8. Filtrar salarios por rango.
9. Obtener los cinco salarios más altos.
10. Detectar empleados sin beneficios.
11. Generar un reporte final con alias legibles.


## Resultado

El modelo separa las entidades principales y elimina los grupos repetidos y las dependencias transitivas presentes en la estructura original.

La información de empleados, cargos, departamentos, contratos y beneficios puede administrarse de forma independiente manteniendo la integridad referencial.