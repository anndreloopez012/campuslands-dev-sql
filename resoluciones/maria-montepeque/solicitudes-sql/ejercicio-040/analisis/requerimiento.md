# Analisis del requerimiento - Ejercicio 040

## Solicitud entendida

Un laboratorio registra formulas, muestras, reactivos y resultados. El cliente quiere que la base de datos detecte tres tipos de error especificos: registros repetidos, relaciones invalidas y valores fuera de rango. El modelo se diseño para que la base de datos misma rechace esos tres errores al momento de insertar, en vez de descubrirlos despues en un reporte.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| formulas | Es el catalogo de formulas que el laboratorio analiza. | nombre_formula (unico), tipo |
| reactivos | Es el catalogo de reactivos que se usan en los analisis. | nombre_reactivo (unico), unidad_medida |
| muestras | Es el registro transaccional de cada analisis: que formula, con que reactivo, cuando, que concentracion se midio y que resultado dio. Aqui es donde el laboratorio corrige resultados y saca reportes de calidad. | id_formula (FK), id_reactivo (FK), fecha_analisis, concentracion, resultado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| formulas -> muestras | 1:N | Una formula puede tener muchas muestras analizadas. |
| reactivos -> muestras | 1:N | Un reactivo puede usarse en muchas muestras. |

## Reglas de negocio

Cada regla ataca directamente uno de los tres errores que el cliente quiere detectar:

- Regla 1 (relaciones invalidas): Toda muestra debe apuntar a una formula real y a un reactivo real (`FOREIGN KEY` doble). Sin esto, una muestra podria quedar "huerfana" apuntando a una formula que no existe.
- Regla 2 (registros repetidos): `nombre_formula` y `nombre_reactivo` no se repiten (`UNIQUE`). Sin esto, la misma formula podria registrarse dos veces con nombres identicos y contaminar los conteos.
- Regla 3 (valores fuera de rango): `concentracion` debe estar entre 0 (exclusivo) y 100 (inclusivo), porque es un porcentaje y no tiene sentido fisico fuera de ese rango (`CHECK`).
- Regla 4: `tipo` y `unidad_medida` son `NOT NULL`, porque sin ellos la ficha del catalogo queda incompleta.
- Regla 5: Una muestra puede tener resultado `pendiente`, `valido`, `invalido` o `repetir` (`CHECK`); el laboratorio necesita poder corregir este resultado despues de revisar cada caso.

## Supuestos

- `concentracion` se interpreta como un porcentaje (0 a 100), porque es la forma mas comun de medir concentracion en un laboratorio y permite un rango de `CHECK` claro y verificable.
- El resultado `repetir` existe porque, tal como piden las pistas del ejercicio, cuando algo sale mal no se borra la muestra: se corrige su estado para volver a analizarla.

## Preguntas que responde la base de datos

1. Que muestras existen, con que formula y que reactivo.
2. Que muestras todavia no tienen un resultado valido.
3. Que formula tiene mas muestras analizadas.
4. Como se ordenan las muestras por fecha.
5. Que formula acumula mas muestras invalidas o por repetir, para decidir cual revisar con prioridad (reporte de control de calidad).
