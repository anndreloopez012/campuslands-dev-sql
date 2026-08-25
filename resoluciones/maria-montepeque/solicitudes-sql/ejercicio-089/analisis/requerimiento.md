# Analisis del requerimiento - Ejercicio 089

## Solicitud entendida

Un taller automotriz controla diagnosticos, reparaciones, repuestos y
garantias. El cliente necesita guardar historico porque en auditorias
le preguntan que paso y cuando paso: por eso ningun diagnostico ni
reparacion se borra una vez registrado, solo se corrige el estado. Es
un nivel 5 (solicitud profesional): ademas del modelo, se pide
interpretar ambiguedad, normalizar datos, documentar decisiones y
crear al menos una vista SQL.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Catalogo: dueno del vehiculo | nombre_cliente, telefono (unico) |
| vehiculos | Catalogo: cada vehiculo que entra al taller | placa (unica), modelo |
| diagnosticos | Historico: cada revision inicial de un vehiculo | fecha_diagnostico, descripcion, gravedad |
| reparaciones | Historico: la reparacion que responde a un diagnostico especifico | fecha_reparacion, estado, costo_mano_obra |
| repuestos | Catalogo: cada repuesto disponible en el taller | nombre_repuesto (unico), precio_unitario |

Se agrego `detalle_repuestos` como tabla puente entre `reparaciones` y
`repuestos` (relacion muchos a muchos: una reparacion usa varios
repuestos, y un mismo repuesto se usa en varias reparaciones).

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> vehiculos | 1:N | Un cliente puede tener varios vehiculos. |
| vehiculos -> diagnosticos | 1:N | Un vehiculo puede tener varios diagnosticos a lo largo del tiempo. |
| diagnosticos -> reparaciones | 1:1 | Cada diagnostico tiene, como mucho, una reparacion oficial asociada. |
| reparaciones -> detalle_repuestos | 1:N | Una reparacion usa varios repuestos. |
| repuestos -> detalle_repuestos | 1:N | Un repuesto se usa en muchas reparaciones distintas. |

## Decisiones de modelado y ambiguedad interpretada

- **"Guardar historico para auditorias" (la peticion central del
  cliente):** `diagnosticos` y `reparaciones` nunca se borran; el
  `UNIQUE (id_diagnostico)` en `reparaciones` garantiza que un
  diagnostico tenga como maximo una reparacion oficial registrada, para
  que una auditoria nunca encuentre dos reparaciones contradictorias
  para el mismo problema.
- **Vista SQL:** se crea `vista_historial_vehiculo`, que junta
  diagnostico, reparacion, vehiculo y cliente en una sola consulta,
  respondiendo directamente "que paso y cuando paso" con cada
  vehiculo.
- **Ambiguedad no resuelta por el cliente:** no se detallo si aplica
  garantia sobre repuestos o sobre mano de obra. Se documenta como
  fuera del alcance de este nivel: el modelo registra costos, pero no
  un plazo de garantia.

## Reglas de negocio

- Regla 1 (relaciones invalidas): todo vehiculo debe apuntar a un
  cliente real; todo diagnostico debe apuntar a un vehiculo real; toda
  reparacion debe apuntar a un diagnostico real; todo detalle debe
  apuntar a una reparacion y a un repuesto reales (`FOREIGN KEY` en
  cadena).
- Regla 2 (registros repetidos): `clientes.telefono`,
  `vehiculos.placa` y `repuestos.nombre_repuesto` no se repiten
  (`UNIQUE`); un diagnostico no puede tener mas de una reparacion
  oficial (`UNIQUE (id_diagnostico)`); un repuesto no puede aparecer
  dos veces como linea separada en la misma reparacion
  (`UNIQUE (id_reparacion, id_repuesto)`).
- Regla 3 (valores fuera de rango): `reparaciones.costo_mano_obra`,
  `repuestos.precio_unitario` nunca negativos;
  `detalle_repuestos.cantidad` siempre mayor que 0 (`CHECK`).
- Regla 4: una reparacion nace `'pendiente'` y avanza a
  `'en_proceso'`, `'completada'` o `'cancelada'` (`CHECK`); se corrige
  con `UPDATE`.
- Regla 5: un repuesto se puede quitar de una reparacion con `DELETE`
  solo mientras la reparacion sigue `'pendiente'` o `'en_proceso'`
  (todavia no se entrega el vehiculo). Una vez `'completada'`, sus
  repuestos ya son parte del historico de auditoria y no se borran.

## Supuestos

- Se asume que el costo de mano de obra puede variar por reparacion
  (no es un precio fijo de catalogo), por eso vive en
  `reparaciones.costo_mano_obra`.
- No se detallo si un vehiculo puede cambiar de dueno; se asume que
  no, para el alcance de este nivel.

## Preguntas que responde la base de datos

1. Que paso con cada vehiculo (diagnostico y reparacion), via la
   vista `vista_historial_vehiculo`.
2. Que reparaciones estan pendientes, en proceso, completadas o
   canceladas.
3. Que vehiculo tiene mas diagnosticos (ranking de actividad).
4. Como se ordenan los diagnosticos por fecha.
5. Que clientes gastaron mas en total (mano de obra + repuestos),
   para decidir a quien ofrecer un programa de fidelidad.
