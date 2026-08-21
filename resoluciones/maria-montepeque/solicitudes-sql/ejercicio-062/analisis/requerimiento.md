# Analisis del requerimiento - Ejercicio 062

## Solicitud entendida

El cliente maneja un club de futbol sala y necesita reemplazar el
registro manual por una base de datos que permita consultar jugadores,
equipos, partidos, goles y tarjetas; corregir el estado de un partido;
registrar movimientos (goles y tarjetas) y sacar reportes utiles, por
ejemplo saber que jugador anota mas goles o que equipo acumula mas
tarjetas.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| equipos | Catalogo de equipos del club; se repite en jugadores y partidos | nombre (unico) |
| jugadores | Pertenece a un equipo; se repite en goles y tarjetas | nombre, posicion, dorsal |
| partidos | Tabla transaccional: enfrenta a dos equipos en una fecha | fecha_partido, estado |
| goles | Movimiento del partido: registra quien anoto y en que minuto | minuto |
| tarjetas | Movimiento del partido: registra sancion a un jugador | tipo (amarilla/roja), minuto |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| equipos -> jugadores | 1:N | Un equipo tiene muchos jugadores, cada jugador pertenece a un solo equipo. |
| equipos -> partidos (local) | 1:N | Un equipo juega muchos partidos como local. |
| equipos -> partidos (visitante) | 1:N | Un equipo juega muchos partidos como visitante. |
| partidos -> goles | 1:N | Un partido puede tener muchos goles. |
| jugadores -> goles | 1:N | Un jugador puede anotar muchos goles. |
| partidos -> tarjetas | 1:N | Un partido puede tener muchas tarjetas. |
| jugadores -> tarjetas | 1:N | Un jugador puede recibir muchas tarjetas. |

## Reglas de negocio

- Regla 1: un partido no puede enfrentar a un equipo contra si mismo
  (`CHECK (id_equipo_local <> id_equipo_visitante)`).
- Regla 2: un partido nace `'programado'` y solo puede avanzar a
  `'en_curso'` o `'finalizado'` (`CHECK`).
- Regla 3: dos jugadores del mismo equipo no pueden compartir dorsal
  (`UNIQUE (id_equipo, dorsal)`).
- Regla 4: una tarjeta es `'amarilla'` o `'roja'` (`CHECK`), y el minuto de
  un gol o tarjeta debe estar entre 1 y 60 (duracion de un partido de
  futbol sala con alargues, `CHECK`).

## Supuestos

- El cliente no especifico la duracion del partido; se asume un maximo de
  60 minutos (incluye posibles alargues) para el `CHECK` de minuto.
- No se especifico si puede haber empates ni desempates; no aplica para
  el alcance de este modelo (no se maneja marcador directo, se calcula
  contando goles).
- Se asume que cada jugador pertenece a un unico equipo durante la
  temporada modelada (no hay traspasos en este alcance).

## Preguntas que responde la base de datos

1. Cuales son todos los goles registrados, con jugador, equipo y partido.
2. Que partidos estan programados, en curso o ya finalizados.
3. Que jugador tiene mas actividad goleadora (ranking de goleadores).
4. Cuales son los partidos ordenados por fecha, del mas reciente al mas
   antiguo.
5. Que equipo acumula mas tarjetas (reporte para decision disciplinaria
   del cliente).
