PRAGMA foreign_keys = ON;

-- Ejercicio 034: Estudio Animacion 3D
-- Datos de prueba.

INSERT INTO clientes (nombre_cliente, email) VALUES
    ('Estudio Nova Films', 'contacto@novafilms.com'),
    ('Pixel Forge Studios', 'produccion@pixelforge.com'),
    ('Andes Interactive', 'proyectos@andesinteractive.com'),
    ('Luna Producciones', 'hola@lunaproducciones.com'),
    ('Quetzal Games', 'estudio@quetzalgames.com');

INSERT INTO artistas (nombre_artista, especialidad) VALUES
    ('Mario Lux', 'animacion'),
    ('Sofia Vera', 'modelado'),
    ('Diego Ruiz', 'texturizado'),
    ('Paula Ixchel', 'iluminacion'),
    ('Carlos Mendez', 'animacion');

-- El proyecto 10 es un duplicado por error de digitacion (mismo
-- cliente, artista, proyecto, fecha y presupuesto que el proyecto 1):
-- se corrige en dml/operaciones.sql.
INSERT INTO proyectos (id_cliente, id_artista, nombre_proyecto, fecha_entrega, presupuesto, estado) VALUES
    (1, 1, 'Trailer Nova - Escena 1', '2026-08-05', 4500.00, 'finalizado'),
    (2, 2, 'Personaje Principal Pixel Forge', '2026-08-10', 6200.00, 'en_progreso'),
    (3, 3, 'Texturas Mapa Andes', '2026-08-08', 3100.00, 'pendiente'),
    (1, 4, 'Iluminacion Trailer Nova', '2026-08-12', 2800.00, 'pendiente'),
    (4, 1, 'Comercial Luna 30s', '2026-08-15', 5200.00, 'en_revision'),
    (5, 5, 'Cinematica Quetzal Nivel 1', '2026-08-20', 7800.00, 'en_progreso'),
    (2, 3, 'Texturas Personaje Pixel Forge', '2026-08-11', 1900.00, 'finalizado'),
    (3, 2, 'Modelado Escenario Andes', '2026-08-09', 3600.00, 'pendiente'),
    (2, 1, 'Modelado Personaje Secundario', '2026-08-18', 3300.00, 'pendiente'),
    (1, 1, 'Trailer Nova - Escena 1', '2026-08-05', 4500.00, 'finalizado');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- presupuesto en cero, viola el CHECK de proyectos.
-- INSERT INTO proyectos (id_cliente, id_artista, nombre_proyecto, fecha_entrega, presupuesto) VALUES (2, 4, 'Prueba Presupuesto Cero', '2026-08-22', 0);
