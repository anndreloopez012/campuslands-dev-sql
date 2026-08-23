PRAGMA foreign_keys = ON;

-- Ejercicio 009: Estudio Animacion 3D
-- Datos de prueba.

INSERT INTO proyectos (nombre_proyecto, cliente, artista_asignado, estado_actual) VALUES
    ('Serie Aventuras Espaciales', 'Cadena TV Max', 'Sofia Reyes', 'en_progreso'),
    ('Comercial Bebidas Frescas', 'Marca RefrescoCo', 'Mario Paz', 'en_progreso'),
    ('Cortometraje Bosque Encantado', 'Estudio Independiente', 'Laura Ortiz', 'finalizado'),
    ('Videojuego Reinos Perdidos - cinematica', 'GameStudio XY', 'Diego Paz', 'en_progreso'),
    ('Documental Vida Marina', 'Canal Naturaleza', 'Karen Solis', 'pausado');

-- La entrega 9 es una entrada de prueba (comentario "Entrada de prueba")
-- que se cargo por error y nunca fue un evento real: se elimina en
-- dml/operaciones.sql. Es la unica fila del historico que se borra.
INSERT INTO entregas (id_proyecto, tipo_evento, fecha_evento, estado, comentario) VALUES
    (1, 'inicio', '2026-06-01 09:00', 'aprobado', 'Kickoff aprobado por el cliente'),
    (1, 'avance', '2026-06-15 10:00', 'aprobado', 'Primer bloque de animacion aprobado'),
    (2, 'inicio', '2026-06-05 09:00', 'aprobado', 'Inicio de produccion del comercial'),
    (2, 'revision', '2026-07-01 11:00', 'pendiente', 'En espera de feedback del cliente'),
    (3, 'entrega_final', '2026-07-10 15:00', 'aprobado', 'Corto entregado y aprobado'),
    (4, 'inicio', '2026-07-12 09:00', 'aprobado', 'Inicio de cinematica'),
    (4, 'correccion', '2026-07-20 14:00', 'rechazado', 'Cliente pidio cambios en iluminacion'),
    (5, 'avance', '2026-06-20 10:00', 'pendiente', 'Proyecto pausado por el cliente'),
    (1, 'avance', '2026-06-01 09:00', 'pendiente', 'Entrada de prueba');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- tipo_evento fuera de la lista permitida por el CHECK de entregas.
-- INSERT INTO entregas (id_proyecto, tipo_evento, estado) VALUES (1, 'cancelacion', 'pendiente');
