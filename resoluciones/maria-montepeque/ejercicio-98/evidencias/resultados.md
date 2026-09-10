# Evidencias - Ejercicio 98

## Tema

Vistas

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-98.db < ddl/schema.sql
sqlite3 ejercicio-98.db < dml/inserts.sql
sqlite3 ejercicio-98.db < dql/consultas.sql
```

## Resultados

**2. Inscripciones activas, consulta manual (sin la vista):**

```text
id_inscripcion   id_camper   nombre_ruta    fecha_inscripcion
1                  1           Ruta Backend    2026-08-01
2                  2           Ruta Frontend   2026-08-02
4                  4           Ruta DevOps     2026-08-04
6                  1           Ruta DevOps     2026-08-06
```

**5. Inscripciones activas usando `vista_inscripciones_activas`:**

```text
id_inscripcion   nombre_camper   nombre_ruta    fecha_inscripcion
1                  Ana Lopez        Ruta Backend    2026-08-01
2                  Byron Ramirez    Ruta Frontend   2026-08-02
4                  Diego Torres     Ruta DevOps     2026-08-04
6                  Ana Lopez        Ruta DevOps     2026-08-06
```

Verificacion manual: mismos 4 `id_inscripcion` (1, 2, 4 y 6) en ambos
resultados; la vista solo agrega el nombre del camper sin tener que
repetir el `JOIN` en la consulta.

**Caso comentado verificado (CHECK):**

- `INSERT INTO inscripciones (..., estado) VALUES (1, 'Ruta Backend', '2026-08-08', 'suspendido');` → `CHECK constraint failed: estado IN ('activo', 'retirado', 'completado')`.

**Caso comentado verificado (INSERT directo en una vista):**

```text
INSERT INTO vista_inscripciones_activas (id_inscripcion, nombre_camper, nombre_ruta, fecha_inscripcion)
VALUES (99, 'Camper Fantasma', 'Ruta Inventada', '2026-08-09');
```

→ `cannot modify vista_inscripciones_activas because it is a view`.

## Aprendizaje

Una vista (`CREATE VIEW ... AS SELECT ...`) guarda una consulta con un
nombre, para poder reutilizarla como si fuera una tabla sin repetir su
logica (aqui, el `JOIN` entre `inscripciones` y `campers` filtrado por
`estado = 'activo'`). Cada vez que se consulta la vista, SQLite
vuelve a ejecutar la definicion original contra los datos actuales de
las tablas base, por lo que la vista nunca queda desactualizada. Pero
una vista no es una copia de datos ni una tabla nueva: en SQLite es de
solo lectura por definicion, y cualquier intento de `INSERT`,
`UPDATE` o `DELETE` sobre ella falla, a menos que se defina
explicitamente un trigger `INSTEAD OF` que le indique a SQLite como
traducir esa escritura hacia las tablas base.
