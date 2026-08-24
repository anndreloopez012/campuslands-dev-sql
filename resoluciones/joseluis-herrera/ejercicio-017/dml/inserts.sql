INSERT INTO usuarios (
    id_usuario,
    nombre_completo,
    nombre_usuario,
    email,
    fecha_registro
) VALUES
(1, 'Carlos Ramirez', 'carlos_ramirez', 'carlos@campus.com', '2026-08-01'),
(2, 'Ana Lopez', 'ana_lopez', 'ana@campus.com', '2026-08-02'),
(3, 'Luis Martinez', 'luis_martinez', 'luis@campus.com', '2026-08-03'),
(4, 'Sofia Garcia', 'sofia_garcia', 'sofia@campus.com', '2026-08-04'),
(5, 'Diego Castillo', 'diego_castillo', 'diego@campus.com', '2026-08-05');

INSERT INTO publicaciones (
    id_publicacion,
    id_usuario,
    contenido,
    fecha_publicacion,
    vistas,
    estado
) VALUES
(1, 1, 'Aprendiendo SQL en Campuslands', '2026-08-10 08:30:00', 250, 'publicada'),
(2, 2, 'Mi primer proyecto web terminado', '2026-08-10 10:15:00', 420, 'publicada'),
(3, 3, 'Practicar consultas SQL mejora la logica', '2026-08-11 09:00:00', 180, 'publicada'),
(4, 4, 'Hoy aprendi a trabajar con JOIN', '2026-08-11 14:20:00', 350, 'publicada'),
(5, 5, 'Compartiendo recursos para aprender Python', '2026-08-12 16:45:00', 520, 'publicada');

INSERT INTO comentarios (
    id_comentario,
    id_publicacion,
    id_usuario,
    contenido,
    fecha_comentario
) VALUES
(1, 1, 2, 'Excelente aporte', '2026-08-10 09:00:00'),
(2, 1, 3, 'SQL es muy interesante', '2026-08-10 09:15:00'),
(3, 2, 1, 'Muy buen proyecto', '2026-08-10 11:00:00'),
(4, 2, 4, 'Felicitaciones', '2026-08-10 11:30:00'),
(5, 3, 5, 'Totalmente de acuerdo', '2026-08-11 09:30:00'),
(6, 4, 1, 'Los JOIN son fundamentales', '2026-08-11 15:00:00'),
(7, 4, 2, 'Buen ejemplo', '2026-08-11 15:20:00'),
(8, 5, 3, 'Gracias por compartir', '2026-08-12 17:10:00'),
(9, 5, 4, 'Me servira bastante', '2026-08-12 17:30:00'),
(10, 5, 1, 'Excelente recurso', '2026-08-12 18:00:00');

INSERT INTO reacciones (
    id_reaccion,
    id_publicacion,
    id_usuario,
    tipo,
    fecha_reaccion
) VALUES
(1, 1, 2, 'me_gusta', '2026-08-10'),
(2, 1, 3, 'me_encanta', '2026-08-10'),
(3, 2, 1, 'me_gusta', '2026-08-10'),
(4, 2, 4, 'me_encanta', '2026-08-10'),
(5, 3, 5, 'me_gusta', '2026-08-11'),
(6, 4, 1, 'me_gusta', '2026-08-11'),
(7, 4, 2, 'me_divierte', '2026-08-11'),
(8, 5, 3, 'me_encanta', '2026-08-12'),
(9, 5, 4, 'me_gusta', '2026-08-12'),
(10, 5, 1, 'me_sorprende', '2026-08-12');