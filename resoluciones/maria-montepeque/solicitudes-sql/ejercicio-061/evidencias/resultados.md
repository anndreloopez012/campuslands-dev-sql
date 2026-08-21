# Evidencias - Ejercicio 061

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-061.db < ddl/schema.sql
sqlite3 ejercicio-061.db < dml/inserts.sql
sqlite3 ejercicio-061.db < dml/operaciones.sql
sqlite3 ejercicio-061.db < dql/consultas.sql
```

## Resultados importantes

Conteo de datos base (despues de `inserts.sql`):

```text
clientes -> 5
menus -> 5
repartidores -> 4
pedidos -> 10
pagos -> 7
```

Caso que debe fallar - segundo pago para el mismo pedido (`UNIQUE`):

```text
Fallo como se esperaba: UNIQUE constraint failed: pagos.id_pedido
```

Despues de `operaciones.sql`:

```text
pedidos -> 9   (se elimino el pedido 9, cancelado sin pago)
pagos -> 7
pedido 7: (7, 2, 'en_camino')      -- repartidor asignado, ya no pendiente
pago pedido 4: (4, 'pagado')        -- confirmado tras la entrega
pedido 9: None                      -- eliminado correctamente
```

Caso que debe fallar - eliminar cliente con pedidos asociados (`FOREIGN KEY`):

```text
Fallo como se esperaba: FOREIGN KEY constraint failed
```

Consulta 3 (ranking de repartidores por pedidos entregados):

```text
repartidor           pedidos_entregados
Fernanda Castillo     2
Sergio Lopez          2
Ana Lucia Reyes       1
Kevin Morales         1
```

Consulta 5 (facturacion por restaurante, solo pagos 'pagado', HAVING > Q100):

```text
restaurante       pedidos_pagados   total_facturado
Sakura Sushi       2                240.0
Pizza Nostra       2                190.0
Tacos Don Beto     1                114.0
```

## Explicacion final

El modelo separa catalogos (`clientes`, `menus`, `repartidores`) de la
tabla transaccional (`pedidos`) y del movimiento de dinero (`pagos`), en
vez de guardar todo en una sola tabla de texto. Esto permite: corregir el
estado de un pedido sin duplicar datos del cliente o del platillo,
registrar pagos de forma independiente (con su propio estado), y generar
reportes reales que el cliente pidio -- por ejemplo, saber que repartidor
tiene mas actividad o que restaurante factura mas -- usando `JOIN`,
`GROUP BY` y `HAVING` en vez de revisar manualmente una hoja de calculo.
