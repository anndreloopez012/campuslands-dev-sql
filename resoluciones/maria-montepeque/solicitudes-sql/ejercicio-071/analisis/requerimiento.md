# Analisis del requerimiento - Ejercicio 071

## Solicitud entendida

Una comunidad gamer organiza partidas de battle royale y necesita
llevar el registro de kills, posiciones y ranking semanal por
temporada. Hoy todo se maneja en hojas de calculo y varias personas
duplican datos sin darse cuenta (por ejemplo, cargan dos veces el
resultado del mismo jugador en la misma partida). Se necesita una
base de datos que evite esos duplicados desde el diseno, permita
corregir estados, registrar movimientos y sacar reportes utiles como
el ranking final de una temporada.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| jugadores | Catalogo: cada participante de la comunidad | nickname (unico), region |
| temporadas | Catalogo: periodo de competencia con ranking propio | nombre_temporada (unico), fecha_inicio, fecha_fin |
| partidas | Tabla transaccional: cada partida jugada dentro de una temporada | fecha_partida, mapa, estado |
| estadisticas | Detalle de cada partida: kills y posicion final de cada jugador que participo | kills, posicion_final |
| ranking | Resumen por temporada: puntos totales acumulados de cada jugador | puntos_totales |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| temporadas -> partidas | 1:N | Una temporada agrupa varias partidas. |
| partidas -> estadisticas | 1:N | Una partida tiene una fila de estadisticas por cada jugador que participo. |
| jugadores -> estadisticas | 1:N | Un jugador participa en muchas partidas a lo largo del tiempo. |
| temporadas -> ranking | 1:N | Una temporada tiene un ranking con una fila por jugador. |
| jugadores -> ranking | 1:N | Un jugador aparece en el ranking de cada temporada en la que jugo. |

## Reglas de negocio

- Regla 1 (el problema central del cliente: datos duplicados): un
  jugador no puede tener mas de una fila de estadisticas en la misma
  partida (`UNIQUE (id_partida, id_jugador)`). Esto es justo lo que
  hoy falla en la hoja de calculo.
- Regla 2: un jugador solo puede tener una fila de ranking por
  temporada (`UNIQUE (id_temporada, id_jugador)`).
- Regla 3: una partida nace `'programada'` y solo puede avanzar a
  `'jugada'` o `'cancelada'` (`CHECK`).
- Regla 4: `kills` nunca puede ser negativo y `posicion_final` siempre
  debe ser 1 o mayor (`CHECK`).
- Regla 5: si una partida se cancela despues de haber cargado
  estadisticas por error, esas filas de estadisticas se eliminan
  porque no deben contar para el ranking; nunca se borra una
  estadistica de una partida que ya quedo `'jugada'` (eso alteraria un
  resultado ya oficial).
- Regla 6: los puntos del ranking se calculan a partir de las
  estadisticas de las partidas `'jugada'` de la temporada: 1 punto por
  kill, mas un bono por posicion final (10 puntos por el primer lugar,
  5 puntos del segundo al quinto lugar, 0 puntos del sexto lugar en
  adelante). El ranking se corrige con `UPDATE`, nunca se recalcula
  borrando y reinsertando filas.

## Supuestos

- El cliente no detallo la formula exacta de puntos; se asume
  1 punto por kill + bono por posicion (10 para el 1er lugar, 5 para
  el 2do-5to lugar) por ser un esquema comun en battle royale y
  suficiente para demostrar el modelo.
- No se detallo si un jugador puede cambiar de region; se asume que
  `region` es un dato descriptivo simple, no una llave de otra tabla,
  para el alcance de este nivel.
- Se asume que el ranking se guarda como tabla propia (no se calcula
  siempre al vuelo) porque el cliente pidio poder "corregir estados" y
  "sacar reportes", lo que sugiere que el ranking es un dato que se
  actualiza y se consulta seguido.

## Preguntas que responde la base de datos

1. Que estadisticas existen, con que jugador y en que partida.
2. Que partidas estan programadas, jugadas o canceladas.
3. Que jugador participo en mas partidas (ranking de actividad).
4. Como se ordena el ranking final de la temporada, de mayor a menor
   puntaje.
5. Que jugadores acumularon mas kills en la temporada, para decidir a
   quien destacar como MVP.
