# Analisis del requerimiento - Ejercicio 090

## Solicitud entendida

Un laboratorio quimico registra formulas, muestras, reactivos y
resultados. El cliente quiere detectar errores (registros repetidos,
relaciones invalidas o valores fuera de rango) y pidio convertir esa
operacion en una base de datos que permita consultar datos, corregir
estados, registrar movimientos y sacar reportes utiles. Es un nivel 5
(solicitud profesional): ademas del modelo, se pide interpretar
ambiguedad, normalizar datos, documentar decisiones y crear al menos
una vista SQL.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| tecnicos | Catalogo: quien recibe y procesa cada muestra | nombre_tecnico, codigo_tecnico (unico) |
| formulas | Catalogo: contra que formula se prueba cada muestra | nombre_formula (unica), categoria |
| reactivos | Catalogo: cada reactivo disponible en el laboratorio | nombre_reactivo (unico), stock_disponible |
| muestras | Historico: cada muestra recibida para analisis | fecha_recepcion, estado |
| resultados | Historico: el resultado oficial de analizar una muestra especifica | valor_medido, veredicto |

Se agrego `detalle_reactivos` como tabla puente entre `muestras` y
`reactivos` (relacion muchos a muchos: una muestra puede necesitar
varios reactivos para analizarse, y un mismo reactivo se usa en
muchas muestras distintas).

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| tecnicos -> muestras | 1:N | Un tecnico puede recibir y procesar varias muestras. |
| formulas -> muestras | 1:N | Una formula se prueba en varias muestras a lo largo del tiempo. |
| muestras -> resultados | 1:1 | Cada muestra tiene, como mucho, un resultado oficial asociado. |
| muestras -> detalle_reactivos | 1:N | Una muestra usa varios reactivos durante su analisis. |
| reactivos -> detalle_reactivos | 1:N | Un reactivo se usa en muchas muestras distintas. |

## Decisiones de modelado y ambiguedad interpretada

- **"Detectar registros repetidos, relaciones invalidas o valores
  fuera de rango" (la peticion central del cliente):** se resuelve con
  `UNIQUE` en los catalogos y en la relacion muestra-resultado, con
  `FOREIGN KEY` en cadena para que ninguna muestra, resultado o linea
  de reactivo apunte a un registro que no existe, y con `CHECK` en
  todos los valores numericos que no pueden ser negativos.
- **Vista SQL:** se crea `vista_historial_muestra`, que junta muestra,
  formula, tecnico y resultado en una sola consulta, respondiendo
  directamente "que paso y cuando paso" con cada muestra.
- **"Registrar movimientos" y "corregir estados":** las muestras nunca
  se borran (son historico de laboratorio); solo cambian de estado con
  `UPDATE`, y los reactivos cargados por error se corrigen con
  `DELETE` controlado mientras la muestra sigue en analisis.
- **Ambiguedad no resuelta por el cliente:** no se detallo si el
  laboratorio maneja lotes de reactivos con fecha de caducidad. Se
  documenta como fuera del alcance de este nivel: el modelo controla
  cantidad y stock, pero no vencimientos.

## Reglas de negocio

- Regla 1 (relaciones invalidas): toda muestra debe apuntar a una
  formula real y a un tecnico real; todo resultado debe apuntar a una
  muestra real; toda linea de `detalle_reactivos` debe apuntar a una
  muestra real y a un reactivo real (`FOREIGN KEY` en cadena).
- Regla 2 (registros repetidos): `tecnicos.codigo_tecnico`,
  `formulas.nombre_formula` y `reactivos.nombre_reactivo` no se
  repiten (`UNIQUE`); una muestra no puede tener mas de un resultado
  oficial (`UNIQUE (id_muestra)` en `resultados`); un reactivo no
  puede aparecer dos veces como linea separada en la misma muestra
  (`UNIQUE (id_muestra, id_reactivo)`).
- Regla 3 (valores fuera de rango): `reactivos.stock_disponible`,
  `resultados.valor_medido` nunca negativos;
  `detalle_reactivos.cantidad_usada` siempre mayor que 0 (`CHECK`).
- Regla 4: una muestra nace `'recibida'` y avanza a
  `'en_analisis'`, `'finalizada'` o `'rechazada'` (`CHECK`); se
  corrige con `UPDATE`.
- Regla 5: una linea de `detalle_reactivos` se puede quitar con
  `DELETE` solo mientras la muestra sigue `'recibida'` o
  `'en_analisis'` (todavia no hay resultado oficial). Una vez
  `'finalizada'` o `'rechazada'`, sus reactivos ya son parte del
  historico de auditoria y no se borran.

## Supuestos

- Se asume que el stock de reactivos se controla por cantidad total
  disponible (no por lote individual), por eso vive directamente en
  `reactivos.stock_disponible`.
- No se detallo si una muestra puede volver a analizarse tras ser
  `'rechazada'`; se asume que una muestra rechazada requiere registrar
  una muestra nueva, para el alcance de este nivel.

## Preguntas que responde la base de datos

1. Que paso con cada muestra (formula, tecnico, resultado), via la
   vista `vista_historial_muestra`.
2. Que muestras estan en analisis en este momento.
3. Que reactivos se usaron en cada muestra y en que cantidad.
4. Como se ordenan las muestras por fecha de recepcion.
5. Que formulas tienen mas resultados registrados y cual es su valor
   medido promedio.
6. Que formulas tienen muestras rechazadas, para decidir cuales
   revisar con el proveedor de reactivos.
