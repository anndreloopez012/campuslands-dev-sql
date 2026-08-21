# Analisis del requerimiento - Ejercicio 039

## Solicitud entendida

Un taller automotriz controla diagnosticos, reparaciones, repuestos y garantias. El cliente necesita guardar historico porque en auditorias le preguntan que paso y cuando paso: por eso los estados se corrigen con `UPDATE` (guardando cuando cambio), no se borran registros de negocio.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Es el catalogo de clientes del taller. | nombre_cliente (unico), telefono |
| vehiculos | Es el catalogo de vehiculos que entran al taller; cada uno pertenece a un cliente (un cliente puede tener varios). | placa (unica), marca, modelo, id_cliente (FK) |
| diagnosticos | Es el registro transaccional de cada diagnostico/reparacion de un vehiculo: que se encontro, cuanto cuesta, en que estado va y cuando cambio de estado por ultima vez. Aqui es donde el taller necesita el historico para auditorias. | id_vehiculo (FK), fecha_diagnostico, descripcion, costo_reparacion, estado, garantia_meses, fecha_ultimo_cambio |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> vehiculos | 1:N | Un cliente puede tener varios vehiculos registrados. |
| vehiculos -> diagnosticos | 1:N | Un vehiculo puede tener muchos diagnosticos a lo largo del tiempo. |

## Reglas de negocio

- Regla 1: Todo vehiculo debe apuntar a un cliente real, y todo diagnostico debe apuntar a un vehiculo real (`FOREIGN KEY` en cadena).
- Regla 2: `telefono`, `marca`, `modelo` y `descripcion` son `NOT NULL`: son datos que, si faltaran, dejarian un registro de auditoria incompleto.
- Regla 3: `costo_reparacion` nunca puede ser negativo (`CHECK`).
- Regla 4: `garantia_meses` nunca puede ser negativo (`CHECK`).
- Regla 5: Un diagnostico puede estar `diagnosticado`, `en_reparacion`, `reparado` o `en_garantia` (`CHECK`); el taller corrige este estado con `UPDATE` y siempre registra `fecha_ultimo_cambio`, para poder responder "que paso y cuando paso" en una auditoria.
- Regla 6: `placa` y `nombre_cliente` no se repiten (`UNIQUE`).

## Supuestos

- `fecha_ultimo_cambio` se guarda en la misma fila del diagnostico (no en una tabla de historial aparte) porque el alcance de este nivel es relaciones basicas; alcanza con saber cuando fue el cambio de estado mas reciente. Una version mas avanzada necesitaria una tabla `historial_estados` para guardar cada cambio, no solo el ultimo.
- Solo se permite `DELETE` cuando el registro es un error de captura comprobado (por ejemplo un duplicado exacto). Cualquier cambio real del negocio (una reparacion que avanza, una garantia que se activa) se hace con `UPDATE`, para no perder el historico que pide el cliente.

## Preguntas que responde la base de datos

1. Que diagnosticos existen, con que vehiculo y que cliente.
2. Que diagnosticos no estan reparados todavia.
3. Que cliente tiene mas diagnosticos registrados en el taller.
4. Como se ordenan los diagnosticos por fecha.
5. Que reparaciones estan actualmente en garantia, para saber cuales estan cubiertas si el cliente regresa con la misma falla.
