# Analisis del requerimiento - Ejercicio 012

## Solicitud entendida

Un club de futbol sala registra jugadores, partidos, goles, tarjetas y posiciones. El cliente pidio saber quien hizo el movimiento, que tipo de movimiento fue, cuando ocurrio y cuanto dinero representa: en este club, los goles generan un bono para el jugador y las tarjetas (amarilla o roja) generan una multa. Ambos casos son "movimientos" con un valor monetario asociado.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| equipos | Es el catalogo de equipos del club, cada uno con su categoria. | nombre_equipo (unico), categoria |
| eventos | Es el registro transaccional de cada movimiento del partido: un gol (bono) o una tarjeta (multa). Aqui vive directamente la pregunta del cliente: quien, que, cuando y cuanto dinero. | id_equipo (FK), nombre_jugador, tipo_evento, fecha_partido, monto, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| equipos -> eventos | 1:N | Un equipo acumula muchos eventos (goles y tarjetas de sus jugadores) a lo largo de la temporada, pero cada evento pertenece a un unico equipo. |

## Reglas de negocio

- Regla 1: Todo evento debe pertenecer a un equipo real (`FOREIGN KEY`).
- Regla 2: `monto` nunca puede ser negativo (`CHECK >= 0`); un bono o multa negativa no tiene sentido de negocio.
- Regla 3: `tipo_evento` solo puede ser `gol`, `tarjeta_amarilla` o `tarjeta_roja` (`CHECK`).
- Regla 4: Un evento puede estar `registrado`, `pagado` o `anulado` (`CHECK`); el club necesita poder corregir este estado (por ejemplo, cuando el arbitro revisa una tarjeta y la anula, o cuando se paga un bono).
- Regla 5: El nombre del equipo no se repite (`UNIQUE`).

## Supuestos

- No se creo una tabla `jugadores` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el nombre del jugador se guarda dentro de `eventos`.
- `monto` representa el bono a favor del jugador cuando `tipo_evento = 'gol'`, y la multa en contra cuando es una tarjeta; en ambos casos es "cuanto dinero representa" el movimiento, tal como pidio el cliente.
- Un evento `anulado` (por ejemplo, una tarjeta que el arbitro revisa y quita) se conserva en el historico con ese estado, no se borra, para que quede registro de la decision.

## Preguntas que responde la base de datos

1. Que eventos (goles y tarjetas) existen y en que estado quedo cada uno.
2. Que eventos no estan pagados todavia (registrados o anulados).
3. Que jugador tiene mas eventos registrados.
4. Como se ordenan los eventos por fecha del partido.
5. Cuanto dinero representa cada tipo de evento (sin contar los anulados), para que el club sepa cuanto debe en bonos y cuanto recauda en multas.
