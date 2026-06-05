INSERT INTO peliculas (titulo, duracion_minutos, clasificacion, genero) VALUES
("Spider-Man: No Way Home", 148, "PG-13", "Acción"),
("The Batman", 176, "R", "Drama"),
("Interestelar", 169, "PG-13", "Sci-Fi"),
("El Conjuro", 112, "R", "Terror");

INSERT INTO salas (nombre_sala, capacidad, tipo_proyeccion) VALUES
("Sala 1 MacroXE", 150, "2D"),
("Sala 2 VIP", 50, "3D"),
("Sala 3 Regular", 100, "2D");

INSERT INTO funciones (id_pelicula, id_sala, fecha_hora, precio_base) VALUES
(1, 1, '2026-06-15 18:00', 45.00),
(1, 2, '2026-06-15 21:00', 75.00),
(2, 3, '2026-06-15 19:30', 35.00),
(3, 1, '2026-06-16 15:00', 45.00);

INSERT INTO boletos (id_funcion, numero_asiento, fecha_compra, total_pagado) VALUES
(1, "A-12", '2026-06-15 17:30', 45.00),
(1, "A-13", '2026-06-15 17:30', 45.00),
(2, "VIP-05", '2026-06-15 20:15', 75.00),
(3, "B-04", '2026-06-15 19:00', 35.00);

UPDATE peliculas SET titulo="The Batman: Special Edition" WHERE id_pelicula = 2;