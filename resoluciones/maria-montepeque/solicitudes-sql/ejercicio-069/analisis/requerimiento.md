# Analisis del requerimiento - Ejercicio 069

## Solicitud entendida

Un estudio de diseno 3D de arquitectura registra clientes, proyectos,
renders, revisiones y entregas. El cliente necesita guardar historico
porque en auditorias le preguntan que paso y cuando paso: por eso el
modelo no debe borrar informacion de proceso (revisiones), sino
conservarla con su fecha y su resultado. Se necesita una base de datos
que permita consultar datos, corregir estados, registrar movimientos y
sacar reportes, por ejemplo saber que proyecto requirio mas revisiones.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Catalogo: quien contrata el proyecto | nombre, telefono (unico) |
| proyectos | Catalogo/operacion: proyecto de diseno para un cliente | nombre, tipo, fecha_inicio |
| renders | Tabla transaccional: imagen o render generado para un proyecto | nombre_archivo, fecha_creacion, estado |
| revisiones | Historico de auditoria: cada revision de un render se conserva, no se borra | comentario, fecha_revision, aprobado |
| entregas | Movimiento: version del proyecto entregada formalmente al cliente | fecha_entrega, version |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> proyectos | 1:N | Un cliente puede tener varios proyectos. |
| proyectos -> renders | 1:N | Un proyecto puede generar varios renders. |
| renders -> revisiones | 1:N | Un render puede tener varias revisiones a lo largo del tiempo (esto es el historico que pide el cliente). |
| proyectos -> entregas | 1:N | Un proyecto puede tener varias entregas formales (version 1, version 2, etc.). |

## Reglas de negocio

- Regla 1: para conservar el historico de auditoria, una revision
  **nunca se elimina**; si una revision fue un error de captura real,
  se corrige con `UPDATE`, no con `DELETE`. El unico `DELETE` permitido
  en este modelo es sobre un render que se creo por error y todavia no
  tiene ninguna revision asociada.
- Regla 2: un render nace `'en_proceso'` y solo puede avanzar a
  `'terminado'` o `'descartado'` (`CHECK`).
- Regla 3: `revisiones.aprobado` es una bandera (0 o 1) que registra si
  esa revision especifica aprobo el render en ese momento (`CHECK`).
- Regla 4: el tipo de proyecto debe ser uno de los reconocidos por el
  estudio (`CHECK (tipo IN ('residencial', 'comercial', 'institucional'))`).
- Regla 5: el telefono de un cliente no se puede repetir (`UNIQUE`).

## Supuestos

- El cliente no especifico si una entrega incluye varios renders a la
  vez; se asume que `entregas` registra la version formal entregada del
  proyecto en su conjunto, no render por render.
- No se detallo quien hace cada revision; se asume que ese dato no es
  indispensable para el alcance de este modelo (podria agregarse una
  tabla `revisores` en una version futura).
- Se asume que un render `'descartado'` puede seguir teniendo
  revisiones en su historico (no se elimina su historial aunque el
  render ya no se use).

## Preguntas que responde la base de datos

1. Cuales son todos los renders con su proyecto y cliente.
2. Que renders estan en proceso, terminados o descartados.
3. Que proyecto tiene mas actividad (ranking por numero de revisiones,
   el historico de auditoria).
4. Cuales son las revisiones ordenadas por fecha, de la mas reciente a
   la mas antigua.
5. Que proyectos tienen mas renders aprobados en su ultima revision
   (reporte para decision de negocio: que proyectos estan listos para
   entrega).
