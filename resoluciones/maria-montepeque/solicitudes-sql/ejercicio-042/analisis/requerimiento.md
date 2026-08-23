# Analisis del requerimiento - Ejercicio 042

## Solicitud entendida

Una plataforma musical necesita playlists, artistas, canciones y reproducciones. El cliente pide saber quien reprodujo, que reprodujo, cuando ocurrio y cuanto dinero (regalia) representa cada reproduccion. Es un ejercicio de nivel 3: ademas de corregir estados, se pide `DELETE` controlado con criterios de negocio reales.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| artistas | Es el catalogo de artistas de la plataforma. | nombre_artista (unico), genero |
| canciones | Es el catalogo de canciones, cada una de un artista. | titulo, id_artista (FK), duracion_segundos |
| usuarios | Es el catalogo de usuarios que escuchan musica. | nombre_usuario (unico), email (unico), plan |
| reproducciones | Es el registro transaccional de cada reproduccion: quien la hizo, que cancion, cuando y cuanto dinero (regalia) representa. Aqui es donde la plataforma detecta fraude y corrige montos. | id_usuario (FK), id_cancion (FK), fecha_reproduccion, monto_regalia, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| artistas -> canciones | 1:N | Un artista puede tener muchas canciones. |
| usuarios -> reproducciones | 1:N | Un usuario puede tener muchas reproducciones. |
| canciones -> reproducciones | 1:N | Una cancion puede tener muchas reproducciones. |

## Reglas de negocio

- Regla 1: Toda cancion debe apuntar a un artista real; toda reproduccion debe apuntar a un usuario real y a una cancion real (`FOREIGN KEY` en cadena).
- Regla 2: `genero`, `email`, `plan` y `duracion_segundos` son `NOT NULL`.
- Regla 3: `duracion_segundos` siempre debe ser mayor a cero (`CHECK`).
- Regla 4: `monto_regalia` nunca puede ser negativo (`CHECK`).
- Regla 5: Un mismo artista no puede repetir el mismo `titulo` de cancion dos veces (`UNIQUE` compuesto sobre `titulo` + `id_artista`); artistas distintos si pueden compartir titulo.
- Regla 6: `nombre_usuario` y `email` no se repiten (`UNIQUE`).
- Regla 7: Una reproduccion puede estar `contabilizada`, `en_revision` o `fraudulenta` (`CHECK`). Toda reproduccion sospechosa nace `en_revision` y se corrige con `UPDATE` despues de investigarla.
- Regla 8: Solo se permite `DELETE` de una reproduccion cuando ya quedo confirmada como `fraudulenta` **y** su `monto_regalia` ya se revirtio a 0. Nunca se borra una reproduccion que todavia representa dinero contabilizado.

## Supuestos

- El contexto menciona `playlists`, pero no se modelo como tabla aparte: el pedido explicito del cliente es rastrear "quien, que, cuando y cuanto dinero" por movimiento, y eso vive completo en `reproducciones`. El alcance de este nivel es 3 a 4 tablas, y una playlist (con su propia relacion N:M contra canciones) llevaria el modelo mas alla de eso.
- `monto_regalia` varia segun el plan del usuario (los usuarios `premium` generan una regalia mayor por reproduccion que los `gratuito`), pero esa regla de negocio se aplica al capturar el dato, no se modelo como columna calculada.

## Preguntas que responde la base de datos

1. Que reproducciones existen, con que usuario, que cancion y que artista.
2. Que reproducciones no estan contabilizadas todavia.
3. Que artista tiene mas reproducciones contabilizadas.
4. Como se ordenan las reproducciones por fecha.
5. Cuanto dinero en regalias genera cada artista, para decidir a quien pagar primero.
