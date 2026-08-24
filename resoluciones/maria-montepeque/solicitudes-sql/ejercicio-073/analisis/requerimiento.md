# Analisis del requerimiento - Ejercicio 073

## Solicitud entendida

Una plataforma de shooter administra clanes, scrims (partidas de
practica entre clanes), mapas y resultados. El cliente quiere evitar
registros incompletos porque despues no puede hacer reportes
confiables: eso significa que el modelo debe impedir, desde el diseno,
que un scrim quede sin resultado claro o con resultados repetidos o
contradictorios. Se necesita una base de datos que permita consultar
datos, corregir estados, registrar movimientos y sacar reportes
utiles, como que clan gana mas scrims.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clanes | Catalogo: cada clan registrado en la plataforma | nombre_clan (unico), region |
| jugadores | Catalogo: cada jugador, miembro de un clan | nickname (unico), id_clan |
| mapas | Catalogo: cada mapa disponible para scrims | nombre_mapa (unico), modo_juego |
| scrims | Tabla transaccional: enfrentamiento programado entre dos clanes en un mapa | fecha_scrim, estado |
| resultados | Registro oficial del resultado de un scrim, uno solo por scrim | marcador_local, marcador_visitante, id_clan_ganador |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clanes -> jugadores | 1:N | Un clan tiene varios jugadores. |
| clanes -> scrims | 1:N (dos veces) | Un clan juega muchos scrims, como local o como visitante. |
| mapas -> scrims | 1:N | Un mapa se usa en muchos scrims. |
| scrims -> resultados | 1:1 | Cada scrim tiene, como mucho, un resultado oficial: ese es justo el problema de registros incompletos/duplicados que preocupa al cliente. |

## Reglas de negocio

Cada regla ataca directamente el problema central del cliente
(registros incompletos que no sirven para reportes confiables):

- Regla 1 (relaciones invalidas): todo scrim debe apuntar a dos
  clanes reales y a un mapa real; todo resultado debe apuntar a un
  scrim real (`FOREIGN KEY` en cadena).
- Regla 2 (registros repetidos/incompletos): `clanes.nombre_clan`,
  `jugadores.nickname` y `mapas.nombre_mapa` no se repiten (`UNIQUE`);
  un scrim no puede tener mas de un resultado oficial
  (`UNIQUE (id_scrim)` en `resultados`, que en la practica funciona
  como una relacion 1:1). Esto es exactamente lo que evita el reporte
  confiable que pidio el cliente.
- Regla 3 (valores fuera de rango): `marcador_local` y
  `marcador_visitante` nunca pueden ser negativos (`CHECK`).
- Regla 4: un scrim nace `'programado'` y solo puede avanzar a
  `'jugado'` o `'cancelado'` (`CHECK`); se corrige con `UPDATE`.
- Regla 5: un resultado solo tiene sentido para un scrim que ya se
  jugo. Si un scrim se cancela y ya tenia un resultado cargado por
  error, ese resultado se elimina; nunca se borra el resultado de un
  scrim `'jugado'`, porque ya es un dato oficial de la liga.

## Supuestos

- El cliente no detallo si `id_clan_ganador` debe validarse contra los
  dos clanes del scrim correspondiente; SQLite no permite un `CHECK`
  que compare columnas de dos tablas distintas, asi que esa regla
  queda documentada aqui como responsabilidad del proceso de carga
  (siempre se inserta el ganador ya sabiendo que es local o
  visitante), no como una restriccion de base de datos.
- Se asume que un jugador pertenece a un solo clan a la vez (no hay
  historial de transferencias en el alcance de este nivel).
- Se asume que el marcador de un scrim empatado tambien es valido
  (`marcador_local = marcador_visitante`); en ese caso
  `id_clan_ganador` puede quedar en `NULL`.

## Preguntas que responde la base de datos

1. Que scrims existen, con que clanes y en que mapa.
2. Que scrims estan programados, jugados o cancelados.
3. Que clan jugo mas scrims (ranking de actividad).
4. Como se ordenan los scrims por fecha.
5. Que clan gano mas scrims, para decidir quien clasifica a playoffs.
