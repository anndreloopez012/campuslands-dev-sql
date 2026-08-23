# Ejercicio 53: NOT NULL Nivel Basico

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Tema central

NOT NULL

## Descripcion del problema

Sistema de agenda de citas de una clinica: `pacientes`, `medicos` y `citas` (tabla principal). El ejercicio se enfoca en distinguir, dentro del mismo modelo, que campos son obligatorios (`NOT NULL`) y cuales son realmente opcionales (sin esa restriccion).

## Que aprendi sobre NOT NULL

- **NOT NULL marca lo que la base de datos exige siempre**: en `citas`, `id_paciente`, `id_medico` y `fecha_hora` son `NOT NULL` porque sin cualquiera de los tres la cita no tiene sentido (no se sabe quien, con quien o cuando). En cambio, `notas` se deja sin `NOT NULL` a proposito: es informacion que normalmente no existe hasta que el medico atiende al paciente.
- **Distinguir "obligatorio" de "opcional" es una decision de modelado, no solo de sintaxis**: en `pacientes`, `nombre` y `telefono` son `NOT NULL` (la clinica siempre los pide), pero `correo` no lleva `NOT NULL` porque no todos los pacientes lo dan. De los 6 pacientes de prueba, 4 tienen correo y 2 no, y la base los acepta a ambos sin problema.
- **Confirme la obligatoriedad con datos, no solo con el caso que falla**: la consulta 5.a compara `COUNT(*)` de citas contra `COUNT(fecha_hora)` (7 y 7, coinciden) — si `NOT NULL` no estuviera aplicado, podria haber citas sin fecha y esos numeros diferirian. La consulta 5.b hace el contraste opuesto con `correo` (campo opcional), donde SI es normal que los numeros no coincidan (6 pacientes, solo 4 con correo).
- Los dos casos comentados muestran `NOT NULL` en columnas de tablas distintas: `pacientes.nombre` y `citas.fecha_hora`. Ambos fallan con `NOT NULL constraint failed` sobre la columna correspondiente.

## Como ejecutar

```bash
sqlite3 ejercicio-53.db < ddl/schema.sql
sqlite3 ejercicio-53.db < dml/inserts.sql
sqlite3 ejercicio-53.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
