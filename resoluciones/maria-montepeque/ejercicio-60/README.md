# Ejercicio 60: DEFAULT Nivel Intermedio

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Tema central

DEFAULT

## Descripcion del problema

Sistema de registro de campers inscritos en rutas de entrenamiento: `campers`, `rutas` e `inscripciones` (tabla principal). A diferencia del ejercicio basico, aqui `DEFAULT` se reparte entre las tres tablas: cada una define el valor por defecto que tiene sentido para su propio dato, sin depender de las otras.

## Que aprendi sobre DEFAULT

- **DEFAULT es una propiedad de la columna, no del modelo completo**: `campers.nivel`/`activo`, `rutas.cupo_maximo` e `inscripciones.estado`/`fecha_inscripcion` tienen cada uno su propio valor por defecto, definido de forma independiente. Insertar un camper sin nivel no afecta en nada el cupo por defecto de una ruta ni el estado por defecto de una inscripcion; son reglas separadas aunque las tablas esten relacionadas por llave foranea.
- **Reconfirme que DEFAULT solo actua cuando la columna se omite**: los tres campers insertados sin `nivel` ni `activo` quedaron en `'principiante'` y `1`; las dos rutas sin `cupo_maximo` quedaron en `10`; las tres inscripciones sin `estado` ni `fecha_inscripcion` quedaron en `'activa'` y la fecha/hora real del `INSERT`. El caso comentado (nivel `'avansado'`, con typo) muestra que escribir el valor a mano se salta el `DEFAULT` y queda sujeto al `CHECK`, que lo rechaza.
- **DEFAULT no reemplaza las reglas de dominio, las complementa**: cada columna con `DEFAULT` en este modelo tambien tiene un `CHECK` (nivel, activo, cupo_maximo, estado). `DEFAULT` resuelve el caso comun (no escribir nada), `CHECK` protege el caso en que si se escribe algo, sea correcto.
- La consulta 5 separa deliberadamente el caso de `campers` (5.a) del caso de `rutas` (5.b) para mostrar que la misma tecnica de DEFAULT se repite en tablas distintas del mismo modelo, cada una con su propio valor tipico.

## Como ejecutar

```bash
sqlite3 ejercicio-60.db < ddl/schema.sql
sqlite3 ejercicio-60.db < dml/inserts.sql
sqlite3 ejercicio-60.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
