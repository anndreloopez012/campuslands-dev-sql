# Analisis del requerimiento - Ejercicio 050

## Solicitud entendida

Una pista organiza sesiones de track day con vehiculos hiperdeportivos, pilotos y tiempos por vuelta. El cliente quiere detectar tres tipos de error especificos: registros repetidos, relaciones invalidas y valores fuera de rango. Es nivel 3: ademas de las restricciones, se pide `DELETE` controlado con criterios de negocio.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| pilotos | Es el catalogo de pilotos inscritos. | nombre_piloto (unico), licencia (unica) |
| vehiculos | Es el catalogo de vehiculos hiperdeportivos disponibles. | placa (unica), modelo, potencia_hp |
| sesiones | Es el catalogo de sesiones de pista del dia. | numero_sesion (unico), fecha_sesion, pista |
| tiempos | Es el registro transaccional de cada vuelta: que piloto, en que vehiculo, en que sesion, cuanto tardo y en que estado quedo. Aqui es donde la pista detecta errores y corrige resultados. | id_piloto (FK), id_vehiculo (FK), id_sesion (FK), vuelta, tiempo_segundos, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| pilotos -> tiempos | 1:N | Un piloto da muchas vueltas. |
| vehiculos -> tiempos | 1:N | Un vehiculo se usa en muchas vueltas. |
| sesiones -> tiempos | 1:N | Una sesion agrupa muchas vueltas. |

## Reglas de negocio

Cada regla ataca uno de los tres errores que el cliente quiere detectar:

- Regla 1 (relaciones invalidas): Todo tiempo debe apuntar a un piloto real, un vehiculo real y una sesion real (`FOREIGN KEY` triple). Sin esto, un tiempo podria quedar huerfano apuntando a un piloto que no existe.
- Regla 2 (registros repetidos): `nombre_piloto`, `licencia`, `placa` y `numero_sesion` no se repiten (`UNIQUE`). Sin esto, el mismo piloto o vehiculo podria registrarse dos veces y contaminar los reportes.
- Regla 3 (valores fuera de rango): `potencia_hp` y `vuelta` siempre deben ser mayores a cero, y `tiempo_segundos` nunca puede ser negativo (`CHECK`); una potencia en cero o negativa no tiene sentido fisico, y un tiempo negativo tampoco (0 se reserva para una vuelta no completada, ver supuestos).
- Regla 4: `modelo` y `pista` son `NOT NULL`.
- Regla 5: Un tiempo puede estar `valido`, `invalido` o `descalificado` (`CHECK`); se corrige con `UPDATE` tras revisar el video de la vuelta.
- Regla 6: Solo se permite `DELETE` de un tiempo cuando esta `invalido` **y** su `tiempo_segundos` es 0 (la vuelta nunca se completo, es un registro vacio). Un tiempo invalido que si tiene un valor real (por ejemplo, una vuelta lenta por salirse de pista) no se borra: se conserva como historial.

## Supuestos

- `tiempo_segundos` se guarda como un numero real (segundos con decimales), porque asi se mide una vuelta de circuito en la practica.
- Un tiempo con `tiempo_segundos = 0` representa una vuelta que no se completo (el piloto no cruzo la meta), no un tiempo real de cero segundos.

## Preguntas que responde la base de datos

1. Que tiempos existen, con que piloto, que vehiculo y que sesion.
2. Que tiempos no estan validos todavia.
3. Que piloto tiene mas vueltas registradas.
4. Como se ordenan los tiempos de menor a mayor (el mas rapido primero).
5. Cual es el mejor tiempo de cada piloto (solo vueltas validas), para armar el ranking del dia.
