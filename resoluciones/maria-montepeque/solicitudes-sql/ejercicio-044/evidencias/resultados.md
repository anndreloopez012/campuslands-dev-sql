# Evidencias - Solicitudes SQL - Ejercicio 044 (Diseno 3D Arquitectura)

## Comandos ejecutados

```bash
sqlite3 ejercicio-044.db < ddl/schema.sql
sqlite3 ejercicio-044.db < dml/inserts.sql
sqlite3 ejercicio-044.db < dml/operaciones.sql
sqlite3 ejercicio-044.db < dql/consultas.sql
```

## Resultados

**1. Todos los renders, con JOIN a proyectos y clientes (ya sin el duplicado, sin la prueba borrada, con Vista Aerea Lotes aprobada y Fachada Plaza Pacifico en revision):**

```text
id_render | nombre_cliente             | nombre_proyecto              | nombre_render               | fecha_entrega_estimada | estado
1          | Constructora Ceibal        | Torre Ceibal Fase 1           | Fachada Principal            | 2026-08-05               | aprobado
2          | Grupo Inmobiliario Norte   | Residencial Norte Lotes A     | Vista Aerea Lotes             | 2026-08-06               | aprobado
3          | Desarrollos Pacifico       | Plaza Pacifico                 | Interior Plaza Nivel 1        | 2026-08-08               | en_proceso
4          | Residencial Las Flores     | Casas Las Flores Modelo B      | Fachada Modelo B              | 2026-08-04               | aprobado
5          | Constructora Ceibal        | Torre Ceibal Fase 1           | Interior Torre - Piso 10      | 2026-08-10               | en_revision
6          | Torre Central S.A.         | Torre Central Lobby            | Lobby Render Nocturno         | 2026-08-07               | rechazado
7          | Constructora Ceibal        | Torre Ceibal Fase 2           | Fachada Fase 2                | 2026-08-12               | en_proceso
8          | Grupo Inmobiliario Norte   | Residencial Norte Lotes A     | Vista Nocturna Lotes          | 2026-08-09               | aprobado
9          | Desarrollos Pacifico       | Plaza Pacifico                 | Fachada Plaza Pacifico        | 2026-08-11               | en_revision
```

Quedan 9 renders (empezaron 11: se elimino el duplicado `id_render = 11` y la prueba sin revisiones `id_render = 10`).

**2. Renders que no estan aprobados todavia:**

```text
id_render | id_proyecto | fecha_entrega_estimada | estado
3          | 3           | 2026-08-08               | en_proceso
5          | 1           | 2026-08-10               | en_revision
6          | 5           | 2026-08-07               | rechazado
7          | 6           | 2026-08-12               | en_proceso
9          | 3           | 2026-08-11               | en_revision
```

**3. Cliente con mas renders en el estudio:**

```text
nombre_cliente             | total_renders
Constructora Ceibal        | 3
Desarrollos Pacifico       | 2
Grupo Inmobiliario Norte   | 2
Residencial Las Flores     | 1
Torre Central S.A.         | 1
```

**4. Renders ordenados por fecha de entrega estimada:** ver tabla completa arriba, de 2026-08-04 a 2026-08-12.

**5. Reporte semanal: renders sin aprobar, ordenados por urgencia (fecha mas cercana primero), para decidir en que enfocarse esta semana:**

```text
nombre_cliente             | nombre_proyecto        | nombre_render               | fecha_entrega_estimada | estado
Torre Central S.A.         | Torre Central Lobby     | Lobby Render Nocturno        | 2026-08-07               | rechazado
Desarrollos Pacifico       | Plaza Pacifico           | Interior Plaza Nivel 1       | 2026-08-08               | en_proceso
Constructora Ceibal        | Torre Ceibal Fase 1     | Interior Torre - Piso 10     | 2026-08-10               | en_revision
Desarrollos Pacifico       | Plaza Pacifico           | Fachada Plaza Pacifico       | 2026-08-11               | en_revision
Constructora Ceibal        | Torre Ceibal Fase 2     | Fachada Fase 2               | 2026-08-12               | en_proceso
```

El render rechazado de Torre Central S.A. es el mas urgente de resolver esta semana (fecha mas antigua entre los pendientes).

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- Registro repetido: `INSERT INTO proyectos (nombre_proyecto, ...) VALUES ('Plaza Pacifico', ...);` → `UNIQUE constraint failed: proyectos.nombre_proyecto`.
- Valor fuera de rango: `INSERT INTO renders (..., estado) VALUES (..., 'cancelado');` → `CHECK constraint failed: estado IN ('en_proceso', 'en_revision', 'aprobado', 'rechazado')`.

## Operaciones de mantenimiento verificadas

- `UPDATE renders SET estado = 'aprobado' WHERE id_render = 2 AND estado = 'en_revision';` → Vista Aerea Lotes quedo aprobada tras la segunda revision.
- `UPDATE renders SET estado = 'en_revision' WHERE id_render = 9 AND estado = 'en_proceso';` → Fachada Plaza Pacifico se envio a revision.
- `DELETE FROM renders WHERE id_render = 10 AND estado = 'en_proceso' AND NOT EXISTS (...);` → **DELETE controlado**: elimino unicamente la prueba (render 10), porque estaba `en_proceso` y no tenia ninguna revision. Ningun otro render `en_proceso` (como el 3 o el 7, que si podrian tener revisiones en otro escenario) se hubiera visto afectado.
- `DELETE FROM renders WHERE id_render = 11;` → el render duplicado desaparecio. Conteo final verificado: 9 renders (empezaron 11).

## Aprendizaje

El reporte semanal que pidio el cliente (consulta 5) no necesita logica adicional: es la misma pregunta de "que no esta aprobado" pero ordenada por urgencia. El `DELETE` controlado protege el historial de revisiones exigiendo `NOT EXISTS`: un render que ya paso por al menos una revision jamas se borra, sin importar en que estado quede despues, porque ya es parte del historial que el cliente necesita para sus decisiones.
