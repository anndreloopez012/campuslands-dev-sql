# Evidencias - Solicitudes SQL - Ejercicio 012 (Club Futbol Sala)

## Comandos ejecutados

```bash
sqlite3 ejercicio-012.db < ddl/schema.sql
sqlite3 ejercicio-012.db < dml/inserts.sql
sqlite3 ejercicio-012.db < dml/operaciones.sql
sqlite3 ejercicio-012.db < dql/consultas.sql
```

## Resultados

**1. Todos los eventos (ya con el de prueba eliminado y el bono de Pedro Gomez pagado):**

```text
id_evento | id_equipo | nombre_jugador | tipo_evento         | fecha_partido | monto | estado
1         | 1         | Andres Lopez     | gol                  | 2026-07-01     | 50.0  | pagado
2         | 2         | Carlos Ruiz      | tarjeta_amarilla     | 2026-07-01     | 25.0  | registrado
3         | 1         | Marta Vega       | gol                  | 2026-07-05     | 50.0  | pagado
4         | 3         | Diana Cruz       | tarjeta_roja         | 2026-07-05     | 80.0  | registrado
5         | 2         | Pedro Gomez      | gol                  | 2026-07-08     | 50.0  | pagado
6         | 4         | Sofia Reyes      | tarjeta_amarilla     | 2026-07-08     | 15.0  | pagado
7         | 1         | Andres Lopez     | gol                  | 2026-07-12     | 50.0  | registrado
8         | 3         | Laura Ortiz      | tarjeta_amarilla     | 2026-07-12     | 25.0  | anulado
```

Quedan 8 eventos (empezaron 9, se elimino el de prueba del `id_evento = 9`).

**2. Eventos que no estan pagados todavia:**

```text
id_evento | nombre_jugador | tipo_evento         | fecha_partido | estado
2         | Carlos Ruiz      | tarjeta_amarilla     | 2026-07-01     | registrado
4         | Diana Cruz       | tarjeta_roja         | 2026-07-05     | registrado
7         | Andres Lopez     | gol                  | 2026-07-12     | registrado
8         | Laura Ortiz      | tarjeta_amarilla     | 2026-07-12     | anulado
```

**3. Jugador con mas eventos registrados:**

```text
nombre_jugador   | total_eventos
Andres Lopez       | 2
Sofia Reyes         | 1
Pedro Gomez         | 1
Marta Vega          | 1
Laura Ortiz         | 1
Diana Cruz          | 1
Carlos Ruiz         | 1
```

**4. Eventos ordenados por fecha del partido:** ver tabla completa arriba, de 2026-07-01 a 2026-07-12.

**5. Cuanto dinero representa cada tipo de evento (sin contar anulados):**

```text
tipo_evento         | total_dinero | total_eventos
gol                   | 200.0        | 4
tarjeta_roja           | 80.0         | 1
tarjeta_amarilla       | 40.0         | 2
```

El club debe 200.0 en bonos por goles y recauda 120.0 en multas por tarjetas (80.0 + 40.0). La tarjeta amarilla anulada de Laura Ortiz correctamente no cuenta en este total.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO eventos (..., tipo_evento, monto) VALUES (..., 'gol', -50.00);` → `CHECK constraint failed: monto >= 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE eventos SET estado = 'pagado' WHERE id_evento = 5 AND estado = 'registrado';` → el bono de Pedro Gomez paso de `registrado` a `pagado`.
- `UPDATE equipos SET categoria = 'primera' WHERE id_equipo = 3;` → Rayos del Sur ascendio de `segunda` a `primera`.
- `DELETE FROM eventos WHERE id_evento = 9;` → el evento de prueba desaparecio; el conteo final es 8, no 9.

## Aprendizaje

Traducir "cuanto dinero representa cada movimiento" a este dominio deportivo significo reconocer que un gol y una tarjeta son, en el fondo, el mismo tipo de dato desde la perspectiva contable: ambos son un evento con un `monto` asociado (bono a favor o multa en contra). Modelarlos en una sola tabla `eventos` con `tipo_evento` como diferenciador evita crear tablas separadas para `goles` y `tarjetas` que tendrian columnas casi identicas. El estado `anulado` es clave para la integridad del reporte financiero: si la tarjeta anulada de Laura Ortiz se hubiera contado en la consulta 5, el club habria calculado mal cuanto debe recaudar.
