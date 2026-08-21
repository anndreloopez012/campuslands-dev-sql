# Evidencias - Solicitudes SQL - Ejercicio 019 (Diseno 3D Arquitectura)

## Comandos ejecutados

```bash
sqlite3 ejercicio-019.db < ddl/schema.sql
sqlite3 ejercicio-019.db < dml/inserts.sql
sqlite3 ejercicio-019.db < dml/operaciones.sql
sqlite3 ejercicio-019.db < dql/consultas.sql
```

## Resultados

**1. Historico completo (ya con la entrada de prueba eliminada y el ajuste de accesos aprobado):**

```text
id_evento | id_proyecto | tipo_evento         | fecha_evento       | estado    | comentario
1         | 1           | boceto_inicial        | 2026-06-01 09:00   | aprobado  | Boceto aprobado por la familia Lopez
2         | 1           | render_3d             | 2026-06-15 10:00   | aprobado  | Render exterior aprobado
3         | 2           | boceto_inicial        | 2026-06-05 09:00   | aprobado  | Concepto inicial aprobado
4         | 2           | revision_cliente      | 2026-07-01 11:00   | pendiente | En espera de comentarios del comite
5         | 3           | entrega_final         | 2026-07-10 15:00   | aprobado  | Remodelacion entregada y aprobada
6         | 4           | boceto_inicial        | 2026-07-12 09:00   | aprobado  | Inicio de diseno del centro comercial
7         | 4           | plano_tecnico         | 2026-07-20 14:00   | aprobado  | Comite pidio ajustar accesos vehiculares
8         | 5           | render_3d             | 2026-06-20 10:00   | pendiente | Render de fachada en revision
```

Quedan 8 eventos (empezaron 9, se elimino la entrada de prueba del `id_evento = 9`).

**2. Eventos pendientes de revision:**

```text
id_evento | id_proyecto | tipo_evento       | fecha_evento
4         | 2           | revision_cliente    | 2026-07-01 11:00
8         | 5           | render_3d           | 2026-06-20 10:00
```

El evento del plano tecnico (id_evento = 7) ya no aparece aqui porque `operaciones.sql` lo aprobo.

**3. Proyecto con mas eventos en su historico:**

```text
nombre_proyecto              | total_eventos
Residencia Vista Verde         | 2
Torre Corporativa Meridiano    | 2
Centro Comercial Norte          | 2
Remodelacion Cafe Central       | 1
Casa de Playa Azul              | 1
```

**4. Historico ordenado cronologicamente (que paso y cuando paso):** ver tabla completa arriba, de 2026-06-01 a 2026-07-20.

**5. Ultimo evento registrado por proyecto:**

```text
nombre_proyecto              | tipo_evento         | fecha_evento       | estado
Casa de Playa Azul              | render_3d             | 2026-06-20 10:00   | pendiente
Centro Comercial Norte          | plano_tecnico         | 2026-07-20 14:00   | aprobado
Remodelacion Cafe Central       | entrega_final         | 2026-07-10 15:00   | aprobado
Residencia Vista Verde          | render_3d             | 2026-06-15 10:00   | aprobado
Torre Corporativa Meridiano     | revision_cliente      | 2026-07-01 11:00   | pendiente
```

Esta consulta responde exactamente lo que pide una auditoria: en un vistazo se ve en que quedo cada proyecto por ultima vez.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO eventos (id_proyecto, tipo_evento, estado) VALUES (1, 'demolicion', 'pendiente');` → `CHECK constraint failed: tipo_evento IN ('boceto_inicial', 'render_3d', 'plano_tecnico', 'revision_cliente', 'entrega_final')`.

## Operaciones de mantenimiento verificadas

- `UPDATE eventos SET estado = 'aprobado' WHERE id_evento = 7 AND estado = 'rechazado';` → el ajuste de accesos vehiculares paso de `rechazado` a `aprobado`, sin alterar el evento original (mismo `tipo_evento`, misma `fecha_evento`).
- `UPDATE proyectos SET arquitecto_asignado = 'Julio Perez' WHERE id_proyecto = 5;` → la casa de playa cambio de arquitecto asignado.
- `DELETE FROM eventos WHERE id_evento = 9;` → la entrada de prueba desaparecio; el conteo final es 8, no 9.

## Aprendizaje

Este ejercicio reforzo la misma leccion del historico de auditoria (ya vista en el estudio de animacion 3D) en un dominio distinto: cuando un evento cambia de resultado (un plano que se rechaza y despues se aprueba tras un ajuste), se corrige el `estado` de ESA fila con `UPDATE`, nunca se crea una fila nueva ni se borra la anterior. Esto conserva tanto el hecho de que hubo un rechazo como su resolucion posterior, que es precisamente lo que una auditoria necesita saber: no solo el resultado final, sino el camino que se siguio para llegar ahi.
