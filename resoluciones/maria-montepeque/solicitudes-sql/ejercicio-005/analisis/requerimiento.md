# Analisis del requerimiento - Ejercicio 005

## Solicitud entendida

Un cine organiza funciones de peliculas de terror ("Horror Nights"), con salas y venta de boletos. El cliente describe su operacion diaria en lenguaje simple (vende boletos para peliculas, en asientos especificos) y espera que se traduzca a tablas. Quiere poder consultar datos, corregir estados de un boleto y sacar reportes utiles.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| peliculas | Es el catalogo de peliculas en cartelera, cada una con su sala y precio de boleto. En este nivel, cada pelicula representa una unica funcion programada (no hay multiples horarios por pelicula). | titulo (unico), genero, sala_asignada, precio_boleto |
| boletos | Es el registro transaccional de cada venta: que pelicula, que asiento, quien lo compro y en que estado esta (vendido, usado, reembolsado). Aqui vive la operacion diaria del cine. | id_pelicula (FK), nombre_cliente, asiento, precio_pagado, fecha_compra, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| peliculas -> boletos | 1:N | Una pelicula (funcion) tiene muchos boletos vendidos, pero cada boleto pertenece a una sola pelicula. |

## Reglas de negocio

- Regla 1: Todo boleto debe apuntar a una pelicula real en cartelera (`FOREIGN KEY`).
- Regla 2: No se puede vender el mismo asiento dos veces para la misma pelicula (`UNIQUE` sobre `id_pelicula` + `asiento`); esto evita el problema clasico de doble venta de un asiento.
- Regla 3: `precio_boleto` y `precio_pagado` siempre deben ser mayores a cero (`CHECK`).
- Regla 4: Un boleto puede estar `vendido`, `usado` o `reembolsado` (`CHECK`); el cine necesita poder corregir ese estado (por ejemplo, cuando el cliente entra a la sala o pide reembolso).

## Supuestos

- No se creo una tabla `salas` separada: el alcance de este nivel pide 1 a 2 tablas, asi que la sala se guarda como un dato dentro de `peliculas` (`sala_asignada`).
- Se asume que cada pelicula del catalogo representa una unica funcion programada (no varios horarios el mismo dia); si el cine necesitara varias funciones por pelicula, se separaria una tabla `funciones` entre `peliculas` y `boletos`.
- El estado por defecto de un boleto nuevo es `vendido`, porque asi entra la mayoria de las ventas.

## Preguntas que responde la base de datos

1. Que boletos existen y en que estado quedo cada uno.
2. Que boletos no siguen como venta activa normal (usados o reembolsados).
3. Que pelicula vende mas boletos.
4. Como se ordenan los boletos por fecha de compra.
5. Que reporte de ingresos por pelicula (excluyendo reembolsos) puede usar el cine para decidir que extender en cartelera.
