# Analisis del requerimiento - Ejercicio 070

## Solicitud entendida

Un taller de soldadura industrial controla ordenes de trabajo,
materiales usados, tecnicos asignados e inspecciones de calidad. El
cliente quiere detectar tres tipos de error: registros repetidos,
relaciones invalidas y valores fuera de rango. Ademas quiere poder
consultar datos, corregir estados, registrar movimientos y sacar
reportes utiles (no solo guardar texto).

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Catalogo: quien encarga cada orden de trabajo | nombre_cliente (unico), telefono (unico) |
| tecnicos | Catalogo: quien ejecuta el trabajo de soldadura | nombre_tecnico (unico), especialidad |
| ordenes | Tabla transaccional: trabajo de soldadura para un cliente, a cargo de un tecnico | descripcion, estado, fecha_orden |
| materiales | Detalle de la orden: cada material usado en un trabajo, con su costo | nombre_material, cantidad, costo_unitario |
| inspecciones | Historico de calidad: cada inspeccion de una orden se conserva con su fecha y resultado | resultado, fecha_inspeccion |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> ordenes | 1:N | Un cliente puede encargar varias ordenes de trabajo. |
| tecnicos -> ordenes | 1:N | Un tecnico puede tener asignadas varias ordenes. |
| ordenes -> materiales | 1:N | Una orden puede usar varios materiales distintos. |
| ordenes -> inspecciones | 1:N | Una orden puede pasar por varias inspecciones (la primera puede rechazar, y se vuelve a inspeccionar despues de corregir). |

## Reglas de negocio

Cada regla ataca uno de los tres errores que el cliente quiere
detectar:

- Regla 1 (relaciones invalidas): toda orden debe apuntar a un cliente
  y a un tecnico reales; todo material y toda inspeccion deben apuntar
  a una orden real (`FOREIGN KEY` en cadena).
- Regla 2 (registros repetidos): `nombre_cliente`, `telefono` y
  `nombre_tecnico` no se repiten (`UNIQUE`).
- Regla 3 (valores fuera de rango): `materiales.cantidad` debe ser
  mayor que 0 y `materiales.costo_unitario` no puede ser negativo
  (`CHECK`).
- Regla 4: `ordenes.estado` solo puede ser `pendiente`, `en_proceso`,
  `finalizada` o `cancelada` (`CHECK`); se corrige con `UPDATE`.
- Regla 5: `inspecciones.resultado` solo puede ser `aprobada`,
  `rechazada` o `pendiente` (`CHECK`).
- Regla 6: Solo se permite `DELETE` de un material cuando es un
  registro duplicado por error de captura y la orden todavia no fue
  inspeccionada; nunca se borra un material de una orden ya
  inspeccionada, porque cambiaria el costo que ya se audito.

## Supuestos

- El cliente no detallo si el costo de la orden se calcula
  automaticamente; se asume que el costo total de una orden es la suma
  de `cantidad * costo_unitario` de sus materiales, y se responde con
  una consulta (no se guarda como columna redundante).
- No se detallo si un tecnico puede tener varias especialidades; se
  asume una especialidad principal por tecnico para el alcance de este
  modelo.
- Se asume que una orden `cancelada` puede seguir teniendo materiales e
  inspecciones en su historico (no se elimina nada al cancelarla, solo
  cambia su estado).

## Preguntas que responde la base de datos

1. Que ordenes existen, con que cliente y que tecnico.
2. Que ordenes estan pendientes, en proceso, finalizadas o canceladas.
3. Que tecnico tiene mas ordenes asignadas (ranking de actividad).
4. Como se ordenan los materiales por costo total (cantidad x costo
   unitario).
5. Que ordenes tienen inspecciones rechazadas, para saber cuales
   necesitan corregirse antes de entregarse al cliente.
