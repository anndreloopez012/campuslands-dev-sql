# Evidencias - Solicitudes SQL - Ejercicio 009 (Estudio Animacion 3D)

## Comandos ejecutados

```bash
sqlite3 ejercicio-009.db < ddl/schema.sql
sqlite3 ejercicio-009.db < dml/inserts.sql
sqlite3 ejercicio-009.db < dml/operaciones.sql
sqlite3 ejercicio-009.db < dql/consultas.sql
```

## Resultados

**1. Historico completo (ya con la entrada de prueba eliminada y la correccion de iluminacion aprobada):**

```text
id_entrega | id_proyecto | tipo_evento     | fecha_evento       | estado    | comentario
1          | 1           | inicio           | 2026-06-01 09:00   | aprobado  | Kickoff aprobado por el cliente
2          | 1           | avance           | 2026-06-15 10:00   | aprobado  | Primer bloque de animacion aprobado
3          | 2           | inicio           | 2026-06-05 09:00   | aprobado  | Inicio de produccion del comercial
4          | 2           | revision         | 2026-07-01 11:00   | pendiente | En espera de feedback del cliente
5          | 3           | entrega_final    | 2026-07-10 15:00   | aprobado  | Corto entregado y aprobado
6          | 4           | inicio           | 2026-07-12 09:00   | aprobado  | Inicio de cinematica
7          | 4           | correccion       | 2026-07-20 14:00   | aprobado  | Cliente pidio cambios en iluminacion
8          | 5           | avance           | 2026-06-20 10:00   | pendiente | Proyecto pausado por el cliente
```

Quedan 8 eventos (empezaron 9, se elimino la entrada de prueba del `id_entrega = 9`).

**2. Eventos pendientes de revision:**

```text
id_entrega | id_proyecto | tipo_evento | fecha_evento
4          | 2           | revision     | 2026-07-01 11:00
8          | 5           | avance       | 2026-06-20 10:00
```

La correccion de iluminacion (id_entrega = 7) ya no aparece aqui porque `operaciones.sql` la aprobo.

**3. Proyecto con mas eventos en su historico:**

```text
nombre_proyecto                            | total_eventos
Serie Aventuras Espaciales                   | 2
Comercial Bebidas Frescas                    | 2
Videojuego Reinos Perdidos - cinematica      | 2
Cortometraje Bosque Encantado                | 1
Documental Vida Marina                       | 1
```

**4. Historico ordenado cronologicamente (que paso y cuando paso):** ver tabla completa arriba, de 2026-06-01 a 2026-07-20.

**5. Ultimo evento registrado por proyecto:**

```text
nombre_proyecto                            | tipo_evento     | fecha_evento       | estado
Comercial Bebidas Frescas                    | revision         | 2026-07-01 11:00   | pendiente
Cortometraje Bosque Encantado                | entrega_final    | 2026-07-10 15:00   | aprobado
Documental Vida Marina                       | avance           | 2026-06-20 10:00   | pendiente
Serie Aventuras Espaciales                   | avance           | 2026-06-15 10:00   | aprobado
Videojuego Reinos Perdidos - cinematica      | correccion       | 2026-07-20 14:00   | aprobado
```

Esta consulta responde exactamente lo que pide una auditoria: en un vistazo se ve en que quedo cada proyecto por ultima vez, sin tener que leer todo el historico.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO entregas (id_proyecto, tipo_evento, estado) VALUES (1, 'cancelacion', 'pendiente');` → `CHECK constraint failed: tipo_evento IN ('inicio', 'avance', 'revision', 'correccion', 'entrega_final')`.

## Operaciones de mantenimiento verificadas

- `UPDATE entregas SET estado = 'aprobado' WHERE id_entrega = 7 AND estado = 'rechazado';` → la correccion de iluminacion paso de `rechazado` a `aprobado`, sin alterar el evento original (mismo `tipo_evento`, misma `fecha_evento`).
- `UPDATE proyectos SET artista_asignado = 'Mario Paz' WHERE id_proyecto = 5;` → el documental cambio de artista asignado.
- `DELETE FROM entregas WHERE id_entrega = 9;` → la entrada de prueba desaparecio; el conteo final de eventos es 8, no 9.

## Aprendizaje

La necesidad de auditoria del cliente ("que paso y cuando paso") se resuelve tratando `entregas` como un historico casi inmutable: cada fila representa un evento que realmente ocurrio, con su `fecha_evento` fija para siempre. Cuando algo cambia de resultado (una correccion que se aprueba), se actualiza el `estado` de ESA MISMA fila con `UPDATE`, en vez de borrarla y crear una nueva; asi la auditoria conserva tanto el evento original como su resolucion, sin perder ningun dato. La unica fila que se elimina es la que nunca debio existir (la entrada de prueba), reforzando la regla: en un historico de auditoria, `DELETE` es la excepcion, no la norma.
