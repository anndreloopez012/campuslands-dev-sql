# Evidencias - Solicitudes SQL - Ejercicio 077 (Taller de Motos)

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-077.db < ddl/schema.sql
sqlite3 ejercicio-077.db < dml/inserts.sql
sqlite3 ejercicio-077.db < dml/operaciones.sql
sqlite3 ejercicio-077.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 3 clientes, 3 motos, 5 repuestos,
4 ordenes (2 `finalizada`, 1 `en_reparacion`, 1 `recibida`) y 7 lineas
de detalle (incluye la Cadena Transmision agregada por error en la
orden 4).

**Caso comentado verificado:**

- `INSERT INTO detalle_repuestos (id_orden, id_repuesto, ...) VALUES (2, 3, ...);` (segunda linea de Pastillas Freno en la orden 2) → `UNIQUE constraint failed: detalle_repuestos.id_orden, detalle_repuestos.id_repuesto`.

**3. Moto con mas ordenes de servicio:**

```text
placa       modelo            total_ordenes
P-001ABC      Yamaha FZ 150      2
P-002DEF      Honda CB 190       1
P-003GHI      Suzuki GN 125      1
```

**5. Repuestos mas usados (para decidir cuales mantener en stock):**

```text
nombre_repuesto        unidades_usadas
Pastillas Freno           3
Aceite Motor              1
Bujia                     1
Cadena Transmision        1
Filtro Aire               1
```

## Operaciones de mantenimiento verificadas

- **DELETE controlado**: se elimino la Cadena Transmision agregada por error en la orden 4, mientras esta seguia `recibida` (todavia sin trabajo empezado). La orden 4 quedo solo con Pastillas Freno.
- `UPDATE ordenes_servicio SET estado = 'en_reparacion' WHERE id_orden = 4 ...;` → la orden de revision de frenos de Manuel Estrada paso a trabajo en curso.

## Aprendizaje

El `UNIQUE (id_orden, id_repuesto)` en `detalle_repuestos` evita
registrar el mismo repuesto dos veces como linea separada en la misma
orden. El `DELETE` controlado de este ejercicio solo se aplica
mientras una orden sigue `recibida`: una vez que pasa a
`en_reparacion` o `finalizada`, sus repuestos ya son parte del
historial oficial del trabajo y no se borran, tal como pidio el
cliente ("corregir estados sin borrar informacion importante"). Los
estados se corrigen siempre con `UPDATE`, nunca eliminando y
recreando la orden.
