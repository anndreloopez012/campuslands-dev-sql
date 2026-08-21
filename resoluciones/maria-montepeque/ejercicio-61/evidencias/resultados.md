# Evidencias - Ejercicio 61

## Tema

DEFAULT

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-61.db < ddl/schema.sql
sqlite3 ejercicio-61.db < dml/inserts.sql
sqlite3 ejercicio-61.db < dql/consultas.sql
```

## Resultados

Conteo de datos base:

```text
clientes -> 5
productos -> 5
ventas -> 8
```

Caso que debe fallar (comentado en `dml/inserts.sql`):

```text
INSERT INTO ventas (id_cliente, id_producto, cantidad) VALUES (1, 1, 0);
Fallo como se esperaba: CHECK constraint failed: cantidad > 0
```

Consulta 5 (validacion especifica de DEFAULT):

```text
5a. clientes con tipo_cliente = 'regular' (DEFAULT, no indicado en el INSERT)
(1, 'Manuel Estrada', 'regular')
(2, 'Alejandra Chinchilla', 'regular')
(5, 'Douglas Pineda', 'regular')   -- indicado explicitamente, coincide con el DEFAULT

5b. productos con categoria = 'bebida' y disponible = 1 (DEFAULT)
(1, 'Cafe Americano', 'bebida', 1)
(2, 'Capuchino', 'bebida', 1)

5c. ventas con cantidad = 1 y estado = 'pendiente' (DEFAULT en ambos)
(1, 1, 'pendiente')
(2, 1, 'pendiente')
```

Consulta 6 (decision de negocio: ingresos por producto, solo ventas
`'pagada'`):

```text
producto              unidades_vendidas  ingresos_totales
Pastel de Chocolate    1                 22.0
Capuchino               1                18.5
Cafe Americano          1                15.0
```

## Aprendizaje

`DEFAULT` permite completar automaticamente columnas repetitivas
(tipo de cliente, categoria de producto, disponibilidad, cantidad, fecha y
estado de la venta) cuando el `INSERT` no las especifica, sin perder las
demas validaciones: si el valor final (por defecto o explicito) viola un
`CHECK`, la insercion sigue fallando igual. Es util para reducir la carga
de captura de datos sin sacrificar integridad.
