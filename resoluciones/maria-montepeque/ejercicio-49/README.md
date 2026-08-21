# Ejercicio 49: FOREIGN KEY Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Tema central

FOREIGN KEY

## Descripcion del problema

Sistema de agenda de citas de una clinica: `pacientes`, `medicos` y `citas`. Nivel aplicado: cierra la serie de FOREIGN KEY (47 basico con RESTRICT implicito, 48 intermedio contrastando RESTRICT vs CASCADE) agregando la tercera accion `ON DELETE` que faltaba — `SET NULL` — y un reporte final de negocio.

## Tablas y relaciones

- `pacientes`: catalogo de pacientes.
- `medicos`: catalogo de medicos.
- `citas`: cada cita. `citas.id_paciente -> pacientes.id_paciente` con `ON DELETE RESTRICT`; `citas.id_medico -> medicos.id_medico` con `ON DELETE SET NULL` (nullable).

## Que aprendi sobre FOREIGN KEY

- **Las tres acciones `ON DELETE` de la serie, juntas por primera vez**: `RESTRICT` (protege, ejercicios 47 y 48), `CASCADE` (borra en cadena, ejercicio 48) y ahora `SET NULL` (desvincula sin borrar ni bloquear). Elegir cual usar depende de que tan importante es conservar la fila dependiente: el historial de citas de un paciente **si** importa conservarlo completo (`RESTRICT`), pero la identidad del medico especifico en una cita ya realizada **no** es indispensable si ese medico deja la clinica (`SET NULL`).
- **`ON DELETE SET NULL` en accion**: al eliminar al "Dr. Felipe Ramos" (`id_medico = 4`), sus 3 citas no desaparecieron ni bloquearon el borrado: la cantidad total de citas se mantuvo en 10, pero esas 3 quedaron con `id_medico = NULL` ("Medico no disponible" en el reporte final). Esto solo es posible porque `citas.id_medico` es `NULLABLE`; si tuviera `NOT NULL`, `SET NULL` fallaria al intentar dejar un `NULL` en una columna que no lo permite.
- **`ON DELETE RESTRICT` sigue protegiendo el historial clinico**: intentar borrar a "Jorge Alvarado" (`id_paciente = 1`), que tiene citas registradas, falla con `FOREIGN KEY constraint failed`.
- El reporte final usa `LEFT JOIN` + `COALESCE` para mostrar las citas sin medico asignado como una categoria propia del reporte ("Medico no disponible"), en vez de que el `JOIN` las descarte silenciosamente.

## Como ejecutar

```bash
sqlite3 ejercicio-49.db < ddl/schema.sql
sqlite3 ejercicio-49.db < dml/inserts.sql
sqlite3 ejercicio-49.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
