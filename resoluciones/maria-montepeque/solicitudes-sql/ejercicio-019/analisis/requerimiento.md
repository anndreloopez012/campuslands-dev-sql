# Analisis del requerimiento - Ejercicio 019

## Solicitud entendida

Un estudio de diseno 3D de arquitectura registra clientes, renders, planos, revisiones y entregas. El cliente necesita guardar historico porque en auditorias le preguntan "que paso y cuando paso": no basta con saber el estado actual de un proyecto, necesita el registro cronologico de cada evento (boceto, render, plano tecnico, revision, entrega final).

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| proyectos | Es el catalogo de proyectos del estudio: que cliente lo pidio, que arquitecto lo lleva y su estado actual. | nombre_proyecto (unico), cliente, arquitecto_asignado, estado_actual |
| eventos | Es el historico/bitacora de auditoria: cada fila es un evento real ocurrido en un proyecto (boceto inicial, render 3D, plano tecnico, revision del cliente, entrega final), con su fecha exacta. Aqui vive directamente la respuesta a "que paso y cuando paso". | id_proyecto (FK), tipo_evento, fecha_evento, estado, comentario |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| proyectos -> eventos | 1:N | Un proyecto acumula muchos eventos en su historico, pero cada evento pertenece a un unico proyecto. |

## Reglas de negocio

- Regla 1: Todo evento debe pertenecer a un proyecto real (`FOREIGN KEY`).
- Regla 2: `tipo_evento` solo puede ser uno de los valores del flujo de trabajo del estudio (`CHECK`): `boceto_inicial`, `render_3d`, `plano_tecnico`, `revision_cliente`, `entrega_final`.
- Regla 3: `estado` de un evento puede ser `pendiente`, `aprobado` o `rechazado` (`CHECK`); esto es lo que se corrige con `UPDATE` cuando el comite aprueba un ajuste, sin borrar el evento original (el historico de auditoria no se toca).
- Regla 4: El nombre del proyecto no se repite (`UNIQUE`).

## Supuestos

- No se creo una tabla `clientes` ni `arquitectos` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el cliente y el arquitecto asignado se guardan como texto dentro de `proyectos`.
- Para efectos de auditoria, un evento en `eventos` NUNCA se borra una vez que representa algo que realmente ocurrio: solo se corrige su `estado` (de `rechazado` a `aprobado`, por ejemplo). La unica excepcion es una entrada de prueba que nunca fue un evento real.
- El estado por defecto de un evento nuevo es `pendiente`, porque asi entra normalmente un evento que todavia no se revisa.

## Preguntas que responde la base de datos

1. Que eventos del historico existen y en que estado quedo cada uno.
2. Que eventos siguen pendientes de revision.
3. Que proyecto tiene mas eventos registrados en su historico.
4. Como se ordena el historico cronologicamente (que paso y cuando paso).
5. Cual fue el ultimo evento registrado de cada proyecto, para saber en que quedo cada uno sin tener que revisar todo el historico.
