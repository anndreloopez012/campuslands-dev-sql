# Analisis del requerimiento - Ejercicio 065

## Solicitud entendida

Un laboratorio quimico registra formulas, muestras, reactivos y
tecnicos, y no sabe hablar en terminos de tablas: solo describe su
operacion diaria. Se necesita traducir eso a una base de datos que
permita consultar datos, corregir el estado de una muestra, registrar
resultados y sacar reportes utiles, por ejemplo saber que reactivo se
usa mas o que formula tiene mas muestras aprobadas.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| tecnicos | Persona que toma y procesa la muestra; se repite en muchas muestras | nombre, especialidad |
| formulas | Formula quimica que se esta probando; se repite en muchas muestras | nombre (unico), descripcion |
| reactivos | Sustancia usada para el analisis; se repite en muchas muestras | nombre (unico), unidad_medida |
| muestras | Tabla transaccional central: un tecnico analiza una formula usando un reactivo, en una fecha, con un estado | fecha_muestra, estado |
| resultados | Medicion final de una muestra; se separa porque tiene su propio dato numerico y una decision de aprobacion | valor_medido, unidad, aprobado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| tecnicos -> muestras | 1:N | Un tecnico puede procesar muchas muestras, cada muestra tiene un solo tecnico responsable. |
| formulas -> muestras | 1:N | Una formula puede probarse en muchas muestras distintas. |
| reactivos -> muestras | 1:N | Un reactivo puede usarse en muchas muestras. |
| muestras -> resultados | 1:1 | Cada muestra genera, a lo sumo, un resultado final (`UNIQUE (id_muestra)`). |

## Reglas de negocio

- Regla 1: una muestra nace `'pendiente'` y solo puede avanzar a
  `'en_analisis'` o `'finalizada'` (`CHECK`).
- Regla 2: la unidad de medida de un reactivo debe ser una de las
  reconocidas por el laboratorio (`CHECK (unidad_medida IN ('ml', 'g', 'mol'))`).
- Regla 3: el valor medido de un resultado no puede ser negativo
  (`CHECK (valor_medido >= 0)`).
- Regla 4: `aprobado` es una bandera de si el resultado cumple el
  estandar del laboratorio (`CHECK (aprobado IN (0, 1))`).
- Regla 5: el nombre de una formula y el nombre de un reactivo no se
  pueden repetir (`UNIQUE`), para evitar duplicar catalogos.

## Supuestos

- El cliente no especifico si una muestra puede usar mas de un
  reactivo; se asume, para mantener el alcance de 5 tablas, que cada
  muestra registra el reactivo principal usado en ese analisis.
- No se especifico el criterio exacto de aprobacion; se asume que
  `resultados.aprobado` lo decide el tecnico al capturar el resultado,
  comparando el valor medido contra el estandar esperado de la formula
  (fuera del alcance de esta base de datos).
- Se asume que una muestra `'pendiente'` o `'en_analisis'` todavia no
  tiene resultado registrado.

## Preguntas que responde la base de datos

1. Cuales son todas las muestras con su formula, reactivo y tecnico.
2. Que muestras estan pendientes, en analisis o finalizadas.
3. Que reactivo se usa con mas frecuencia (ranking de uso).
4. Cuales son las muestras ordenadas por fecha, de la mas reciente a la
   mas antigua.
5. Que formula tiene mas muestras aprobadas (reporte para decision de
   negocio: en que formula seguir invirtiendo).
