# Evidencias - Ejercicio 60

## Tema

DEFAULT

## Comandos ejecutados

```bash
sqlite3 ejercicio-60.db < ddl/schema.sql
sqlite3 ejercicio-60.db < dml/inserts.sql
sqlite3 ejercicio-60.db < dql/consultas.sql
```

## Resultados

**4. Resumen: inscripciones por estado:**

```text
estado      | total
activa       | 3
cancelada    | 1
completada   | 1
```

**5.a Campers insertados SIN indicar nivel ni activo, completados por DEFAULT:**

```text
nombre           | nivel         | activo
Ana Gomez         | principiante  | 1
Luis Marroquin    | principiante  | 1
Rosa Chavez       | principiante  | 1
```

**5.b Rutas insertadas SIN indicar cupo_maximo, completadas con el DEFAULT de 10:**

```text
nombre_ruta        | cupo_maximo
Sendero del Canon   | 10
Ruta del Volcan     | 10
```

Las tres inscripciones (id 3, 4 y 5) que se insertaron sin `estado` ni `fecha_inscripcion` tambien quedaron correctas: `estado = 'activa'` y `fecha_inscripcion` con la fecha/hora real del momento del `INSERT` (por ejemplo `2026-08-18 00:57:05`).

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO campers (..., nivel) VALUES (..., 'avansado');` → `CHECK constraint failed: nivel IN ('principiante', 'intermedio', 'avanzado')` (un typo al escribir el nivel a mano rompe la validacion; dejar que `DEFAULT` lo complete evita ese error).

## Aprendizaje

En un modelo con varias tablas relacionadas, `DEFAULT` se aplica de forma independiente en cada tabla, y cada una define el valor que tiene sentido para su propio negocio: `campers.nivel` arranca en `'principiante'` porque asi entra la mayoria de gente nueva, `campers.activo` arranca en `1` porque un registro nuevo se asume activo, `rutas.cupo_maximo` arranca en `10` como cupo estandar, e `inscripciones.estado` arranca en `'activa'` porque toda inscripcion empieza asi. Ninguno de estos valores esta relacionado con el de otra tabla: `DEFAULT` no depende de llaves foraneas ni de otras filas, solo de la columna donde se define. La consulta 5 confirma con datos reales que omitir una columna en el `INSERT` no deja huecos: los campers y rutas que no trajeron esos valores quedaron exactamente igual de completos que los que si los trajeron explicitos.
