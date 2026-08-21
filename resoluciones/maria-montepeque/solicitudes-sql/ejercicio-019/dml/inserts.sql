PRAGMA foreign_keys = ON;

-- Ejercicio 019: Diseno 3D Arquitectura
-- Datos de prueba.

INSERT INTO proyectos (nombre_proyecto, cliente, arquitecto_asignado, estado_actual) VALUES
    ('Residencia Vista Verde', 'Familia Lopez', 'Karla Diaz', 'en_diseno'),
    ('Torre Corporativa Meridiano', 'Grupo Meridiano SA', 'Julio Perez', 'en_revision'),
    ('Remodelacion Cafe Central', 'Cafe Central', 'Ingrid Say', 'entregado'),
    ('Centro Comercial Norte', 'Inversiones Norte', 'Mario Ixtabalan', 'en_diseno'),
    ('Casa de Playa Azul', 'Familia Ramirez', 'Karla Diaz', 'en_revision');

-- El evento 9 es una entrada de prueba (comentario "Entrada de prueba")
-- que se cargo por error y nunca fue un evento real: se elimina en
-- dml/operaciones.sql. Es la unica fila del historico que se borra.
INSERT INTO eventos (id_proyecto, tipo_evento, fecha_evento, estado, comentario) VALUES
    (1, 'boceto_inicial', '2026-06-01 09:00', 'aprobado', 'Boceto aprobado por la familia Lopez'),
    (1, 'render_3d', '2026-06-15 10:00', 'aprobado', 'Render exterior aprobado'),
    (2, 'boceto_inicial', '2026-06-05 09:00', 'aprobado', 'Concepto inicial aprobado'),
    (2, 'revision_cliente', '2026-07-01 11:00', 'pendiente', 'En espera de comentarios del comite'),
    (3, 'entrega_final', '2026-07-10 15:00', 'aprobado', 'Remodelacion entregada y aprobada'),
    (4, 'boceto_inicial', '2026-07-12 09:00', 'aprobado', 'Inicio de diseno del centro comercial'),
    (4, 'plano_tecnico', '2026-07-20 14:00', 'rechazado', 'Comite pidio ajustar accesos vehiculares'),
    (5, 'render_3d', '2026-06-20 10:00', 'pendiente', 'Render de fachada en revision'),
    (1, 'boceto_inicial', '2026-06-01 09:00', 'pendiente', 'Entrada de prueba');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- tipo_evento fuera de la lista permitida por el CHECK de eventos.
-- INSERT INTO eventos (id_proyecto, tipo_evento, estado) VALUES (1, 'demolicion', 'pendiente');
