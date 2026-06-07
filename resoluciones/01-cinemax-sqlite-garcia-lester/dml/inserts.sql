PRAGMA foreign_keys = ON;

-- Inserte aqui los datos de prueba.
-- Requisitos minimos:
-- 5 peliculas, 5 salas, 8 funciones y 10 boletos.

-- Casos de error sugeridos:
-- Mantenga comentadas las inserciones que deben fallar para que el script principal ejecute correctamente.


INSERT INTO Peliculas (ID_PELICULA, TITULO, DURACION, GENERO, CLASIFICACION) VALUES
(1, 'Sci-Fi Odyssey', 145, 'Ciencia Ficción', 'B'),
(2, 'Misterio en la Niebla', 110, 'Suspenso', 'B15'),
(3, 'Risas Aseguradas', 95, 'Comedia', 'A'),
(4, 'El Último Reino', 160, 'Acción/Épico', 'C'),
(5, 'Aventuras en el Bosque', 88, 'Animación', 'AA');

INSERT INTO Sala_Proyeccion (ID_SALA, NOMBRE_SALA, CAPACIDAD_ASIENTOS) VALUES
(1, 'Sala 1 - Regular', 100),
(2, 'Sala 2 - 3D Max', 80),
(3, 'Sala 3 - MacroXE', 150),
(4, 'Sala 4 - VIP Lounge', 45),
(5, 'Sala 5 - Junior', 60);

INSERT INTO Funcion (ID_FUNCION, ID_PELICULA, ID_SALA, FECHA, HORA, PRECIO_BOLETO) VALUES
(1, 1, 3, '2026-06-10', '14:00', 75.00),
(2, 1, 2, '2026-06-10', '18:30', 95.00),
(3, 2, 1, '2026-06-10', '21:00', 60.00),
(4, 3, 5, '2026-06-11', '13:00', 55.00),
(5, 4, 3, '2026-06-11', '17:00', 75.00),
(6, 4, 4, '2026-06-11', '20:30', 140.00),
(7, 5, 5, '2026-06-12', '11:30', 50.00),
(8, 2, 1, '2026-06-12', '16:00', 60.00);

INSERT INTO Boleto (ID_BOLETO, ID_FUNCION, FECHA_VENTA, NUMERO_ASIENTO, TOTAL_PAGO) VALUES
(1, 1, '2026-06-09', 12, 75.00),
(2, 1, '2026-06-09', 13, 75.00),
(3, 2, '2026-06-10', 45, 95.00),
(4, 3, '2026-06-10', 5, 60.00),
(5, 4, '2026-06-11', 22, 55.00),
(6, 5, '2026-06-10', 88, 75.00),
(7, 6, '2026-06-11', 1, 140.00),
(8, 6, '2026-06-11', 2, 140.00),
(9, 7, '2026-06-12', 14, 50.00),
(10, 8, '2026-06-12', 30, 60.00);