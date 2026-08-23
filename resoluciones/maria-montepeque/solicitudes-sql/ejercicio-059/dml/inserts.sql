PRAGMA foreign_keys = ON;

-- Ejercicio 059: Estudio Animacion 3D
-- Datos de prueba.

INSERT INTO clientes (nombre_cliente, email) VALUES
    ('Estudio Nova Films', 'contacto@novafilms.com'),
    ('Pixel Forge Studios', 'produccion@pixelforge.com'),
    ('Andes Interactive', 'proyectos@andesinteractive.com'),
    ('Luna Producciones', 'hola@lunaproducciones.com'),
    ('Quetzal Games', 'estudio@quetzalgames.com');

INSERT INTO artistas (nombre_artista, especialidad) VALUES
    ('Karla Fong', 'modelado'),
    ('Mateo Solis', 'animacion'),
    ('Ximena Ac', 'texturizado'),
    ('Douglas Perez', 'iluminacion'),
    ('Valeria Tum', 'modelado');

-- El proyecto 5 (Nivel Quetzal 1) esta 'cancelado'.
INSERT INTO proyectos (id_cliente, nombre_proyecto, fecha_inicio, estado) VALUES
    (1, 'Trailer Nova 2026', '2026-07-01', 'entregado'),
    (2, 'Personaje Principal PixelForge', '2026-07-10', 'en_desarrollo'),
    (3, 'Cinematica Andes', '2026-07-15', 'revision'),
    (4, 'Comercial Luna 30s', '2026-07-20', 'en_desarrollo'),
    (5, 'Nivel Quetzal 1', '2026-07-25', 'cancelado'),
    (1, 'Trailer Nova Fase 2', '2026-08-01', 'en_desarrollo');

-- La tarea 11 es un duplicado por error de digitacion (mismo
-- proyecto, artista, descripcion, fecha y estado que la tarea 1): se
-- corrige en dml/operaciones.sql. La tarea 9 pertenece al proyecto 5,
-- que se cancelo, y sigue 'pendiente': se borrara de forma
-- controlada.
INSERT INTO tareas (id_proyecto, id_artista, descripcion, fecha_asignacion, estado, fecha_ultimo_cambio) VALUES
    (1, 1, 'Modelado escena principal', '2026-07-02', 'completada', '2026-07-10'),
    (1, 4, 'Iluminacion trailer', '2026-07-05', 'completada', '2026-07-12'),
    (2, 2, 'Animacion caminata personaje', '2026-07-11', 'en_progreso', '2026-07-15'),
    (2, 1, 'Modelado personaje secundario', '2026-07-12', 'pendiente', '2026-07-12'),
    (3, 3, 'Texturizado escenario', '2026-07-16', 'en_progreso', '2026-07-18'),
    (3, 2, 'Animacion camara', '2026-07-17', 'pendiente', '2026-07-17'),
    (4, 4, 'Iluminacion comercial', '2026-07-21', 'completada', '2026-07-25'),
    (4, 5, 'Modelado producto', '2026-07-22', 'en_progreso', '2026-07-23'),
    (5, 1, 'Modelado nivel', '2026-07-26', 'pendiente', '2026-07-26'),
    (6, 1, 'Modelado trailer fase2', '2026-08-02', 'pendiente', '2026-08-02'),
    (1, 1, 'Modelado escena principal', '2026-07-02', 'completada', '2026-07-10');

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados:

-- 1) Registro repetido: nombre_proyecto ya existe, viola el UNIQUE.
-- INSERT INTO proyectos (id_cliente, nombre_proyecto, fecha_inicio) VALUES (2, 'Trailer Nova 2026', '2026-08-05');

-- 2) Valor fuera de rango: estado no valido, viola el CHECK.
-- INSERT INTO tareas (id_proyecto, id_artista, descripcion, fecha_asignacion, estado, fecha_ultimo_cambio) VALUES (2, 3, 'Prueba estado invalido', '2026-08-05', 'archivada', '2026-08-05');
