# Evidencias - Ejercicio 064

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-064.db < ddl/schema.sql
sqlite3 ejercicio-064.db < dml/inserts.sql
sqlite3 ejercicio-064.db < dml/operaciones.sql
sqlite3 ejercicio-064.db < dql/consultas.sql
```

## Resultados importantes

Conteo de datos base (despues de `inserts.sql`):

```text
clientes -> 5
vehiculos -> 6
diagnosticos -> 8
reparaciones -> 6
repuestos -> 7
```

Caso que debe fallar - segunda reparacion para el mismo diagnostico (`UNIQUE`):

```text
Fallo como se esperaba: UNIQUE constraint failed: reparaciones.id_diagnostico
```

Despues de `operaciones.sql`:

```text
diagnostico 3 estado: ('finalizado',)     -- ya no 'en_reparacion'
reparacion diag3 costo: (180.0,)          -- corregido de 150.00 a 180.00
diagnostico 8: None                        -- eliminado correctamente
```

Caso que debe fallar - eliminar vehiculo con diagnosticos asociados (`FOREIGN KEY`):

```text
Fallo como se esperaba: FOREIGN KEY constraint failed
```

Consulta 3 (ranking de vehiculos por numero de diagnosticos):

```text
placa      vehiculo          total_diagnosticos
P123ABC     Toyota Corolla    2
P987PQR     Toyota Hilux      1
P654MNO     Chevrolet Spark   1
P321JKL     Nissan Sentra     1
P789GHI     Mazda 3           1
P456DEF     Honda Civic       1
```

Consulta 5 (facturacion semanal por cliente, HAVING > Q400):

```text
cliente                 total_mano_obra   total_repuestos   total_facturado
Manuel Estrada           620.0             435.0             1055.0
Cristina Barrios         420.0             240.0             660.0
Alejandra Chinchilla     280.0             180.0             460.0
```

## Explicacion final

El modelo separa catalogos (`clientes`, `vehiculos`) de tres etapas del
proceso del taller: diagnostico, reparacion y repuestos usados. Esto
permite corregir el estado de un diagnostico y el costo de una
reparacion de forma independiente, eliminar un registro cancelado sin
afectar el historial de otros vehiculos, y generar con `JOIN`,
subconsultas y `GROUP BY`/`HAVING` justo el reporte semanal que el
cliente pidio: cuanto debe cobrar a cada cliente sumando mano de obra y
repuestos.
