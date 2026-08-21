# Analisis del requerimiento - Ejercicio 015

## Solicitud entendida

Un laboratorio quimico registra formulas, muestras, reactivos y resultados. El cliente no piensa en tablas, describe su operacion diaria: llega una muestra, se analiza con un reactivo, y se obtiene un resultado (o la muestra se contamina y hay que descartarla). Se traduce esa operacion a un modelo con catalogo de reactivos y registro de muestras analizadas.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| reactivos | Es el catalogo de reactivos quimicos disponibles en el laboratorio, con su unidad de medida y stock. | nombre_reactivo (unico), unidad_medida, stock_disponible |
| muestras | Es el registro transaccional de cada muestra analizada: con que reactivo, cuando, que resultado dio y en que estado esta (en analisis, completada, contaminada). | id_reactivo (FK), codigo_muestra, fecha_analisis, resultado, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| reactivos -> muestras | 1:N | Un reactivo se usa en muchas muestras a lo largo del tiempo, pero cada muestra se analiza con un unico reactivo (en este nivel simplificado). |

## Reglas de negocio

- Regla 1: Toda muestra debe usar un reactivo real del catalogo (`FOREIGN KEY`).
- Regla 2: `stock_disponible` nunca puede ser negativo (`CHECK`).
- Regla 3: `codigo_muestra` no se repite (`UNIQUE`), es el identificador que usa el laboratorio para rastrear cada muestra.
- Regla 4: Una muestra puede estar `en_analisis`, `completado` o `contaminada` (`CHECK`); el laboratorio necesita poder corregir este estado a medida que avanza el analisis.
- Regla 5: `resultado` se deja sin `NOT NULL` a proposito: una muestra que sigue `en_analisis` todavia no tiene resultado.

## Supuestos

- No se creo una tabla `formulas` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el modelo se centra en `reactivos` y `muestras`, que es donde vive la operacion diaria del laboratorio.
- Una muestra `contaminada` se conserva en el registro (no se borra) para que el laboratorio tenga trazabilidad de que paso con ella.
- El stock de un reactivo se descuenta manualmente con `UPDATE` cuando se consume en un analisis.

## Preguntas que responde la base de datos

1. Que muestras existen y en que estado quedo cada una.
2. Que muestras no estan completadas todavia (en analisis o contaminadas).
3. Que reactivo se usa mas.
4. Como se ordenan las muestras por fecha de analisis.
5. Cuantas muestras hay por estado, para medir la tasa de contaminacion del laboratorio.
