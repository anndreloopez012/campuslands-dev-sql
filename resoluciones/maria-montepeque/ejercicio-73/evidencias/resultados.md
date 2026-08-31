# Evidencias - Ejercicio 73

## Tema

INSERT

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-73.db < ddl/schema.sql
sqlite3 ejercicio-73.db < dml/inserts.sql
sqlite3 ejercicio-73.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 3 categorias, 5 productos y 11
movimientos (6 entradas, 5 salidas).

**Casos comentados verificados** (descomentados y ejecutados por
separado para confirmar que cada uno falla):

- `INSERT INTO productos (nombre_producto, ...) VALUES ('Laptop Pro 14', ...);` → `UNIQUE constraint failed: productos.nombre_producto`.
- `INSERT INTO movimientos (id_producto, ...) VALUES (99, ...);` → `FOREIGN KEY constraint failed`.
- `INSERT INTO movimientos (..., cantidad) VALUES (..., -10);` → `CHECK constraint failed: cantidad > 0`.

**4. Resumen: movimientos por tipo:**

```text
tipo_movimiento  total
entrada           6
salida            5
```

**5. Caso de negocio con reporte final: stock real de cada producto,
calculado sumando entradas y restando salidas (sin ninguna columna de
stock guardada):**

```text
nombre_producto        stock_actual
Disco SSD 1TB            16
Laptop Air 13            6
Laptop Pro 14            12
Mouse Inalambrico        38
Teclado Mecanico         23
```

Verificacion manual de Laptop Pro 14: entrada 10, salida 3, entrada 5
(sin indicar `tipo_movimiento`, quedo en `'entrada'` por `DEFAULT`) =
10 - 3 + 5 = 12. Coincide exactamente con el reporte.

## Aprendizaje

Ademas de `INSERT` de una fila, `INSERT` multiple y `INSERT` omitiendo
una columna con `DEFAULT` (vistos en los niveles basico e
intermedio), este ejercicio de nivel aplicado demostro un caso de
negocio completo: el stock de cada producto nunca se guarda como un
numero fijo que hay que mantener sincronizado a mano, se reconstruye
siempre desde el historial de `movimientos` con una consulta de
reporte. Esto significa que cada `INSERT` en `movimientos` es, en si
mismo, la unica fuente de verdad del inventario: si los `INSERT` estan
completos y correctos (protegidos por `CHECK` y `FOREIGN KEY`), el
reporte final siempre sera correcto sin necesidad de ningun `UPDATE`.
