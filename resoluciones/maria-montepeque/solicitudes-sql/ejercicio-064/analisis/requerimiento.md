# Analisis del requerimiento - Ejercicio 064

## Solicitud entendida

Un taller automotriz controla diagnosticos, reparaciones, repuestos y
garantias de forma manual, y necesita un reporte rapido cada semana para
tomar decisiones (por ejemplo, cuanto se ha facturado o que vehiculo
requiere mas atencion). Se necesita una base de datos que permita
consultar datos, corregir el estado de un diagnostico, registrar
movimientos (reparaciones y repuestos usados) y generar ese reporte
semanal.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Dueno del vehiculo; se repite en varios vehiculos | nombre, telefono (unico) |
| vehiculos | Pertenece a un cliente; se repite en varios diagnosticos | placa (unica), marca, modelo |
| diagnosticos | Tabla transaccional: revision inicial de un vehiculo | fecha_diagnostico, descripcion, estado |
| reparaciones | Trabajo realizado a partir de un diagnostico; se separa porque tiene su propio costo de mano de obra | descripcion_trabajo, costo_mano_obra, fecha_reparacion |
| repuestos | Piezas usadas en una reparacion; una reparacion puede usar varios repuestos, cada uno con su propio precio | nombre, cantidad, precio_unitario |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> vehiculos | 1:N | Un cliente puede tener varios vehiculos, cada vehiculo es de un solo cliente. |
| vehiculos -> diagnosticos | 1:N | Un vehiculo puede tener varios diagnosticos a lo largo del tiempo. |
| diagnosticos -> reparaciones | 1:1 | Cada diagnostico deriva en, a lo sumo, una orden de reparacion (`UNIQUE (id_diagnostico)`). |
| reparaciones -> repuestos | 1:N | Una reparacion puede usar varios repuestos distintos. |

## Reglas de negocio

- Regla 1: un diagnostico nace `'pendiente'` y solo puede avanzar a
  `'en_reparacion'` o `'finalizado'` (`CHECK`).
- Regla 2: el costo de mano de obra y el precio de cada repuesto deben
  ser mayores a cero (`CHECK`).
- Regla 3: la placa del vehiculo no se puede repetir (`UNIQUE`), para
  evitar registrar el mismo vehiculo dos veces con datos distintos.
- Regla 4: cada diagnostico genera como maximo una reparacion
  (`UNIQUE (id_diagnostico)` en `reparaciones`).

## Supuestos

- El cliente (dueno del taller) no especifico si un vehiculo puede
  pertenecer a mas de un cliente (por ejemplo, un vehiculo vendido); se
  asume que cada vehiculo tiene un unico dueno registrado en el alcance
  de este modelo.
- No se detallo el manejo de garantias como tabla independiente; se
  asume que la garantia se cubre documentando el estado del diagnostico
  y no se modela como una tabla propia para no exceder el alcance de
  4 a 5 tablas.
- Se asume que un diagnostico sin reparacion asociada todavia no se ha
  atendido (solo existe el registro del problema reportado).

## Preguntas que responde la base de datos

1. Cuales son todos los diagnosticos con su vehiculo y cliente.
2. Que diagnosticos estan pendientes, en reparacion o finalizados.
3. Que vehiculo tiene mas actividad (ranking por numero de
   diagnosticos).
4. Cuales son los diagnosticos ordenados por fecha, del mas reciente al
   mas antiguo.
5. Cuanto se factura por cliente en la semana (mano de obra + repuestos)
   y que clientes superan un monto minimo (reporte semanal para decision
   de negocio).
