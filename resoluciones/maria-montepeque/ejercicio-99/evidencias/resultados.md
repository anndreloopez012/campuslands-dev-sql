# Evidencias - Ejercicio 99

## Tema

Vistas

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-99.db < ddl/schema.sql
sqlite3 ejercicio-99.db < dml/inserts.sql
sqlite3 ejercicio-99.db < dql/consultas.sql
```

## Resultados

**4. Total de ventas y facturado por cliente (usando la vista):**

```text
nombre_cliente        total_ventas   total_facturado
Lucia Fernandez            2               52.0
Mario Castillo              2               55.0
Pedro Ramirez               2               69.0
Sofia Martinez               2               50.0
```

**5. Reporte de ingresos por producto (misma vista, otro reporte):**

```text
nombre_producto     total_facturado
Cafe Americano            90.0
Cafe Latte                 60.0
Te Verde                   40.0
Croissant                  36.0
```

Verificacion manual: Cafe Americano vendio 2+3+1=6 unidades a 15.00 =
90.0; Cafe Latte vendio 1+2=3 unidades a 20.00 = 60.0; Te Verde vendio
4 unidades a 10.00 = 40.0; Croissant vendio 2+1=3 unidades a 12.00 =
36.0. Ninguna de estas dos consultas (4 y 5) repite el `JOIN` de
`ventas`, `clientes` y `productos`; ambas parten de
`vista_detalle_ventas`.

**Caso comentado verificado (CHECK):**

- `INSERT INTO ventas (..., cantidad, ...) VALUES (1, 1, 0, '2026-08-08');` → `CHECK constraint failed: cantidad > 0`.

**Caso comentado verificado (vista con columna inexistente):**

```text
CREATE VIEW vista_ventas_mal AS SELECT id_venta, total_calculado FROM ventas;
```

→ se ejecuta sin ningun error.

```text
SELECT * FROM vista_ventas_mal;
```

→ `no such column: total_calculado`.

## Aprendizaje

Una vista de 3 tablas centraliza el `JOIN` en un solo lugar, y a
partir de ahi se pueden construir varios reportes distintos
(consultas 4 y 5) simplemente agregando `WHERE`, `ORDER BY` o
`GROUP BY` sobre ella, como si fuera una tabla normal: ese es el valor
practico de las vistas en un modelo con relaciones. Al mismo tiempo,
SQLite no valida el contenido de una vista en el momento de crearla
(`CREATE VIEW` con evaluacion perezosa): una vista con una columna que
no existe se crea sin errores, y el problema solo aparece cuando
alguien intenta usarla. Por eso conviene probar siempre una vista
nueva con un `SELECT` inmediatamente despues de definirla, en vez de
confiar en que un `CREATE VIEW` sin errores garantiza que esta
correctamente definida.
