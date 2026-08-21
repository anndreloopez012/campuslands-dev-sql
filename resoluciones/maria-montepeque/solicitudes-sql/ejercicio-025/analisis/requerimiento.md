# Analisis del requerimiento - Ejercicio 025

## Solicitud entendida

Una pista organiza track days con vehiculos hiperdeportivos: un piloto lleva su vehiculo, corre sesiones cronometradas y se registra su tiempo de vuelta. El cliente no piensa en tablas, describe su operacion diaria, y espera que se traduzca a un modelo relacional con pilotos, sus vehiculos y las sesiones que corren.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| pilotos | Es el catalogo de pilotos registrados en la pista, cada uno con su licencia y categoria. | nombre_piloto (unico), licencia (unica), categoria |
| vehiculos | Es el catalogo de vehiculos, cada uno propiedad de un piloto. | id_piloto (FK), modelo, potencia_hp |
| sesiones | Es el registro transaccional de cada vuelta cronometrada: que vehiculo, cuanto tiempo hizo, en que clima y en que estado quedo (valida, descalificada, en revision por sospecha de corte de pista). | id_vehiculo (FK), tiempo_vuelta_segundos, fecha_sesion, clima, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| pilotos -> vehiculos | 1:N | Un piloto puede tener varios vehiculos registrados. |
| vehiculos -> sesiones | 1:N | Un vehiculo corre muchas sesiones a lo largo del tiempo. |

## Reglas de negocio

- Regla 1: Todo vehiculo debe pertenecer a un piloto real (`FOREIGN KEY`), y toda sesion debe apuntar a un vehiculo real (`FOREIGN KEY`).
- Regla 2: `tiempo_vuelta_segundos` y `potencia_hp` siempre deben ser mayores a cero (`CHECK`).
- Regla 3: Una sesion puede estar `valida`, `descalificada` o `en_revision` (`CHECK`); la pista necesita poder corregir este estado cuando se investiga una sospecha de corte de pista.
- Regla 4: `nombre_piloto`, `licencia` no se repiten (`UNIQUE`).
- Regla 5: `clima` solo puede ser uno de los valores validos (`CHECK`).

## Supuestos

- `potencia_hp` se guarda en `vehiculos` como un dato del catalogo (no cambia entre sesiones), mientras que `tiempo_vuelta_segundos` es el dato que si cambia en cada sesion.
- Una sesion `en_revision` se corrige a `valida` o `descalificada` segun el resultado de la investigacion; no se borra mientras representa una vuelta que realmente se corrio.
- El "mejor tiempo" de un piloto se calcula como el minimo `tiempo_vuelta_segundos` entre todas sus sesiones `valida` (menor tiempo es mejor en carreras).

## Preguntas que responde la base de datos

1. Que sesiones existen y en que estado quedo cada una.
2. Que sesiones no estan validas todavia (en revision o descalificadas).
3. Que piloto tiene mas sesiones corridas.
4. Como se ordenan las sesiones por fecha.
5. Cual es el mejor tiempo de vuelta (record) de cada piloto, para armar la tabla de tiempos de la pista.
