PRAGMA foreign_keys = ON;

-- Ejercicio 01: CineMax SQLite
-- Inserte aqui los datos base.
-- Debe incluir datos suficientes para probar todas las consultas.
-- Casos de error sugeridos:
-- Mantenga comentadas las inserciones que deben fallar para que el script principal ejecute correctamente.
INSERT INTO peliculas (nombre, director, duracion, genero) VALUES
('Cenicienta', 'Oscar Park', '120 minutos', 'Infantil'),   
('La llorona', 'Pedro Heat', '150 minutos', 'Terror'),
('El aro', 'Angel Smith', '100 minuts', 'Terror'),
('La guerra Z', 'Maria Osman', '160 minutos', 'Terror'),
('Blanca nieves', 'Tatiana Parker', '110 minutos', 'Infantil');
    



INSERT INTO sala (nombre, capacidad) VALUES
('La luna', 30),
('El espacio', 40),
('Marte', 100),
('La galaxia', 80),
('La estelar', 100);

INSERT INTO funcion (nombre, id_pelicula, id_sala, fecha, hora, precio)VALUES
('Especial', 1, 2, '2026-05-15', '14:30', 120),
('Matiné Infantil', 5, 1, '2026-05-16', '10:00', 80),
('Nocturna de Terror', 2, 3, '2026-05-16', '21:00', 150),
('Estreno Galáctico', 4, 4, '2026-05-17', '18:00', 180),
('Maratón de Miedo', 3, 5, '2026-05-17', '23:30', 200),
('Clásicos de Tarde', 1, 1, '2026-05-18', '16:00', 100),
('Acción Total', 4, 3, '2026-05-18', '19:30', 140),
('Función de Cierre', 5, 2, '2026-05-19', '15:00', 95);


INSERT INTO boleto (id_funcion, id_pelicula, fecha_compra, asiento) VALUES
(1, 2, '2026-05-02', 'A2'),
(1, 1, '2026-05-02', 'A3'),
(2, 5, '2026-05-05', 'B10'),
(3, 2, '2026-05-04', 'C5'),
(4, 4, '2026-05-08', 'F12'),
(5, 3, '2026-05-07', 'D1'),
(5, 3, '2026-05-09', 'D2'),
(6, 1, '2026-05-10', 'A1'),
(7, 4, '2026-05-06', 'E8'),
(8, 5, '2026-05-11', 'B4');
