-- Ejercicio 17: Red Social Campus
-- Datos base: 5 usuarios, 5 publicaciones, 5 comentarios, 10 reacciones

INSERT INTO usuarios (nombre_usuario, correo, fecha_registro) VALUES
    ('mestrada', 'manuel.estrada@correo.com', '2026-01-10'),
    ('achinchilla', 'alejandra.chinchilla@correo.com', '2026-01-12'),
    ('bxicay', 'byron.xicay@correo.com', '2026-02-01'),
    ('cbarrios', 'cristina.barrios@correo.com', '2026-02-15'),
    ('dpineda', 'douglas.pineda@correo.com', '2026-03-01');

INSERT INTO publicaciones (id_usuario, contenido, fecha) VALUES
    (1, 'Empezando el semestre con energia nueva.', '2026-07-01 08:00'),
    (2, 'Comparto mis apuntes de bases de datos.', '2026-07-02 10:30'),
    (3, 'Alguien mas va al torneo de esports del campus?', '2026-07-03 14:00'),
    (4, 'Terminando el proyecto integrador de SQL.', '2026-07-04 18:45'),
    (5, 'Buscando grupo de estudio para el parcial.', '2026-07-05 09:15');

INSERT INTO comentarios (id_publicacion, id_usuario, contenido, fecha) VALUES
    (1, 2, 'Mucho animo con el semestre!', '2026-07-01 08:30'),
    (2, 1, 'Gracias por compartir, me sirve mucho.', '2026-07-02 11:00'),
    (3, 4, 'Yo tambien voy, nos vemos alla.', '2026-07-03 14:20'),
    (4, 5, 'Que tema te falta terminar?', '2026-07-04 19:00'),
    (5, 3, 'Yo me apunto al grupo de estudio.', '2026-07-05 09:40');

INSERT INTO reacciones (id_publicacion, id_usuario, tipo, fecha) VALUES
    (1, 2, 'like', '2026-07-01 08:05'),
    (1, 3, 'love', '2026-07-01 08:10'),
    (2, 1, 'like', '2026-07-02 10:35'),
    (2, 3, 'wow', '2026-07-02 10:40'),
    (2, 4, 'like', '2026-07-02 11:15'),
    (3, 2, 'haha', '2026-07-03 14:10'),
    (3, 4, 'like', '2026-07-03 14:25'),
    (4, 1, 'love', '2026-07-04 18:50'),
    (4, 5, 'like', '2026-07-04 19:05'),
    (5, 3, 'like', '2026-07-05 09:20');
