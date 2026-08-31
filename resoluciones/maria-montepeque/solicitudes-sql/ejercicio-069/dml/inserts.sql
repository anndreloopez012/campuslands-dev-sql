PRAGMA foreign_keys = ON;

-- Ejercicio 069: Diseno 3D Arquitectura
-- Datos base: 3 clientes, 4 proyectos, 9 renders, 12 revisiones,
-- 4 entregas.

INSERT INTO clientes (nombre, telefono) VALUES
    ('Manuel Estrada', '5555-8001'),
    ('Alejandra Chinchilla', '5555-8002'),
    ('Byron Xicay', '5555-8003');

INSERT INTO proyectos (id_cliente, nombre, tipo, fecha_inicio) VALUES
    (1, 'Casa Vista Verde', 'residencial', '2026-07-01'),
    (2, 'Torre Corporativa Central', 'comercial', '2026-07-05'),
    (3, 'Escuela Nueva Esperanza', 'institucional', '2026-07-10'),
    (1, 'Remodelacion Oficina', 'comercial', '2026-07-15');

INSERT INTO renders (id_proyecto, nombre_archivo, estado) VALUES
    (1, 'casa_fachada_v1.png', 'en_proceso'),
    (1, 'casa_interior_v1.png', 'terminado'),
    (2, 'torre_exterior_v1.png', 'en_proceso'),
    (2, 'torre_lobby_v1.png', 'terminado'),
    (3, 'escuela_patio_v1.png', 'en_proceso'),
    (3, 'escuela_aulas_v1.png', 'descartado'),
    (4, 'oficina_recepcion_v1.png', 'terminado'),
    (4, 'oficina_sala_juntas_v1.png', 'en_proceso');

-- Render creado por error (nombre duplicado de otro proyecto), todavia
-- sin ninguna revision asociada: es el unico caso de esta base de datos
-- donde un DELETE real es aceptable (se corrige en operaciones.sql).
INSERT INTO renders (id_proyecto, nombre_archivo, estado) VALUES
    (4, 'oficina_pasillo_v1_duplicado.png', 'en_proceso');

-- revisiones: historico de auditoria de cada render.
INSERT INTO revisiones (id_render, comentario, aprobado) VALUES
    (1, 'Falta ajustar iluminacion', 0),
    (1, 'Iluminacion corregida, se aprueba', 1),
    (2, 'Se aprueba sin observaciones', 1),
    (3, 'Revisar proporcion de ventanas', 0),
    (3, 'Ajustado, pendiente segunda revision', 0),
    (4, 'Se aprueba el lobby', 1),
    (5, 'Falta vegetacion en el patio', 0),
    (6, 'Se descarta esta version del render', 0),
    (7, 'Se aprueba la recepcion', 1),
    (8, 'Revisar mobiliario de la sala', 0),
    (2, 'Segunda revision de cliente, tambien aprueba', 1),
    (4, 'Revision final de cliente, aprueba de nuevo', 1);

INSERT INTO entregas (id_proyecto, fecha_entrega, version) VALUES
    (1, '2026-08-01', 'v1.0'),
    (2, '2026-08-05', 'v1.0'),
    (4, '2026-08-10', 'v1.0'),
    (1, '2026-08-15', 'v1.1');

-- Caso que debe fallar (queda comentado): eliminar un render que ya
-- tiene revisiones asociadas viola la FOREIGN KEY de
-- revisiones.id_render, ademas de contradecir la regla de negocio de
-- conservar el historico.
-- DELETE FROM renders WHERE id_render = 1;
