# Analisis del requerimiento - Ejercicio 088

## Solicitud entendida

Un estudio de tatuajes agenda sesiones con distintos artistas y
estilos. El cliente quiere consultar rankings, totales y casos
pendientes desde la base de datos: eso significa que el modelo debe
poder mostrar directamente quien es el artista mas activo (ranking),
cuanto se ha cobrado en total (totales), y que sesiones todavia no se
han realizado (casos pendientes). Es un nivel 5 (solicitud
profesional): ademas del modelo, se pide interpretar ambiguedad,
normalizar datos, documentar decisiones y crear al menos una vista
SQL.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Catalogo: cada cliente que agenda una sesion | nombre_cliente, telefono (unico) |
| artistas | Catalogo: cada tatuador del estudio | nombre_artista (unico), especialidad |
| estilos | Catalogo: cada estilo de tatuaje disponible | nombre_estilo (unico), dificultad |
| sesiones | Tabla transaccional: cada cita agendada | fecha_sesion, duracion_horas, estado |
| pagos | Resultado: el pago de una sesion, uno por sesion | monto, metodo_pago |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> sesiones | 1:N | Un cliente puede tener varias sesiones. |
| artistas -> sesiones | 1:N | Un artista atiende muchas sesiones. |
| estilos -> sesiones | 1:N | Un estilo se usa en muchas sesiones distintas. |
| sesiones -> pagos | 1:1 | Cada sesion tiene, como mucho, un pago oficial. |

## Decisiones de modelado y ambiguedad interpretada

- **"Rankings, totales y casos pendientes" (la peticion central del
  cliente):** se traduce directamente en tres tipos de consulta:
  ranking de artistas por actividad (`ORDER BY` + `LIMIT`), totales de
  ingresos por artista (`GROUP BY` + `HAVING`), y casos pendientes
  como las sesiones en estado `'programada'`.
- **Vista SQL:** se crea `vista_resumen_sesiones`, que junta sesion,
  cliente, artista, estilo y pago (si existe) con `LEFT JOIN`,
  sirviendo de base para todos esos reportes sin repetir el `JOIN`
  cada vez.
- **Ambiguedad no resuelta por el cliente:** no se detallo si el
  precio depende de la dificultad del estilo o de la duracion de la
  sesion. Se documenta como supuesto: el monto se negocia por sesion y
  se guarda en `pagos.monto`, sin una formula automatica basada en
  `estilos.dificultad` o `sesiones.duracion_horas`.

## Reglas de negocio

- Regla 1 (relaciones invalidas): toda sesion debe apuntar a un
  cliente, un artista y un estilo reales; todo pago debe apuntar a una
  sesion real (`FOREIGN KEY` en cadena).
- Regla 2 (registros repetidos): `clientes.telefono`,
  `artistas.nombre_artista` y `estilos.nombre_estilo` no se repiten
  (`UNIQUE`); una sesion no puede tener mas de un pago
  (`UNIQUE (id_sesion)` en `pagos`).
- Regla 3 (valores fuera de rango): `sesiones.duracion_horas` siempre
  mayor que 0; `pagos.monto` nunca negativo (`CHECK`).
- Regla 4: una sesion nace `'programada'` (caso pendiente) y avanza a
  `'en_curso'`, `'finalizada'` o `'cancelada'` (`CHECK`); se corrige
  con `UPDATE`.
- Regla 5: un pago se elimina con `DELETE` solo cuando la sesion a la
  que pertenece se cancela y ese pago resulto ser un error (se
  proceso el cobro de una sesion que en realidad se pospuso). Un pago
  de una sesion `'finalizada'` nunca se borra.

## Supuestos

- Se asume que un cliente puede tener varias sesiones con artistas
  distintos, sin restriccion.
- No se detallo un limite de sesiones por dia por artista; se asume
  que ese control queda fuera del alcance de este nivel.

## Preguntas que responde la base de datos

1. Que sesiones existen, con su cliente, artista, estilo y pago (via
   la vista `vista_resumen_sesiones`).
2. Que sesiones estan programadas (casos pendientes), en curso,
   finalizadas o canceladas.
3. Que artista tiene mas sesiones (ranking de actividad).
4. Como se ordenan las sesiones por fecha y duracion.
5. Que artista genero mas ingresos en total, para decidir a quien
   asignar mas horarios.
