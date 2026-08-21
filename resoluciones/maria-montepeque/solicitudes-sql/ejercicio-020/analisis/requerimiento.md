# Analisis del requerimiento - Ejercicio 020

## Solicitud entendida

Un taller de soldadura industrial controla ordenes de trabajo, materiales, tecnicos, inspecciones y costos. El cliente pidio explicitamente poder detectar errores: registros repetidos, relaciones invalidas o valores fuera de rango.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| tecnicos | Es el catalogo de soldadores certificados del taller, con su nivel de certificacion y anios de experiencia. | nombre_tecnico (unico), certificacion, anios_experiencia |
| ordenes | Es el registro transaccional de cada trabajo de soldadura: quien lo hizo, que se hizo, cuanto costo y en que estado va (en proceso, inspeccionada, aprobada, rechazada). | id_tecnico (FK), codigo_orden, descripcion, costo, fecha_orden, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| tecnicos -> ordenes | 1:N | Un tecnico puede tener muchas ordenes de trabajo a lo largo del tiempo, pero cada orden es de un unico tecnico. |

## Reglas de negocio

- Regla 1: Toda orden debe apuntar a un tecnico real del catalogo (`FOREIGN KEY`); esto evita directamente la "relacion invalida" que preocupa al cliente.
- Regla 2: `anios_experiencia` debe estar en un rango realista (`CHECK BETWEEN 0 AND 50`); esto detecta el "valor fuera de rango" que menciona el cliente.
- Regla 3: `nombre_tecnico` y `codigo_orden` no se repiten (`UNIQUE`); esto evita el "registro repetido" que preocupa al cliente (cargar el mismo tecnico o la misma orden dos veces).
- Regla 4: `costo` siempre debe ser mayor a cero (`CHECK`).
- Regla 5: Una orden puede estar `en_proceso`, `inspeccionada`, `aprobada` o `rechazada` (`CHECK`); el taller necesita poder corregir este estado a medida que avanza el trabajo.

## Supuestos

- No se creo una tabla `clientes` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el modelo se centra en `tecnicos` y `ordenes`.
- No se separaron `materiales` en una tabla propia en este nivel; se asume que el `costo` de la orden ya incluye materiales y mano de obra.

## Preguntas que responde la base de datos

1. Que ordenes existen y en que estado quedo cada una.
2. Que ordenes no estan aprobadas todavia.
3. Que tecnico tiene mas ordenes.
4. Como se ordenan las ordenes por fecha.
5. Cuanto genera cada tecnico en costo total (sin ordenes rechazadas), para decisiones de carga de trabajo.
