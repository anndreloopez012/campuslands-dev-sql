# Evidencias - Solicitudes SQL - Ejercicio 042 (Streaming Musica)

## Comandos ejecutados

```bash
sqlite3 ejercicio-042.db < ddl/schema.sql
sqlite3 ejercicio-042.db < dml/inserts.sql
sqlite3 ejercicio-042.db < dml/operaciones.sql
sqlite3 ejercicio-042.db < dql/consultas.sql
```

## Resultados

**1. Todas las reproducciones, con JOIN triple a usuarios, canciones y artistas (ya sin la duplicada, sin la fraudulenta -eliminada tras revertir su monto- y con la reproduccion 9 confirmada como legitima):**

```text
id_reproduccion | nombre_usuario   | titulo            | nombre_artista  | fecha_reproduccion | monto_regalia | estado
1                | Camila Rios      | Luz de Neon        | Luna Marbella    | 2026-08-01           | 0.0045         | contabilizada
2                | Esteban Coy      | Carretera Sola     | Los Cerrones     | 2026-08-01           | 0.0010         | contabilizada
3                | Natalia Boror    | Pulso Digital      | DJ Kaqchikel     | 2026-08-02           | 0.0045         | contabilizada
4                | Camila Rios      | Horizonte Verde    | Valeria Norte    | 2026-08-02           | 0.0045         | contabilizada
5                | Julio Herrera    | Luz de Neon        | Luna Marbella    | 2026-08-03           | 0.0010         | contabilizada
6                | Priscila Ajanel  | Noche de Jazz      | Trio Ceibal      | 2026-08-03           | 0.0045         | contabilizada
7                | Camila Rios      | Eco de Ciudad      | Luna Marbella    | 2026-08-04           | 0.0045         | contabilizada
8                | Esteban Coy      | Pulso Digital      | DJ Kaqchikel     | 2026-08-04           | 0.0010         | contabilizada
9                | Natalia Boror    | Bajo el Volcan     | Los Cerrones     | 2026-08-05           | 0.0045         | contabilizada
12               | Julio Herrera    | Circuito Cerrado   | DJ Kaqchikel     | 2026-08-07           | 0.0010         | en_revision
```

Quedan 10 reproducciones (empezaron 12: se elimino la duplicada `id_reproduccion = 11` y la fraudulenta ya revertida `id_reproduccion = 10`).

**2. Reproducciones que no estan contabilizadas todavia:**

```text
id_reproduccion | id_usuario | id_cancion | fecha_reproduccion | estado
12               | 4          | 8           | 2026-08-07           | en_revision
```

Esta es la unica que sigue pendiente de revision al final del proceso; a proposito no se resolvio, para dejar un caso real de "trabajo en curso".

**3. Artista con mas reproducciones contabilizadas:**

```text
nombre_artista  | total_reproducciones
Luna Marbella   | 3
DJ Kaqchikel    | 2
Los Cerrones    | 2
Trio Ceibal     | 1
Valeria Norte   | 1
```

**4. Reproducciones ordenadas por fecha:** ver tabla completa arriba, de 2026-08-01 a 2026-08-07.

**5. Dinero en regalias por artista (solo contabilizadas), para decidir a quien pagar primero:**

```text
nombre_artista  | total_regalias
Luna Marbella   | 0.01
DJ Kaqchikel    | 0.0055
Los Cerrones    | 0.0055
Trio Ceibal     | 0.0045
Valeria Norte   | 0.0045
```

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- Registro repetido: `INSERT INTO canciones (titulo, id_artista, ...) VALUES ('Luz de Neon', 1, ...);` → `UNIQUE constraint failed: canciones.titulo, canciones.id_artista`.
- Valor fuera de rango: `INSERT INTO canciones (..., duracion_segundos) VALUES (..., 0);` → `CHECK constraint failed: duracion_segundos > 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE reproducciones SET estado = 'contabilizada' WHERE id_reproduccion = 9 AND estado = 'en_revision';` → la reproduccion de Natalia Boror se confirmo como legitima.
- `UPDATE reproducciones SET estado = 'fraudulenta', monto_regalia = 0 WHERE id_reproduccion = 10 AND estado = 'en_revision';` → se confirmo que era un bot: se revirtio el monto (de 0.0200 a 0) y se marco `fraudulenta`.
- `DELETE FROM reproducciones WHERE estado = 'fraudulenta' AND monto_regalia = 0;` → **DELETE controlado**: solo borro la reproduccion 10, porque ya estaba `fraudulenta` y su dinero ya estaba en 0. Ninguna otra fila cumplia ambas condiciones a la vez, asi que nada mas se vio afectado.
- `DELETE FROM reproducciones WHERE id_reproduccion = 11;` → la reproduccion duplicada desaparecio. Conteo final verificado: 10 reproducciones (empezaron 12).

## Aprendizaje

El `DELETE` controlado de este ejercicio exige dos condiciones a la vez (`estado = 'fraudulenta' AND monto_regalia = 0`), lo que obliga a pasar primero por el `UPDATE` que revierte el dinero antes de poder borrar el registro. Esto responde directamente al pedido del cliente de saber "cuanto dinero representa cada movimiento": nunca se pierde el rastro de una regalia sin antes dejar constancia de que se revirtio a 0.
