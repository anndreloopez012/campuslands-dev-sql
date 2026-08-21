PRAGMA foreign_keys = ON;

-- USUARIOS

INSERT INTO usuarios (
    id_usuario,
    nombre_completo,
    nombre_usuario,
    correo,
    fecha_registro
) VALUES
    (1, 'Carlos Velasco', 'carlos.velasco', 'carlos.velasco@campus.edu', '2026-01-10'),
    (2, 'Ana Martinez', 'ana.martinez', 'ana.martinez@campus.edu', '2026-01-12'),
    (3, 'Luis Herrera', 'luis.herrera', 'luis.herrera@campus.edu', '2026-01-15'),
    (4, 'Sofia Ramirez', 'sofia.ramirez', 'sofia.ramirez@campus.edu', '2026-01-18'),
    (5, 'Diego Castillo', 'diego.castillo', 'diego.castillo@campus.edu', '2026-01-20');

-- PUBLICACIONES

INSERT INTO publicaciones (
    id_publicacion,
    usuario_id,
    contenido,
    fecha_publicacion,
    visibilidad
) VALUES
    (1, 1, 'Hoy practicamos consultas SQL con SQLite.', '2026-02-01', 'publica'),
    (2, 2, 'Compartiendo recursos para aprender Java.', '2026-02-03', 'publica'),
    (3, 3, 'Mi primer proyecto con bases de datos.', '2026-02-05', 'publica'),
    (4, 4, 'Consejos para mejorar nuestras consultas SQL.', '2026-02-07', 'publica'),
    (5, 5, 'Preparando el proyecto final de Campuslands.', '2026-02-10', 'publica'),
    (6, 1, 'Aprendiendo relaciones entre tablas.', '2026-02-12', 'publica'),
    (7, 2, 'Probando nuevas herramientas de desarrollo.', '2026-02-15', 'publica'),
    (8, 3, 'La normalizacion ayuda a mantener los datos limpios.', '2026-02-18', 'publica'),
    (9, 4, 'Hoy estudie claves primarias y foraneas.', '2026-02-20', 'publica'),
    (10, 5, 'Compartiendo avances de mi proyecto.', '2026-02-22', 'publica');

-- COMENTARIOS

INSERT INTO comentarios (
    id_comentario,
    publicacion_id,
    usuario_id,
    contenido,
    fecha_comentario
) VALUES
    (1, 1, 2, 'Muy buen ejercicio.', '2026-02-01'),
    (2, 1, 3, 'SQLite es muy practico.', '2026-02-01'),
    (3, 2, 4, 'Gracias por compartirlo.', '2026-02-03'),
    (4, 3, 1, 'Excelente avance.', '2026-02-05'),
    (5, 4, 5, 'Me sirve mucho este consejo.', '2026-02-07'),
    (6, 5, 2, 'El proyecto se ve interesante.', '2026-02-10'),
    (7, 6, 3, 'Las relaciones son fundamentales.', '2026-02-12'),
    (8, 7, 4, 'Voy a probar esas herramientas.', '2026-02-15'),
    (9, 8, 5, 'La normalizacion evita duplicidad.', '2026-02-18'),
    (10, 9, 1, 'Las claves foraneas son importantes.', '2026-02-20');

-- REACCIONES

INSERT INTO reacciones (
    id_reaccion,
    publicacion_id,
    usuario_id,
    tipo,
    fecha_reaccion
) VALUES
    (1, 1, 2, 'me_gusta', '2026-02-01'),
    (2, 1, 3, 'me_encanta', '2026-02-01'),
    (3, 2, 4, 'me_gusta', '2026-02-03'),
    (4, 3, 1, 'me_interesa', '2026-02-05'),
    (5, 4, 5, 'me_encanta', '2026-02-07'),
    (6, 5, 2, 'me_gusta', '2026-02-10'),
    (7, 6, 3, 'me_interesa', '2026-02-12'),
    (8, 7, 4, 'me_gusta', '2026-02-15'),
    (9, 8, 5, 'me_encanta', '2026-02-18'),
    (10, 9, 1, 'me_gusta', '2026-02-20');