# Evidencias - Ejercicio 063

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-063.db < ddl/schema.sql
sqlite3 ejercicio-063.db < dml/inserts.sql
sqlite3 ejercicio-063.db < dml/operaciones.sql
sqlite3 ejercicio-063.db < dql/consultas.sql
```

## Resultados importantes

Conteo de datos base (despues de `inserts.sql`):

```text
clientes -> 5
artistas -> 3
estilos -> 4
sesiones -> 10
pagos -> 6
```

Caso que debe fallar - segundo pago para la misma sesion (`UNIQUE`):

```text
Fallo como se esperaba: UNIQUE constraint failed: pagos.id_sesion
```

Despues de `operaciones.sql`:

```text
sesiones -> 9                        (se elimino la sesion 7, cancelada sin pago)
sesion 5 estado: ('completada',)      -- ya no 'agendada'
pago sesion 8: ('pagado',)            -- confirmado, ya no pendiente
sesion 7: None                        -- eliminada correctamente
```

Caso que debe fallar - eliminar artista con sesiones asociadas (`FOREIGN KEY`):

```text
Fallo como se esperaba: FOREIGN KEY constraint failed
```

Consulta 3 (ranking de artistas por sesiones completadas):

```text
artista               sesiones_completadas
Fernanda Castillo      3
Kevin Morales          2
Sergio Lopez           2
```

Consulta 5 (facturacion por estilo, solo pagos 'pagado', HAVING > Q300):

```text
estilo                 sesiones_pagadas   total_facturado
Realismo                2                 500.0
Tradicional Japones     1                 480.0
Acuarela                1                 380.0
Blackwork               2                 320.0
```

## Explicacion final

El modelo separa catalogos (`clientes`, `artistas`, `estilos`) de la
tabla transaccional (`sesiones`) y del movimiento de dinero (`pagos`).
Los campos `id_cliente`, `id_artista` e `id_estilo` de `sesiones` son
`NOT NULL` a proposito: eso evita el problema que el cliente describio
(registros incompletos que despues no permiten reportes confiables).
Con `JOIN`, `GROUP BY` y `HAVING` se responde exactamente lo que el
estudio necesita: que artista tiene mas actividad y que estilo genera
mas ingresos.
