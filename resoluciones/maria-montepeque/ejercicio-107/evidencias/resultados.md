# Evidencias - Ejercicio 107

## Tema

Indices

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-107.db < ddl/schema.sql
sqlite3 ejercicio-107.db < dml/inserts.sql
sqlite3 ejercicio-107.db < dql/consultas.sql
```

## Resultados

**4. Total de citas por fecha:**

```text
fecha_cita     total_citas
2026-09-01        3
2026-09-02        2
2026-09-03        3
```

**5. Plan de ejecucion de la consulta filtrada por fecha (EXPLAIN QUERY PLAN):**

```text
id   parent   notused   detail
3      0         62       SEARCH citas USING INDEX idx_citas_fecha (fecha_cita=?)
```

Verificacion manual: el plan dice `SEARCH ... USING INDEX
idx_citas_fecha`, no `SCAN citas`. Eso confirma que SQLite uso el
indice para ir directo a las filas de `fecha_cita = '2026-09-01'` en
vez de revisar las 8 filas de la tabla una por una.

**Caso comentado verificado (CHECK):**

- `INSERT INTO citas (..., estado) VALUES ('Cliente Fantasma', 'Dra. Sofia Martinez', '2026-09-04', '09:00', 'pendiente');` → `CHECK constraint failed: estado IN ('programada', 'cancelada', 'atendida')`.

**Caso comentado verificado (CREATE UNIQUE INDEX sobre columna con duplicados):**

```text
CREATE UNIQUE INDEX idx_pacientes_unicos ON citas (nombre_paciente);
```

→ `UNIQUE constraint failed: citas.nombre_paciente`. "Ana Lopez" ya
aparecia 2 veces en `citas` antes de intentar crear el indice.

## Aprendizaje

Un indice es una estructura adicional que SQLite mantiene ordenada
por la columna indexada, para poder localizar filas sin revisarlas
todas: `EXPLAIN QUERY PLAN` es la forma directa de comprobar si una
consulta realmente lo esta usando (`SEARCH ... USING INDEX`) o si
sigue revisando la tabla completa (`SCAN`). Ademas, `CREATE UNIQUE
INDEX` no es solo una promesa a futuro: SQLite valida los datos que
YA existen en la tabla en el momento de crear el indice, y si
encuentra un valor repetido en la columna que deberia ser unica, la
creacion del indice falla de inmediato. Por eso, antes de declarar un
indice como `UNIQUE`, hay que estar seguro de que esa columna
realmente identifica una sola fila por valor (por ejemplo, un
telefono o un correo), y no una columna como `nombre_paciente`, donde
es normal y esperable que se repita.
