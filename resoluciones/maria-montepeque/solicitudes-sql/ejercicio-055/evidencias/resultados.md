# Evidencias - Solicitudes SQL - Ejercicio 055 (Cine Horror Nights)

## Comandos ejecutados

```bash
sqlite3 ejercicio-055.db < ddl/schema.sql
sqlite3 ejercicio-055.db < dml/inserts.sql
sqlite3 ejercicio-055.db < dml/operaciones.sql
sqlite3 ejercicio-055.db < dql/consultas.sql
```

## Resultados

**1. Todas las funciones, con JOIN a peliculas y salas, y el conteo de boletos vendidos (ya sin la duplicada, con la funcion 4 finalizada y la funcion 5 en curso):**

```text
id_funcion | titulo                 | nombre_sala | fecha_hora         | precio_boleto | estado       | boletos_vendidos
1           | La Casa del Silencio    | Sala 1        | 2026-10-01 19:00     | 45.0            | finalizada    | 4
2           | Posesion Nocturna       | Sala 2        | 2026-10-01 21:00     | 50.0            | finalizada    | 6
3           | El Ultimo Sotano        | Sala 3        | 2026-10-02 19:30     | 45.0            | finalizada    | 3
4           | La Casa del Silencio    | Sala 2        | 2026-10-02 22:00     | 55.0            | finalizada    | 1
5           | Munecas de Porcelana    | Sala 4        | 2026-10-03 18:00     | 40.0            | en_curso      | 1
6           | Sangre en el Bosque     | Sala 1        | 2026-10-03 20:30     | 50.0            | programada    | 1
7           | Posesion Nocturna       | Sala 3        | 2026-10-04 21:00     | 50.0            | cancelada     | 0
8           | El Ultimo Sotano        | Sala 4        | 2026-10-05 19:00     | 45.0            | programada    | 0
```

Quedan 8 funciones (empezaron 9, se elimino la duplicada `id_funcion = 9`) y 17 boletos (empezaron 19, se eliminaron los dos reembolsados de funciones sin proyectar todavia).

**2. Funciones que no estan finalizadas todavia:**

```text
id_funcion | id_pelicula | id_sala | fecha_hora         | estado
5           | 4            | 4        | 2026-10-03 18:00     | en_curso
6           | 5            | 1        | 2026-10-03 20:30     | programada
7           | 2            | 3        | 2026-10-04 21:00     | cancelada
8           | 3            | 4        | 2026-10-05 19:00     | programada
```

**3. Pelicula con mas boletos vendidos en total:**

```text
titulo                 | boletos_vendidos
Posesion Nocturna       | 6
La Casa del Silencio    | 5
El Ultimo Sotano        | 3
Munecas de Porcelana    | 1
Sangre en el Bosque     | 1
```

**4. Funciones ordenadas por fecha y hora:** ver tabla completa arriba, del 2026-10-01 al 2026-10-05.

**5. Funciones programadas o en curso con menor ocupacion, para decidir cuales necesitan mas promocion:**

```text
titulo                 | nombre_sala | fecha_hora         | estado       | boletos_vendidos | capacidad | ocupacion_pct
El Ultimo Sotano        | Sala 4        | 2026-10-05 19:00     | programada    | 0                  | 5          | 0.0
Sangre en el Bosque     | Sala 1        | 2026-10-03 20:30     | programada    | 1                  | 8          | 12.5
Munecas de Porcelana    | Sala 4        | 2026-10-03 18:00     | en_curso      | 1                  | 5          | 20.0
```

La funcion de El Ultimo Sotano en Sala 4 no ha vendido ni un solo boleto: es la que mas urgentemente necesita promocion.

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- Registro repetido: `INSERT INTO boletos (id_funcion, ..., asiento) VALUES (1, ..., 'A1');` → `UNIQUE constraint failed: boletos.id_funcion, boletos.asiento`.
- Valor fuera de rango: `INSERT INTO funciones (..., precio_boleto) VALUES (..., 0);` → `CHECK constraint failed: precio_boleto > 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE funciones SET estado = 'finalizada' WHERE id_funcion = 4 AND estado = 'en_curso';` → la funcion de La Casa del Silencio en Sala 2 quedo finalizada.
- `UPDATE funciones SET estado = 'en_curso' WHERE id_funcion = 5 AND estado = 'programada';` → la funcion de Munecas de Porcelana comenzo.
- `DELETE FROM boletos WHERE estado = 'reembolsado' AND EXISTS (...);` → **DELETE controlado**: elimino los boletos reembolsados de las funciones 6 (programada) y 7 (cancelada). El boleto reembolsado de la funcion 1 (ya `finalizada`) no se toco: se conserva como historial de auditoria.
- `DELETE FROM funciones WHERE id_funcion = 9;` → la funcion duplicada desaparecio. Conteo final verificado: 8 funciones, 17 boletos, sin huerfanos.

## Aprendizaje

El `UNIQUE` compuesto sobre `id_funcion` + `asiento` resuelve, desde el diseño, un problema real de un cine: nunca se puede vender el mismo asiento dos veces para la misma funcion. El `DELETE` controlado usa el estado de la funcion padre (no solo el del boleto) para decidir si un reembolso se puede borrar: si la pelicula ya se proyecto, ese reembolso queda como parte del historial de ingresos, sin importar que tan simple parezca el borrado.
