# Analisis del requerimiento - Ejercicio 049

## Solicitud entendida

Una liga de videojuegos de futbol registra usuarios, clubes, jornadas y goles. El cliente necesita guardar historico porque en auditorias le preguntan que paso y cuando paso: por eso cada partido guarda cuando fue su ultimo cambio de estado, y las correcciones se hacen con `UPDATE`, no borrando registros. Es nivel 3: se pide `DELETE` controlado.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| usuarios | Es el catalogo de usuarios que juegan en la liga. | nombre_usuario (unico), email (unico) |
| clubes | Es el catalogo de clubes disponibles para jugar. | nombre_club (unico), liga |
| jornadas | Es el catalogo de jornadas de la temporada. | numero_jornada (unico), fecha_jornada, temporada |
| partidos | Es el registro transaccional de cada partido: que usuario, en que jornada, con que club, contra que club rival, el marcador y en que estado va. Aqui es donde la liga corrige informacion y guarda el historico para auditorias. | id_usuario (FK), id_jornada (FK), club_usuario (FK), club_rival (FK), fecha_partido, goles_usuario, goles_rival, estado, fecha_ultimo_cambio |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| usuarios -> partidos | 1:N | Un usuario juega muchos partidos. |
| jornadas -> partidos | 1:N | Una jornada agrupa varios partidos. |
| clubes -> partidos | 1:N (x2) | Un club puede aparecer como club del usuario o como club rival en muchos partidos. |

## Reglas de negocio

- Regla 1: Todo partido debe apuntar a un usuario real, una jornada real, un club de usuario real y un club rival real (`FOREIGN KEY` multiple).
- Regla 2: `email`, `liga` y `temporada` son `NOT NULL`.
- Regla 3: `goles_usuario` y `goles_rival` nunca pueden ser negativos (`CHECK`); `numero_jornada` siempre debe ser mayor a cero (`CHECK`).
- Regla 4: `nombre_usuario`, `email`, `nombre_club` y `numero_jornada` no se repiten (`UNIQUE`).
- Regla 5: Un partido puede estar `jugado`, `en_revision` o `anulado` (`CHECK`); se corrige con `UPDATE` y siempre se actualiza `fecha_ultimo_cambio`, para poder responder "que paso y cuando paso" en una auditoria.
- Regla 6: Solo se permite `DELETE` de un partido cuando esta `anulado` **y** nunca genero marcador real (`goles_usuario = 0 AND goles_rival = 0`). Un partido anulado que ya tiene marcador registrado no se borra.

## Supuestos

- `fecha_partido` se guarda por separado de `fecha_jornada` porque un partido puede jugarse un dia distinto al oficial de la jornada (por ejemplo, un partido pospuesto), y la auditoria necesita la fecha real del movimiento.
- `club_usuario` y `club_rival` apuntan al mismo catalogo `clubes`: cualquier club de la liga puede ser elegido tanto por el usuario como por su rival en partidos distintos.

## Preguntas que responde la base de datos

1. Que partidos existen, con que usuario, jornada y clubes.
2. Que partidos no estan jugados todavia (siguen en revision).
3. Que usuario tiene mas partidos jugados.
4. Como se ordenan los partidos por fecha.
5. Que usuario tiene mas goles anotados en total (solo partidos jugados), para decidir a quien destacar como jugador del mes.
