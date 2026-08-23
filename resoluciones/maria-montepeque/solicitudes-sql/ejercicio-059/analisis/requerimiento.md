# Analisis del requerimiento - Ejercicio 059

## Solicitud entendida

Un estudio maneja proyectos de animacion 3D, artistas, entregas y estados. El cliente necesita guardar historico porque en auditorias le preguntan que paso y cuando paso: por eso cada tarea guarda cuando fue su ultimo cambio de estado. Es nivel 3: se pide `DELETE` controlado.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Es el catalogo de clientes del estudio. | nombre_cliente (unico), email |
| artistas | Es el catalogo de artistas del estudio. | nombre_artista (unico), especialidad |
| proyectos | Es el catalogo de proyectos, cada uno de un cliente. | nombre_proyecto (unico), id_cliente (FK), fecha_inicio, estado |
| tareas | Es el registro transaccional de cada tarea asignada a un artista dentro de un proyecto. Aqui es donde el estudio corrige informacion y guarda el historico para auditorias. | id_proyecto (FK), id_artista (FK), descripcion, fecha_asignacion, estado, fecha_ultimo_cambio |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> proyectos | 1:N | Un cliente puede tener varios proyectos. |
| proyectos -> tareas | 1:N | Un proyecto tiene muchas tareas. |
| artistas -> tareas | 1:N | Un artista tiene muchas tareas asignadas. |

## Reglas de negocio

- Regla 1: Todo proyecto debe apuntar a un cliente real; toda tarea debe apuntar a un proyecto real y a un artista real (`FOREIGN KEY` en cadena).
- Regla 2: `email`, `especialidad`, `descripcion`, `fecha_inicio` y `fecha_asignacion` son `NOT NULL`.
- Regla 3: `nombre_cliente`, `nombre_proyecto` y `nombre_artista` no se repiten (`UNIQUE`).
- Regla 4: Un proyecto puede estar `en_desarrollo`, `revision`, `entregado` o `cancelado`, y una tarea puede estar `pendiente`, `en_progreso` o `completada` (`CHECK`); ambos se corrigen con `UPDATE`, y cada cambio de tarea actualiza `fecha_ultimo_cambio`, para poder responder "que paso y cuando paso" en una auditoria.
- Regla 5: Solo se permite `DELETE` de una tarea cuando esta `pendiente` **y** el proyecto al que pertenece esta `cancelado`. Una tarea `pendiente` de un proyecto activo, o una tarea que ya avanzo de estado, nunca se borra.

## Supuestos

- `fecha_ultimo_cambio` se guarda en la misma fila de la tarea (no en una tabla de historial aparte) porque el alcance de este nivel es 3 a 4 tablas; alcanza con saber cuando fue el cambio mas reciente.

## Preguntas que responde la base de datos

1. Que tareas existen, con que proyecto, que cliente y que artista.
2. Que tareas no estan completadas todavia.
3. Que artista tiene mas tareas asignadas.
4. Como se ordenan las tareas por fecha de asignacion.
5. Que tareas 'en_progreso' llevan mas tiempo sin actualizarse, para decidir cuales necesitan seguimiento urgente.
