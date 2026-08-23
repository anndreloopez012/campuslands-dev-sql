# Evidencias - Ejercicio 56

## Tema

CHECK

## Comandos ejecutados

```bash
sqlite3 ejercicio-56.db < ddl/schema.sql
sqlite3 ejercicio-56.db < dml/inserts.sql
sqlite3 ejercicio-56.db < dql/consultas.sql
```

## Resultados

**4. Resumen: partidas por estado:**

```text
estado      | total
cancelada   | 1
jugada      | 2
programada  | 1
```

**5.a Rango numerico: ningun puntaje registrado es negativo:**

```text
puntaje_local_minimo | puntaje_visitante_minimo
0                      | 1
```

**5.b CHECK a nivel de tabla: ninguna partida tiene el mismo equipo como local y visitante:**

```text
partidas_equipo_contra_si_mismo
0
```

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- `INSERT INTO equipos (nombre_equipo, region) VALUES ('Titanes FC', 'Antartida');` → `CHECK constraint failed: region IN ('Norteamerica', 'Sudamerica', 'Europa', 'Asia')`.
- `INSERT INTO jugadores (id_equipo, nombre, edad) VALUES (1, 'Nino Prodigio', 10);` → `CHECK constraint failed: edad BETWEEN 14 AND 45`.
- `INSERT INTO partidas (..., puntaje_local, puntaje_visitante) VALUES (..., -1, 2);` → `CHECK constraint failed: puntaje_local >= 0`.
- `INSERT INTO partidas (id_equipo_local, id_equipo_visitante, ...) VALUES (1, 1, ...);` → `CHECK constraint failed: id_equipo_local <> id_equipo_visitante`.

## Aprendizaje

`CHECK` cubre tres tipos de regla de dominio distintos y los tres aparecen en este modelo: valores permitidos (`equipos.region` solo acepta una lista cerrada de regiones), rango numerico (`jugadores.edad` entre 14 y 45, `partidas.puntaje_local`/`puntaje_visitante` no negativos) y una regla de negocio entre columnas de la misma fila (`partidas`: un equipo no puede jugar contra si mismo, `id_equipo_local <> id_equipo_visitante`). Este ultimo caso muestra que `CHECK` no se limita a una sola columna: se puede escribir a nivel de tabla y comparar varias columnas entre si. La consulta 5.a confirma el rango numerico con datos reales (el minimo de puntajes registrados es 0, nunca negativo) y la 5.b confirma que la regla entre columnas nunca se violo (0 partidas con el mismo equipo local y visitante).
