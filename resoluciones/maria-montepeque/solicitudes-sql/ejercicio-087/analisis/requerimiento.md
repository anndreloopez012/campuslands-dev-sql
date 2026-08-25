# Analisis del requerimiento - Ejercicio 087

## Solicitud entendida

Un club registra jugadores, partidos, goles, tarjetas y posiciones de
un torneo de futbol sala. El cliente pide que el sistema permita
corregir estados sin borrar informacion importante: los goles y
tarjetas de un partido ya jugado son historico oficial y no se
borran, solo se corrige el estado del partido cuando algo cambia. Es
un nivel 5 (solicitud profesional): ademas del modelo, se pide
interpretar ambiguedad, normalizar datos, documentar decisiones y
crear al menos una vista SQL.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| equipos | Catalogo: cada equipo del torneo | nombre_equipo (unico), categoria |
| jugadores | Catalogo: cada jugador, de un equipo | nombre_jugador, numero_camiseta |
| partidos | Tabla transaccional: enfrentamiento entre dos equipos | fecha_partido, estado |
| goles | Historico: cada gol anotado en un partido | minuto |
| tarjetas | Historico: cada tarjeta mostrada en un partido | tipo_tarjeta, minuto |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| equipos -> jugadores | 1:N | Un equipo tiene varios jugadores. |
| equipos -> partidos | 1:N (dos veces) | Un equipo juega muchos partidos, como local o como visitante. |
| partidos -> goles | 1:N | Un partido tiene una fila de goles por cada anotacion. |
| jugadores -> goles | 1:N | Un jugador anota goles en muchos partidos distintos. |
| partidos -> tarjetas | 1:N | Un partido tiene una fila de tarjetas por cada sancion. |
| jugadores -> tarjetas | 1:N | Un jugador puede recibir tarjetas en varios partidos. |

## Decisiones de modelado y ambiguedad interpretada

- **"Corregir estados sin borrar informacion importante" (la peticion
  central del cliente):** el estado de un partido
  (`'programado'`/`'en_curso'`/`'finalizado'`/`'suspendido'`) se
  corrige siempre con `UPDATE`. Los goles y tarjetas de un partido ya
  `'finalizado'` son historico oficial y no se borran; el `DELETE`
  solo se permite sobre goles o tarjetas de un partido que se
  suspende, cuando esos registros resultaron ser un error de captura
  hecho antes de que se confirmara la suspension.
- **`UNIQUE (id_equipo, numero_camiseta)` en `jugadores`:** ningun
  equipo puede repetir el mismo numero de camiseta en dos jugadores
  distintos, una regla de negocio real de cualquier liga.
- **Vista SQL:** se crea `vista_resumen_partidos`, que junta partido y
  los nombres de ambos equipos en un solo reporte legible.
- **Ambiguedad no resuelta por el cliente:** no se detallo que pasa si
  un jugador recibe una segunda tarjeta amarilla en el mismo partido
  (deberia implicar expulsion). Se documenta como fuera del alcance de
  este nivel: el modelo registra las tarjetas tal como ocurren, sin
  calcular automaticamente si eso implica una expulsion.

## Reglas de negocio

- Regla 1 (relaciones invalidas): todo jugador debe apuntar a un
  equipo real; todo partido debe apuntar a dos equipos reales; todo
  gol y toda tarjeta deben apuntar a un partido y a un jugador reales
  (`FOREIGN KEY` en cadena).
- Regla 2 (registros repetidos): `equipos.nombre_equipo` no se repite
  (`UNIQUE`); un jugador no repite numero de camiseta dentro de su
  mismo equipo (`UNIQUE` compuesto).
- Regla 3 (valores fuera de rango): `goles.minuto` y
  `tarjetas.minuto` siempre entre 1 y 60 (`CHECK`, incluye tiempo
  extra de futsal).
- Regla 4: un partido nace `'programado'` y avanza a `'en_curso'`,
  `'finalizado'` o `'suspendido'` (`CHECK`); se corrige con `UPDATE`.
- Regla 5: ver decision de modelado arriba (DELETE solo para
  registros de un partido suspendido, nunca de uno finalizado).

## Supuestos

- No se detallo si un jugador puede cambiar de equipo durante el
  torneo; se asume que no, para el alcance de este nivel.
- Se asume que "posiciones" (mencionado en el contexto del cliente) se
  calcula como un reporte derivado de goles y resultados, no como una
  tabla propia, porque no aporta informacion nueva que no se pueda
  calcular desde `partidos` y `goles`.

## Preguntas que responde la base de datos

1. Que partidos existen, con sus dos equipos (via la vista
   `vista_resumen_partidos`).
2. Que partidos estan programados, en curso, finalizados o
   suspendidos.
3. Que jugador tiene mas goles (ranking de actividad).
4. Como se ordenan los goles por partido y por minuto.
5. Que jugadores tienen 2 o mas goles, candidatos a mejor jugador del
   torneo.
