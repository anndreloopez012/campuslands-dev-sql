# Analisis del requerimiento - Ejercicio 074

## Solicitud entendida

Una liga de videojuegos de futbol registra usuarios, clubes, jornadas
y goles. El cliente necesita un reporte rapido para tomar decisiones
al final de cada semana (cada jornada). Se necesita una base de datos
que permita consultar datos, corregir estados, registrar movimientos
y sacar ese reporte semanal de forma confiable.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| usuarios | Catalogo: cada jugador humano de la liga | nombre_usuario (unico), email (unico) |
| clubes | Catalogo: cada club de futbol disponible en el videojuego | nombre_club (unico), liga |
| jornadas | Catalogo: cada semana de competencia | numero_jornada (unico), fecha_inicio, fecha_fin |
| partidos | Tabla transaccional: un usuario juega con un club contra otro usuario con otro club, dentro de una jornada | fecha_partido, estado |
| goles | Detalle de cada partido: cada gol anotado, de que club y en que minuto | minuto |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| jornadas -> partidos | 1:N | Una jornada agrupa varios partidos. |
| usuarios -> partidos | 1:N (dos veces) | Un usuario juega muchos partidos, como local o como visitante. |
| clubes -> partidos | 1:N (dos veces) | Un club se usa en muchos partidos, como local o como visitante (el mismo usuario puede elegir clubes distintos en cada partido). |
| partidos -> goles | 1:N | Un partido tiene una fila de goles por cada anotacion. |
| clubes -> goles | 1:N | Un club anota goles en muchos partidos distintos. |

## Reglas de negocio

- Regla 1 (relaciones invalidas): todo partido debe apuntar a una
  jornada, dos usuarios y dos clubes reales; todo gol debe apuntar a
  un partido y a un club reales (`FOREIGN KEY` en cadena).
- Regla 2 (registros repetidos): `usuarios.nombre_usuario`,
  `usuarios.email`, `clubes.nombre_club` y `jornadas.numero_jornada`
  no se repiten (`UNIQUE`).
- Regla 3 (valores fuera de rango): `goles.minuto` debe estar entre 1
  y 120 (`CHECK`, incluye tiempo extra);
  `jornadas.fecha_fin >= jornadas.fecha_inicio` (`CHECK`).
- Regla 4: un partido nace `'programado'` y solo puede avanzar a
  `'jugado'` o `'cancelado'` (`CHECK`); se corrige con `UPDATE`.
- Regla 5: el marcador de un partido no se guarda como numero fijo, se
  calcula sumando los goles de cada club en ese partido (ver el
  reporte semanal en `dql/consultas.sql`). Los goles solo tienen
  sentido para un partido que ya se jugo: si un partido se cancela y
  ya tenia goles cargados por error, esas filas se eliminan; nunca se
  borra un gol de un partido `'jugado'`, porque ya es un resultado
  oficial de la liga.

## Supuestos

- El cliente no detallo si `goles.id_club` debe validarse contra los
  dos clubes de ese partido especifico; SQLite no permite un `CHECK`
  que compare columnas de dos tablas distintas, asi que esa regla
  queda documentada aqui como responsabilidad del proceso de carga
  (siempre se registra el club que realmente jugo ese partido), no
  como una restriccion de base de datos.
- Se asume que un mismo usuario puede jugar con clubes distintos en
  partidos distintos (no hay una asignacion fija usuario-club), porque
  asi funcionan la mayoria de videojuegos de futbol.
- No se detallo un limite de goles por partido; se asume que el
  minuto (1 a 120) es la unica validacion de rango necesaria.

## Preguntas que responde la base de datos

1. Que goles existen, con que club, que partido y que jornada.
2. Que partidos estan programados, jugados o cancelados.
3. Que club anoto mas goles en total (ranking de actividad).
4. Como se ordenan los goles por minuto.
5. Que club domino la jornada actual en goles anotados, para el
   reporte rapido semanal que pidio el cliente.
