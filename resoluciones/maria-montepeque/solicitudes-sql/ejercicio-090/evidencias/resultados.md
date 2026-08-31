# Evidencias - Solicitudes SQL - Ejercicio 090 (Laboratorio Quimico)

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-090.db < ddl/schema.sql
sqlite3 ejercicio-090.db < dml/inserts.sql
sqlite3 ejercicio-090.db < dml/operaciones.sql
sqlite3 ejercicio-090.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 3 tecnicos, 4 formulas, 5
reactivos, 6 muestras (2 `finalizada`, 1 `rechazada`, 2
`en_analisis`, 1 `recibida`), 3 resultados y 7 lineas de detalle
(incluye la cargada por error en la muestra 3, todavia
`en_analisis`).

**Caso comentado verificado:**

- `INSERT INTO resultados (id_muestra, ...) VALUES (1, ...);` (segundo resultado oficial para la muestra 1) → `UNIQUE constraint failed: resultados.id_muestra`.

**1. Historial completo via `vista_historial_muestra` (ya con la
muestra 5 y la nueva muestra 7 tras `dml/operaciones.sql`):**

```text
id_muestra | nombre_tecnico | nombre_formula            | estado       | veredicto
1          | Sofia Ramirez  | Solucion Buffer pH7       | finalizada   | aprobado
2          | Carlos Perez   | Acido Sulfurico Diluido   | finalizada   | aprobado
3          | Sofia Ramirez  | Cloruro de Sodio Estandar | en_analisis  | (sin resultado)
4          | Marta Lopez    | Etanol 96%                | rechazada    | rechazado
5          | Carlos Perez   | Solucion Buffer pH7       | en_analisis  | (sin resultado)
6          | Marta Lopez    | Acido Sulfurico Diluido   | en_analisis  | (sin resultado)
7          | Carlos Perez   | Cloruro de Sodio Estandar | recibida     | (sin resultado)
```

**5. Promedio de valor medido por formula:**

```text
nombre_formula             total_resultados   promedio_valor
Acido Sulfurico Diluido        1                  95.5
Etanol 96%                     1                  89.0
Solucion Buffer pH7            1                  7.02
```

**6. Formulas con muestras rechazadas (decision para el cliente):**

```text
nombre_formula   total_muestras   muestras_rechazadas
Etanol 96%            1                    1
```

Solo `Etanol 96%` aparece: es la unica formula con al menos una
muestra en estado `rechazada` (muestra 4, veredicto `rechazado` por
pureza fuera de rango), por lo que es la formula que el laboratorio
deberia revisar primero con su proveedor de reactivos.

## Operaciones de mantenimiento verificadas

- **INSERT adicional**: se registro la muestra 7 (Cloruro de Sodio
  Estandar, `recibida`). Total de muestras: 6 -> 7.
- **UPDATE de estado**: `UPDATE muestras SET estado = 'en_analisis' WHERE id_muestra = 5 ...;` → la muestra 5 (Buffer pH7 de Carlos) paso de `recibida` a `en_analisis`.
- **DELETE controlado**: se elimino el hidroxido de sodio cargado por error en la muestra 3, mientras esta seguia `en_analisis`. Total de lineas de detalle: 7 -> 6.
- **Caso NO recomendable verificado**: `DELETE FROM detalle_reactivos WHERE id_muestra = 1 AND id_reactivo = 1;` (muestra ya `finalizada`) se probo por separado y SQLite **no** lo bloquea, porque no existe una regla de negocio como esta expresada en el `CHECK` del esquema. Por eso la regla se documenta y se respeta por convencion en `dml/operaciones.sql`, tal como se aplico el `DELETE` real solo sobre la muestra 3 (todavia `en_analisis`).

## Aprendizaje

El modelo separa catalogos (`tecnicos`, `formulas`, `reactivos`) de
historico (`muestras`, `resultados`, `detalle_reactivos`), y usa
`UNIQUE (id_muestra)` en `resultados` para proteger el requisito
central del cliente: nunca puede haber dos resultados oficiales
contradictorios para la misma muestra. El reporte de formulas con
muestras rechazadas se construyo con `GROUP BY` y una expresion
`CASE` dentro de `SUM(...)` para contar condicionalmente solo las
muestras `rechazada` de cada formula, y `HAVING` para quedarse solo
con las formulas donde ese conteo es mayor a cero. Tambien se
confirmo que una regla de negocio como "no borrar reactivos de una
muestra ya finalizada" no la garantiza la base de datos por si sola
(SQLite permitio el `DELETE` de prueba): protegerla realmente
requeriria un `TRIGGER`, que queda fuera del alcance de este
ejercicio (`GROUP BY` / nivel 5 de solicitudes), por lo que aqui se
documenta como convencion de uso.
