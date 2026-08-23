# Analisis del requerimiento - Ejercicio 024

## Solicitud entendida

Una liga de videojuegos de futbol registra usuarios (managers), sus clubes, las jornadas jugadas y los goles de cada partido. El cliente necesita un reporte rapido al final de cada semana para tomar decisiones (que dia hubo mas actividad, que club rinde mejor).

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| usuarios | Es el catalogo de jugadores humanos (managers) registrados en la liga. | nombre_usuario (unico), email (unico) |
| clubes | Es el catalogo de clubes virtuales, cada uno administrado por un usuario. Un usuario puede tener un club. | id_usuario (FK), nombre_club (unico), division |
| partidos | Es el registro transaccional de cada partido jugado entre dos clubes en una jornada: goles, fecha y estado. Aqui vive el reporte semanal que pide el cliente. | id_club_local (FK), id_club_visitante (FK), jornada, goles_local, goles_visitante, fecha_partido, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| usuarios -> clubes | 1:N | Un usuario puede administrar clubes (en este modelo, cada usuario tiene su propio club). |
| clubes -> partidos (local) | 1:N | Un club juega muchos partidos como local. |
| clubes -> partidos (visitante) | 1:N | Un club juega muchos partidos como visitante. |

## Reglas de negocio

- Regla 1: Todo club debe pertenecer a un usuario real (`FOREIGN KEY`), y todo partido debe apuntar a dos clubes reales (`FOREIGN KEY` doble); ademas ningun club puede jugar contra si mismo (`CHECK`).
- Regla 2: `goles_local` y `goles_visitante` nunca pueden ser negativos (`CHECK`), y `jornada` siempre debe ser mayor a cero.
- Regla 3: Un partido puede estar `jugado`, `pendiente` o `suspendido` (`CHECK`); la liga necesita poder corregir este estado cuando un partido pendiente finalmente se juega, actualizando el marcador real.
- Regla 4: `nombre_usuario`, `email` y `nombre_club` no se repiten (`UNIQUE`).

## Supuestos

- No se creo una tabla `jornadas` separada: `jornada` se guarda como un numero entero dentro de `partidos`, ya que el alcance de este nivel pide 2 a 3 tablas con relaciones uno a muchos, y el foco esta en usuarios/clubes/partidos.
- Un partido `pendiente` se inserta con marcador `0-0` como valor temporal (todavia no se juega); cuando realmente se juega, se corrige con `UPDATE` tanto el marcador real como el estado a `jugado`.
- El reporte semanal se arma agrupando `partidos` por dia dentro del rango de fechas de la semana de prueba (2026-08-10 a 2026-08-14), sumando los goles de partidos ya `jugado`.

## Preguntas que responde la base de datos

1. Que partidos existen y en que estado quedo cada uno.
2. Que partidos no estan jugados todavia.
3. Que club tiene mas partidos jugados.
4. Como se ordenan los partidos por fecha, para revisar la semana dia a dia.
5. Que reporte semanal (goles totales por dia, solo partidos jugados) puede usar la liga para decidir en que jornada hubo mas actividad.
