# Evidencias - Ejercicio 44

## Tema

PRIMARY KEY

## Comandos ejecutados

```bash
sqlite3 ejercicio-44.db < ddl/schema.sql
sqlite3 ejercicio-44.db < dml/inserts.sql
sqlite3 ejercicio-44.db < dql/consultas.sql
```

## Resultados

**5.a Inscripciones de Manuel Estrada** (misma `id_camper`, distinta `id_ruta`: dos filas validas porque la PRIMARY KEY compuesta es distinta en cada una):

```text
id_camper | id_ruta | fecha_inscripcion
1         | 1       | 2026-01-15
1         | 2       | 2026-02-01
```

**5.b Rutas inscritas por camper:**

```text
camper                | rutas_inscritas
Manuel Estrada         | 2
Byron Xicay             | 2
Alejandra Chinchilla    | 2
Douglas Pineda          | 1
Cristina Barrios        | 1
```

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- `INSERT INTO inscripciones (...) VALUES (3, 1, '2026-04-01');` (Byron Xicay ya estaba inscrito en la ruta 1) → `UNIQUE constraint failed: inscripciones.id_camper, inscripciones.id_ruta`.
- `INSERT INTO campers (id_camper, ...) VALUES (1, ...);` (id_camper 1 ya existe) → `UNIQUE constraint failed: campers.id_camper`.

## Aprendizaje

La `PRIMARY KEY` no es solo "un numero que identifica la fila": es la restriccion que la base de datos usa para decidir automaticamente si una fila es un duplicado o no. Con una llave simple (`campers.id_camper`), el duplicado que evita es tecnico (dos filas con el mismo id). Con una llave compuesta (`inscripciones (id_camper, id_ruta)`), el duplicado que evita es de negocio: la misma inscripcion repetida. Elegir entre llave simple o compuesta, y entre llave subrogada o natural, es parte del diseno de la `PRIMARY KEY`, no un detalle menor.
