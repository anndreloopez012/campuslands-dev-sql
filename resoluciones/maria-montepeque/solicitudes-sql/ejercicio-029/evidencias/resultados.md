# Evidencias - Solicitudes SQL - Ejercicio 029 (Tienda Sneakers)

## Comandos ejecutados

```bash
sqlite3 ejercicio-029.db < ddl/schema.sql
sqlite3 ejercicio-029.db < dml/inserts.sql
sqlite3 ejercicio-029.db < dml/operaciones.sql
sqlite3 ejercicio-029.db < dql/consultas.sql
```

## Resultados

**1. Historico completo, con JOIN doble (ya sin la entrada de prueba y con el evento del pedido 4 confirmado):**

```text
id_evento | nombre_cliente   | nombre_modelo           | talla | tipo_evento | fecha_evento       | estado
1         | Ana Gomez          | Air Max 90               | 38     | creado       | 2026-08-01 10:00   | valido
2         | Ana Gomez          | Air Max 90               | 38     | pagado       | 2026-08-01 10:15   | valido
3         | Luis Marroquin     | Ultraboost 22            | 39     | creado       | 2026-08-02 11:00   | valido
4         | Luis Marroquin     | Ultraboost 22            | 39     | pagado       | 2026-08-02 11:20   | valido
5         | Ana Gomez          | Air Max 90               | 38     | enviado      | 2026-08-03 09:00   | valido
6         | Karen Solis        | Jordan Retro 1           | 41     | creado       | 2026-08-04 12:00   | valido
7         | Ana Gomez          | Air Max 90               | 38     | entregado    | 2026-08-05 15:00   | valido
8         | Diego Paz          | Chuck Taylor All Star    | 37     | creado       | 2026-08-06 10:30   | valido
9         | Rosa Chavez        | Yeezy Boost 350          | 42     | creado       | 2026-08-07 09:00   | valido
```

Quedan 9 eventos (empezaron 10, se elimino la entrada de prueba del `id_evento = 10`).

**2. Eventos anulados:**

```text
(sin filas)
```

El evento del pedido de Diego Paz (id_evento = 8) ya no aparece aqui porque `operaciones.sql` lo confirmo (`anulado` -> `valido`) tras verificar el stock.

**3. Pedido con mas eventos en su historico:**

```text
nombre_cliente   | nombre_modelo           | total_eventos
Ana Gomez          | Air Max 90               | 4
Luis Marroquin      | Ultraboost 22            | 2
Karen Solis          | Jordan Retro 1           | 1
Diego Paz            | Chuck Taylor All Star    | 1
Rosa Chavez           | Yeezy Boost 350          | 1
```

El pedido de Ana Gomez completo todo el ciclo de vida (creado, pagado, enviado, entregado), por eso tiene el historico mas largo.

**4. Historico ordenado cronologicamente (que paso y cuando paso):** ver tabla completa arriba, de 2026-08-01 a 2026-08-07.

**5. Ultimo evento registrado por pedido:**

```text
nombre_cliente   | nombre_modelo           | tipo_evento | fecha_evento       | estado
Ana Gomez          | Air Max 90               | entregado    | 2026-08-05 15:00   | valido
Diego Paz            | Chuck Taylor All Star    | creado       | 2026-08-06 10:30   | valido
Karen Solis          | Jordan Retro 1           | creado       | 2026-08-04 12:00   | valido
Luis Marroquin       | Ultraboost 22            | pagado       | 2026-08-02 11:20   | valido
Rosa Chavez           | Yeezy Boost 350          | creado       | 2026-08-07 09:00   | valido
```

Esta consulta responde exactamente lo que pide una auditoria: en un vistazo se ve en que quedo cada pedido por ultima vez.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO eventos_pedido (id_pedido, tipo_evento, estado) VALUES (2, 'extraviado', 'valido');` → `CHECK constraint failed: tipo_evento IN ('creado', 'pagado', 'enviado', 'entregado', 'devuelto')`.

## Operaciones de mantenimiento verificadas

- `UPDATE eventos_pedido SET estado = 'valido' WHERE id_evento = 8 AND estado = 'anulado';` → el evento del pedido de Diego Paz paso de `anulado` a `valido` tras confirmar stock, sin alterar el evento original (mismo `tipo_evento`, misma `fecha_evento`).
- `UPDATE clientes SET email = 'ana.gomez.nueva@correo.com' WHERE id_cliente = 1;` → Ana Gomez actualizo su correo.
- `DELETE FROM eventos_pedido WHERE id_evento = 10;` → la entrada de prueba desaparecio; el conteo final es 9, no 10.

## Aprendizaje

Este ejercicio reafirma el patron de historico de auditoria en un tercer dominio distinto (estudio de animacion, estudio de arquitectura, ahora una tienda de sneakers): separar la cabecera permanente del pedido (`pedidos`: cliente, modelo, talla, precio) del historico de eventos (`eventos_pedido`: que paso y cuando) permite responder "en que quedo el pedido" (consulta 5) sin perder el camino completo que siguio (consulta 4). El pedido de Ana Gomez, con 4 eventos, demuestra que un ciclo de vida completo (creado -> pagado -> enviado -> entregado) se ve naturalmente como 4 filas separadas, no como una sola fila que va cambiando de estado sin dejar rastro.
