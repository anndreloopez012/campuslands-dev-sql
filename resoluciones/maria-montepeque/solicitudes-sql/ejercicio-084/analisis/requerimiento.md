# Analisis del requerimiento - Ejercicio 084

## Solicitud entendida

Un estudio de animacion 3D maneja proyectos, artistas, tareas y
entregas. El cliente necesita un reporte rapido para tomar decisiones
al final de cada semana: eso se traduce en que las entregas del
estudio deben registrarse por semana, para poder consultar de un
vistazo el avance semanal de cada proyecto. Es un nivel 5 (solicitud
profesional): ademas del modelo, se pide interpretar ambiguedad,
normalizar datos, documentar decisiones y crear al menos una vista
SQL.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Catalogo: cada cliente que encarga un proyecto | nombre_cliente, telefono (unico) |
| artistas | Catalogo: cada artista del estudio | nombre_artista (unico), especialidad |
| proyectos | Tabla transaccional: cada proyecto de animacion | nombre_proyecto, fecha_inicio, estado |
| tareas | Detalle: trabajo especifico de un artista en un proyecto, en una fecha | descripcion, horas_trabajadas |
| entregas | Resultado semanal: checkpoint de avance de un proyecto, uno por semana | semana, fecha_entrega, aprobada |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> proyectos | 1:N | Un cliente puede encargar varios proyectos. |
| proyectos -> tareas | 1:N | Un proyecto tiene muchas tareas de distintos artistas. |
| artistas -> tareas | 1:N | Un artista trabaja en muchas tareas distintas. |
| proyectos -> entregas | 1:N | Un proyecto tiene una entrega (checkpoint) por semana. |

## Decisiones de modelado y ambiguedad interpretada

- **"Reporte rapido al final de cada semana":** se interpreto como la
  necesidad de un checkpoint semanal por proyecto, no solo un estado
  general. Por eso `entregas.semana` existe como columna propia, con
  `UNIQUE (id_proyecto, semana)`: cada proyecto tiene, como maximo, un
  checkpoint oficial por semana, evitando reportes semanales
  duplicados o contradictorios.
- **Normalizacion:** las horas trabajadas se registran por tarea
  individual (`tareas.horas_trabajadas`), no como un total acumulado
  en `proyectos`, para poder sumar y filtrar por artista, por
  proyecto o por semana segun lo que necesite el reporte.
- **Vista SQL:** se crea `vista_reporte_semanal`, que junta entregas,
  proyecto y cliente en una sola consulta. Responde directamente la
  pregunta que trajo el cliente: "que paso esta semana en cada
  proyecto".
- **Ambiguedad no resuelta por el cliente:** no se detallo si una
  tarea puede registrarse fuera de la semana de su entrega
  correspondiente (por ejemplo, trabajo atrasado). Se documenta como
  supuesto: las tareas se registran con su propia fecha
  (`tareas.fecha_tarea`), independiente de a que entrega semanal
  terminen aportando; no se fuerza una relacion directa entre tarea y
  entrega en este nivel.

## Reglas de negocio

- Regla 1 (relaciones invalidas): todo proyecto debe apuntar a un
  cliente real; toda tarea debe apuntar a un proyecto y a un artista
  reales; toda entrega debe apuntar a un proyecto real
  (`FOREIGN KEY` en cadena).
- Regla 2 (registros repetidos): `clientes.telefono` y
  `artistas.nombre_artista` no se repiten (`UNIQUE`); una entrega
  semanal no se registra dos veces para el mismo proyecto
  (`UNIQUE (id_proyecto, semana)`).
- Regla 3 (valores fuera de rango): `tareas.horas_trabajadas` nunca
  negativas; `entregas.semana` siempre 1 o mayor (`CHECK`).
- Regla 4: un proyecto nace `'en_curso'` y avanza a `'pausado'`,
  `'finalizado'` o `'cancelado'` (`CHECK`); una entrega nace sin
  aprobar (`aprobada = 0`) y se corrige a aprobada con `UPDATE` cuando
  el cliente la revisa y la acepta.
- Regla 5: una tarea se puede eliminar con `DELETE` solo cuando fue un
  error de captura confirmado (por ejemplo, trabajo registrado para un
  alcance que el cliente cancelo). El historico real de tareas no se
  borra.

## Supuestos

- El cliente no detallo si un artista puede trabajar en varios
  proyectos a la vez; se asume que si.
- No se detallo un limite de horas por semana; se asume que ese
  control queda fuera del alcance de este nivel.

## Preguntas que responde la base de datos

1. Que paso cada semana en cada proyecto (via la vista
   `vista_reporte_semanal`).
2. Que proyectos estan en curso, pausados, finalizados o cancelados.
3. Que artista tiene mas horas trabajadas (ranking de actividad).
4. Como se ordenan las tareas por fecha.
5. Que proyecto acumulo mas horas de trabajo, para decidir donde
   reforzar el equipo.
