# Evidencias - Ejercicio 066

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-066.db < ddl/schema.sql
sqlite3 ejercicio-066.db < dml/inserts.sql
sqlite3 ejercicio-066.db < dml/operaciones.sql
sqlite3 ejercicio-066.db < dql/consultas.sql
```

## Resultados importantes

Conteo de datos base (despues de `inserts.sql`):

```text
huespedes -> 5
habitaciones -> 5
eventos -> 3
reservas -> 7
consumos -> 10
```

Caso que debe fallar - consumo con evento inexistente (`FOREIGN KEY`):

```text
Fallo como se esperaba: FOREIGN KEY constraint failed
```

Despues de `operaciones.sql`:

```text
reservas -> 6                          (se elimino la reserva 5, cancelada sin consumos)
reserva 3 estado: ('finalizada',)       -- ya no 'activa'
minibar corregido: (55.0,)              -- corregido de 45.00 a 55.00
reserva 5: None                          -- eliminada correctamente
```

Caso que debe fallar - eliminar habitacion con reservas asociadas (`FOREIGN KEY`):

```text
Fallo como se esperaba: FOREIGN KEY constraint failed
```

Consulta 3 (ranking de huespedes por numero de consumos):

```text
huesped                 total_consumos
Manuel Estrada           4
Alejandra Chinchilla     3
Cristina Barrios         2
Byron Xicay              1
```

Consulta 5 (facturacion por huesped, HAVING > Q1000):

```text
huesped                 total_habitacion   total_consumos   total_facturado
Manuel Estrada           2550.0             175.0            2725.0
Alejandra Chinchilla     2300.0             165.0            2465.0
Cristina Barrios         1050.0             150.0            1200.0
```

## Explicacion final

El modelo separa catalogos permanentes (`huespedes`, `habitaciones`,
`eventos`) de la operacion (`reservas`) y sus movimientos (`consumos`),
tal como pidio el cliente. Esto permite corregir el estado de una
reserva y el monto de un consumo sin tocar los catalogos, eliminar una
reserva cancelada sin afectar el historial de otros huespedes, y
generar con `JOIN`, una subconsulta y `GROUP BY`/`HAVING` el reporte
exacto que el hotel necesita: cuanto debe cobrar a cada huesped sumando
noches de habitacion y consumos, sin duplicar el costo de habitacion
cuando hay varios consumos por reserva.
