# Evidencias - Solicitudes SQL - Ejercicio 030 (Cine Horror Nights)

## Comandos ejecutados

```bash
sqlite3 ejercicio-030.db < ddl/schema.sql
sqlite3 ejercicio-030.db < dml/inserts.sql
sqlite3 ejercicio-030.db < dml/operaciones.sql
sqlite3 ejercicio-030.db < dql/consultas.sql
```

## Resultados

**1. Todas las funciones, con JOIN doble (ya sin la de prueba y con la funcion de Posesion 13 finalizada):**

```text
id_funcion | titulo                  | nombre_sala | fecha_hora          | precio_boleto | estado
1          | El Grito Final            | Sala 1        | 2026-08-15 19:00     | 45.0           | finalizada
2          | Medianoche Sangrienta     | Sala 2        | 2026-08-15 21:00     | 45.0           | finalizada
3          | La Casa del Silencio      | Sala 1        | 2026-08-16 18:00     | 40.0           | programada
4          | El Grito Final            | Sala 3        | 2026-08-16 20:00     | 50.0           | programada
5          | Posesion 13               | Sala 2        | 2026-08-17 19:00     | 42.0           | finalizada
6          | El Legado Maldito         | Sala VIP      | 2026-08-17 21:00     | 60.0           | programada
7          | Medianoche Sangrienta     | Sala 1        | 2026-08-18 18:30     | 45.0           | programada
8          | La Casa del Silencio      | Sala 3        | 2026-08-18 20:30     | 40.0           | cancelada
```

Quedan 8 funciones (empezaron 9, se elimino la funcion de prueba del `id_funcion = 9`).

**2. Funciones que no estan finalizadas todavia:**

```text
id_funcion | id_pelicula | id_sala | fecha_hora          | estado
3          | 3            | 1        | 2026-08-16 18:00     | programada
4          | 1            | 3        | 2026-08-16 20:00     | programada
6          | 5            | 4        | 2026-08-17 21:00     | programada
7          | 2            | 1        | 2026-08-18 18:30     | programada
8          | 3            | 3        | 2026-08-18 20:30     | cancelada
```

**3. Sala con mas funciones:**

```text
nombre_sala   | total_funciones
Sala 1          | 3
Sala 2           | 2
Sala 3           | 2
Sala VIP         | 1
```

**4. Funciones ordenadas por fecha y hora:** ver tabla completa arriba, de 2026-08-15 a 2026-08-18.

**5. Ingreso potencial por sala (sin canceladas):**

```text
nombre_sala   | capacidad | ingreso_potencial
Sala 1          | 80         | 130.0
Sala 2           | 60         | 87.0
Sala VIP         | 40         | 60.0
Sala 3           | 100        | 50.0
```

Sala 1 es la que mas funciones tiene y tambien la que mas ingreso potencial genera.

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- `INSERT INTO funciones (..., id_sala, fecha_hora, ...) VALUES (2, 1, '2026-08-15 19:00', 45.00);` → `UNIQUE constraint failed: funciones.id_sala, funciones.fecha_hora` (Sala 1 ya tenia una funcion programada a esa hora exacta).
- `INSERT INTO peliculas (titulo, duracion_min) VALUES ('Pelicula Imposible', 10);` → `CHECK constraint failed: duracion_min BETWEEN 60 AND 240`.

## Operaciones de mantenimiento verificadas

- `UPDATE funciones SET estado = 'finalizada' WHERE id_funcion = 5 AND estado = 'en_curso';` → la funcion de Posesion 13 paso de `en_curso` a `finalizada`.
- `UPDATE peliculas SET duracion_min = 100 WHERE id_pelicula = 4;` → se corrigio la duracion de Posesion 13.
- `DELETE FROM funciones WHERE id_funcion = 9;` → la funcion de prueba desaparecio; el conteo final es 8, no 9.

## Aprendizaje

`UNIQUE (id_sala, fecha_hora)` es la pieza clave de este modelo de nivel 2: traduce literalmente la regla operativa del cine ("no se puede programar dos funciones en la misma sala a la misma hora") en algo que SQLite hace cumplir automaticamente, sin necesidad de que el encargado revise manualmente el horario de cada sala antes de agendar. Junto con el `CHECK` de rango en `duracion_min` y las `FOREIGN KEY` dobles en `funciones`, este modelo cubre exactamente los tres tipos de error que preocupaban al cliente (registros repetidos, relaciones invalidas, valores fuera de rango), ahora aplicados a una tabla que conecta dos catalogos distintos en vez de solo uno.
