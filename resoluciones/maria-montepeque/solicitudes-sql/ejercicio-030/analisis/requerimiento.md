# Analisis del requerimiento - Ejercicio 030

## Solicitud entendida

Un cine organiza funciones de peliculas de terror, con salas y venta de boletos. El cliente pidio explicitamente poder detectar errores: registros repetidos (dos funciones a la misma hora en la misma sala), relaciones invalidas (una funcion de una pelicula o sala que no existe) y valores fuera de rango (por ejemplo, una duracion de pelicula imposible).

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| peliculas | Es el catalogo de peliculas de terror que maneja el cine. | titulo (unico), duracion_min |
| salas | Es el catalogo de salas del cine, cada una con su capacidad. | nombre_sala (unico), capacidad |
| funciones | Es el registro transaccional de cada funcion programada: que pelicula, en que sala, a que hora, a que precio y en que estado. | id_pelicula (FK), id_sala (FK), fecha_hora, precio_boleto, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| peliculas -> funciones | 1:N | Una pelicula puede tener muchas funciones programadas. |
| salas -> funciones | 1:N | Una sala puede tener muchas funciones a lo largo del tiempo. |

## Reglas de negocio

- Regla 1: Toda funcion debe apuntar a una pelicula real y a una sala real (`FOREIGN KEY` doble); esto evita directamente la "relacion invalida" que preocupa al cliente.
- Regla 2: `duracion_min` debe estar en un rango realista (`CHECK BETWEEN 60 AND 240`); esto detecta el "valor fuera de rango" que menciona el cliente.
- Regla 3: No se puede programar dos funciones en la misma sala a la misma hora (`UNIQUE (id_sala, fecha_hora)`); esto evita directamente el "registro repetido" que preocupa al cliente (doble reserva de una sala).
- Regla 4: `precio_boleto` y `capacidad` siempre deben ser mayores a cero (`CHECK`).
- Regla 5: Una funcion puede estar `programada`, `en_curso`, `finalizada` o `cancelada` (`CHECK`); el cine necesita poder corregir este estado a medida que avanza el dia.

## Supuestos

- No se creo una tabla `boletos` separada en este nivel: el alcance de este ejercicio pide 2 a 3 tablas con relaciones uno a muchos, y el foco esta en peliculas/salas/funciones. La venta de boletos se modelo en el ejercicio equivalente de nivel 1 (ejercicio 005).
- `titulo` y `nombre_sala` no se repiten (`UNIQUE`), ademas de la regla de sala+hora unica en `funciones`.

## Preguntas que responde la base de datos

1. Que funciones existen y en que estado quedo cada una.
2. Que funciones no estan finalizadas todavia.
3. Que sala tiene mas funciones programadas.
4. Como se ordenan las funciones por fecha y hora.
5. Que ingreso potencial genera cada sala (sin contar canceladas), para decidir que sala usar mas.
