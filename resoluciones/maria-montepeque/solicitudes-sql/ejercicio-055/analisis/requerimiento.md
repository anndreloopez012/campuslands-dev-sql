# Analisis del requerimiento - Ejercicio 055

## Solicitud entendida

Un cine organiza funciones de peliculas de miedo, salas y ventas de boletos. El cliente no habla en terminos de tablas: solo describe su operacion diaria (programar una funcion, vender un boleto, cancelar, reembolsar) y espera que se traduzca a SQL. Es nivel 3: se pide `DELETE` controlado.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| peliculas | Es el catalogo de peliculas de terror en cartelera. | titulo (unico), duracion_minutos, clasificacion |
| salas | Es el catalogo de salas del cine, cada una con su capacidad. | nombre_sala (unico), capacidad |
| funciones | Es el registro de cada funcion programada: que pelicula, en que sala, cuando, a que precio y en que estado va. | id_pelicula (FK), id_sala (FK), fecha_hora, precio_boleto, estado |
| boletos | Es el registro de cada boleto vendido para una funcion: que asiento y en que estado. | id_funcion (FK), nombre_cliente, asiento, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| peliculas -> funciones | 1:N | Una pelicula puede tener varias funciones programadas. |
| salas -> funciones | 1:N | Una sala puede tener varias funciones a lo largo del dia. |
| funciones -> boletos | 1:N | Una funcion puede tener muchos boletos vendidos. |

## Reglas de negocio

- Regla 1: Toda funcion debe apuntar a una pelicula real y a una sala real; todo boleto debe apuntar a una funcion real (`FOREIGN KEY` en cadena).
- Regla 2: `duracion_minutos`, `capacidad`, `precio_boleto`, `nombre_cliente` y `asiento` son `NOT NULL`.
- Regla 3: `duracion_minutos`, `capacidad` y `precio_boleto` siempre deben ser mayores a cero (`CHECK`).
- Regla 4: `titulo` y `nombre_sala` no se repiten (`UNIQUE`); un mismo asiento no se puede vender dos veces para la misma funcion (`UNIQUE` compuesto sobre `id_funcion` + `asiento`).
- Regla 5: Una funcion puede estar `programada`, `en_curso`, `finalizada` o `cancelada` (`CHECK`); un boleto puede estar `vendido`, `usado` o `reembolsado` (`CHECK`); ambos se corrigen con `UPDATE`.
- Regla 6: Solo se permite `DELETE` de un boleto cuando esta `reembolsado` **y** la funcion a la que pertenece esta `programada` o `cancelada` (todavia no se proyecto). Un boleto reembolsado de una funcion que ya se proyecto (`en_curso` o `finalizada`) no se borra: se conserva como historial de auditoria de ingresos.

## Supuestos

- El `asiento` se guarda como texto simple (por ejemplo "A1") dentro de `boletos`, no como una tabla `asientos` aparte, porque el alcance de este nivel es 3 a 4 tablas y lo unico que importa validar es que no se repita dentro de la misma funcion (resuelto con el `UNIQUE` compuesto).

## Preguntas que responde la base de datos

1. Que funciones existen, con que pelicula, que sala y cuantos boletos vendidos tiene cada una.
2. Que funciones no estan finalizadas todavia.
3. Que pelicula tiene mas boletos vendidos en total.
4. Como se ordenan las funciones por fecha y hora.
5. Que funciones programadas o en curso tienen menor porcentaje de ocupacion, para decidir cuales necesitan mas promocion.
