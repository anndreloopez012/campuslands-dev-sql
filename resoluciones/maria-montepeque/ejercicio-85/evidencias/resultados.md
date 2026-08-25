# Evidencias - Ejercicio 85

## Tema

WHERE

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-85.db < ddl/schema.sql
sqlite3 ejercicio-85.db < dml/inserts.sql
sqlite3 ejercicio-85.db < dql/consultas.sql
```

## Resultados

**2. Agenda pendiente del 2026-08-20 (caso de negocio: lo que
recepcion necesita ver esa manana), ordenada por hora:**

```text
id_cita | nombre_paciente   | nombre_medico       | hora_cita
3         | Byron Xicay         | Dra. Marta Lopez      | 11:00
4         | Cristina Barrios    | Dra. Sofia Ramirez    | 14:00
```

**Caso comentado verificado:**

- `SELECT nombre_paciente FROM pacientes p WHERE x.nombre_paciente = 'Manuel Estrada';` → `no such column: x.nombre_paciente` (el alias `x` nunca se declaro en el `FROM`; la tabla se declaro como `p`).

**5. Reporte final del caso de negocio (nivel aplicado): pacientes con
2 o mas citas canceladas, para contactarlos antes de agendarles algo
nuevo:**

```text
nombre_paciente   telefono
Diego Paz           5555-4405
```

Diego Paz tiene exactamente 2 citas canceladas (2026-08-18 y
2026-08-19); es el unico paciente que cumple el umbral.

## Aprendizaje

Este ejercicio combino todo lo visto en los niveles basico e
intermedio de `WHERE` en un solo caso de negocio real: filtrar por una
fecha exacta, por estado, ordenar el resultado, y usar una subconsulta
que a su vez tiene su propio `GROUP BY` y `HAVING` para detectar un
patron (pacientes que cancelan seguido). El `WHERE ... IN (subconsulta)`
permite responder una pregunta de dos pasos ("que pacientes cumplen
esta condicion agregada") sin tener que calcularla a mano fuera de
SQL. El caso comentado recuerda que un alias de tabla que no se
declaro en el `FROM` no existe para el resto de la consulta, aunque el
nombre se parezca al de la tabla real.
