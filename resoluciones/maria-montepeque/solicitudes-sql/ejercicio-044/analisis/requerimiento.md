# Analisis del requerimiento - Ejercicio 044

## Solicitud entendida

Un estudio de diseno 3D para arquitectura registra clientes, renders, planos, revisiones y entregas. El cliente necesita un reporte rapido para tomar decisiones al final de cada semana. Es nivel 3: ademas de corregir estados con `UPDATE`, se pide `DELETE` controlado con criterios de negocio reales.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Es el catalogo de clientes del estudio. | nombre_cliente (unico), email (unico) |
| proyectos | Es el catalogo de proyectos, cada uno de un cliente. | nombre_proyecto (unico), id_cliente (FK), fecha_inicio |
| renders | Es el registro transaccional de cada render/plano que se produce para un proyecto: su nombre, cuando se debe entregar y en que estado va. | id_proyecto (FK), nombre_render, fecha_entrega_estimada, estado |
| revisiones | Es el historial de revisiones que recibe un render: comentario del cliente y si se aprobo o se pidieron cambios. | id_render (FK), fecha_revision, comentario, resultado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> proyectos | 1:N | Un cliente puede tener varios proyectos. |
| proyectos -> renders | 1:N | Un proyecto puede tener muchos renders. |
| renders -> revisiones | 1:N | Un render puede tener varias revisiones a lo largo del tiempo. |

## Reglas de negocio

- Regla 1: Todo proyecto debe apuntar a un cliente real, todo render a un proyecto real, y toda revision a un render real (`FOREIGN KEY` en cadena de 4 tablas).
- Regla 2: `email`, `fecha_inicio`, `nombre_render`, `fecha_entrega_estimada` y `comentario` son `NOT NULL`.
- Regla 3: Un render puede estar `en_proceso`, `en_revision`, `aprobado` o `rechazado` (`CHECK`); el estudio corrige este estado con `UPDATE` a medida que avanza el trabajo.
- Regla 4: El `resultado` de una revision solo puede ser `aprobado` o `cambios_solicitados` (`CHECK`).
- Regla 5: `nombre_cliente`, `email` y `nombre_proyecto` no se repiten (`UNIQUE`).
- Regla 6: Solo se permite `DELETE` de un render cuando esta `en_proceso` **y** no tiene ninguna revision registrada todavia. Un render que ya se envio a revision (aunque sea una sola vez) no se borra: pasa a formar parte del historial que el cliente pidio poder consultar.

## Supuestos

- "Planos" y "entregas", mencionados en el contexto, se resolvieron dentro de `renders`: un plano es, para efectos de este sistema, otro tipo de render, y una entrega es simplemente un render en estado `aprobado`. El alcance de este nivel es 3 a 4 tablas.
- El reporte semanal que pide el cliente se resuelve consultando los renders que todavia no estan `aprobado`, ordenados por su fecha de entrega estimada: eso es exactamente en que hay que enfocarse esa semana.

## Preguntas que responde la base de datos

1. Que renders existen, con que proyecto y que cliente.
2. Que renders no estan aprobados todavia.
3. Que cliente tiene mas renders en el estudio.
4. Como se ordenan los renders por fecha de entrega estimada.
5. Que renders sin aprobar hay que priorizar esta semana, ordenados por la fecha mas urgente primero (el reporte semanal que pidio el cliente).
