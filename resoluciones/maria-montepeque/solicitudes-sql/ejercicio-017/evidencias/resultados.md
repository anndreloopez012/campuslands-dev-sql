# Evidencias - Solicitudes SQL - Ejercicio 017 (Streaming Musica)

## Comandos ejecutados

```bash
sqlite3 ejercicio-017.db < ddl/schema.sql
sqlite3 ejercicio-017.db < dml/inserts.sql
sqlite3 ejercicio-017.db < dml/operaciones.sql
sqlite3 ejercicio-017.db < dql/consultas.sql
```

## Resultados

**1. Todas las canciones (ya con la de prueba eliminada y "Furia de Acero" restaurada):**

```text
id_cancion | id_artista | titulo             | duracion_segundos | fecha_lanzamiento | estado
1          | 1          | Brillo de Luna       | 210                 | 2025-01-15          | disponible
2          | 2          | Trueno Electrico     | 245                 | 2025-02-20          | disponible
3          | 3          | Pulso Nocturno       | 198                 | 2025-03-10          | bloqueada_por_derechos
4          | 1          | Cielo Infinito       | 200                 | 2025-04-05          | disponible
5          | 4          | Calor Tropical       | 220                 | 2025-05-12          | disponible
6          | 2          | Furia de Acero       | 260                 | 2025-06-01          | disponible
7          | 5          | Noches de Jazz       | 300                 | 2025-07-08          | disponible
8          | 3          | Bass Infinito        | 215                 | 2025-08-01          | disponible
```

Quedan 8 canciones (empezaron 9, se elimino la unica fila que de verdad debia borrarse: la entrada de prueba del `id_cancion = 9`).

**2. Canciones que no estan disponibles:**

```text
id_cancion | titulo           | id_artista | estado
3          | Pulso Nocturno    | 3           | bloqueada_por_derechos
```

"Furia de Acero" ya no aparece aqui porque `operaciones.sql` corrigio su estado de `retirada_temporalmente` a `disponible`, sin borrar su registro.

**3. Artista con mas canciones:**

```text
nombre_artista   | total_canciones
Luna Estrella      | 2
Los Rockeros        | 2
DJ Pulso             | 2
Ritmo Tropical       | 1
Trio Azul            | 1
```

**4. Canciones ordenadas por fecha de lanzamiento:** ver tabla completa arriba, de 2025-01-15 a 2025-08-01.

**5. Duracion total de contenido por artista:**

```text
nombre_artista   | genero_principal | duracion_total_segundos
Los Rockeros        | rock              | 505
DJ Pulso             | rock              | 413
Luna Estrella        | pop               | 410
Trio Azul            | jazz              | 300
Ritmo Tropical       | reggaeton         | 220
```

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO canciones (id_artista, titulo, duracion_segundos) VALUES (2, 'Silencio Total', 0);` → `CHECK constraint failed: duracion_segundos > 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE canciones SET estado = 'disponible' WHERE id_cancion = 6 AND estado = 'retirada_temporalmente';` → "Furia de Acero" volvio a estar disponible sin perder su fecha de lanzamiento ni su historial.
- `UPDATE artistas SET genero_principal = 'rock' WHERE id_artista = 3;` → se corrigio la clasificacion de genero de DJ Pulso.
- `DELETE FROM canciones WHERE id_cancion = 9;` → la entrada de prueba desaparecio; el conteo final es 8, no 9.

## Aprendizaje

La peticion del cliente ("permita corregir estados sin borrar informacion importante") se ve clara al comparar las tres operaciones: dos son `UPDATE` (restaurar una cancion retirada, corregir un genero mal clasificado) y solo una es `DELETE`, y esa unica eliminacion es para un registro que nunca debio existir. Una cancion bloqueada por derechos o retirada temporalmente conserva su fila completa (titulo, duracion, fecha de lanzamiento) y solo cambia su `estado`; borrar esa fila habria hecho perder el historial de que esa cancion alguna vez existio en el catalogo, informacion que la plataforma si necesita conservar para futuras negociaciones de derechos.
