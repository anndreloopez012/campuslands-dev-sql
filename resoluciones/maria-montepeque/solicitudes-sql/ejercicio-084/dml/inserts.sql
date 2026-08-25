PRAGMA foreign_keys = ON;

-- Ejercicio 084: Estudio Animacion 3D
-- Datos base: 3 clientes, 4 artistas, 3 proyectos, 8 tareas (incluye
-- 1 cargada por error para un alcance que el cliente cancelo) y 4
-- entregas semanales (1 todavia sin aprobar).

INSERT INTO clientes (nombre_cliente, telefono) VALUES
    ('Manuel Estrada', '5555-6201'),
    ('Alejandra Chinchilla', '5555-6202'),
    ('Byron Xicay', '5555-6203');

INSERT INTO artistas (nombre_artista, especialidad) VALUES
    ('Karla Rivas', 'modelado'),
    ('Bryan Solis', 'animacion'),
    ('Fernanda Lopez', 'render'),
    ('Jorge Cifuentes', 'texturizado');

INSERT INTO proyectos (id_cliente, nombre_proyecto, fecha_inicio, estado) VALUES
    (1, 'Serie Aventuras Espaciales', '2026-07-01', 'en_curso'),
    (2, 'Comercial Bebida Energetica', '2026-07-15', 'en_curso'),
    (3, 'Pelicula Corta Fantasia', '2026-06-01', 'finalizado');

-- Tareas del proyecto 1 (Serie Aventuras Espaciales).
INSERT INTO tareas (id_proyecto, id_artista, descripcion, fecha_tarea, horas_trabajadas) VALUES
    (1, 1, 'Modelado nave principal', '2026-08-01', 8),
    (1, 2, 'Animacion despegue', '2026-08-02', 6),
    (1, 3, 'Render escena 1', '2026-08-03', 10);

-- Tareas del proyecto 2 (Comercial Bebida Energetica).
INSERT INTO tareas (id_proyecto, id_artista, descripcion, fecha_tarea, horas_trabajadas) VALUES
    (2, 2, 'Animacion logo', '2026-08-01', 4),
    (2, 4, 'Texturizado lata', '2026-08-02', 5);

-- Tareas del proyecto 3 (Pelicula Corta Fantasia, ya finalizado).
INSERT INTO tareas (id_proyecto, id_artista, descripcion, fecha_tarea, horas_trabajadas) VALUES
    (3, 1, 'Modelado personaje final', '2026-07-20', 12),
    (3, 3, 'Render final', '2026-07-25', 15);

-- Tarea cargada por error: el cliente del proyecto 2 cancelo un
-- alcance extra (etiqueta adicional) despues de que ya se habia
-- registrado el trabajo. Se corrige con DELETE en
-- dml/operaciones.sql.
INSERT INTO tareas (id_proyecto, id_artista, descripcion, fecha_tarea, horas_trabajadas) VALUES
    (2, 4, 'Texturizado etiqueta extra (alcance cancelado)', '2026-08-03', 3);

-- Entregas semanales.
INSERT INTO entregas (id_proyecto, semana, fecha_entrega, aprobada) VALUES
    (1, 1, '2026-08-07', 1),
    (2, 1, '2026-08-07', 1),
    (3, 5, '2026-07-30', 1);

-- Entrega de la semana 2 del proyecto 1, todavia pendiente de
-- revision del cliente. Se aprueba con UPDATE en
-- dml/operaciones.sql.
INSERT INTO entregas (id_proyecto, semana, fecha_entrega, aprobada) VALUES
    (1, 2, '2026-08-14', 0);

-- Caso comentado que debe fallar (queda comentado): registrar una
-- segunda entrega para la semana 1 del proyecto 1, exactamente el
-- problema de reportes semanales duplicados que este UNIQUE esta
-- disenado para evitar.
-- INSERT INTO entregas (id_proyecto, semana, fecha_entrega) VALUES (1, 1, '2026-08-08');
