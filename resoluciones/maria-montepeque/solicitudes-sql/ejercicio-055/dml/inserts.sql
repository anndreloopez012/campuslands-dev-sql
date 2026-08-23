PRAGMA foreign_keys = ON;

-- Ejercicio 055: Cine Horror Nights
-- Datos de prueba.

INSERT INTO peliculas (titulo, duracion_minutos, clasificacion) VALUES
    ('La Casa del Silencio', 105, 'C'),
    ('Posesion Nocturna', 98, 'D'),
    ('El Ultimo Sotano', 110, 'C'),
    ('Munecas de Porcelana', 92, 'B15'),
    ('Sangre en el Bosque', 115, 'D');

-- Salas pequenas a proposito, para poder demostrar la ocupacion con
-- pocos datos de prueba.
INSERT INTO salas (nombre_sala, capacidad) VALUES
    ('Sala 1', 8),
    ('Sala 2', 6),
    ('Sala 3', 10),
    ('Sala 4', 5);

-- La funcion 9 es un duplicado por error de digitacion (misma
-- pelicula, sala, fecha, precio y estado que la funcion 1): se
-- corrige en dml/operaciones.sql.
INSERT INTO funciones (id_pelicula, id_sala, fecha_hora, precio_boleto, estado) VALUES
    (1, 1, '2026-10-01 19:00', 45.00, 'finalizada'),
    (2, 2, '2026-10-01 21:00', 50.00, 'finalizada'),
    (3, 3, '2026-10-02 19:30', 45.00, 'finalizada'),
    (1, 2, '2026-10-02 22:00', 55.00, 'en_curso'),
    (4, 4, '2026-10-03 18:00', 40.00, 'programada'),
    (5, 1, '2026-10-03 20:30', 50.00, 'programada'),
    (2, 3, '2026-10-04 21:00', 50.00, 'cancelada'),
    (3, 4, '2026-10-05 19:00', 45.00, 'programada'),
    (1, 1, '2026-10-01 19:00', 45.00, 'finalizada');

-- Boletos por funcion. El boleto de asiento A5 en la funcion 1 se
-- reembolso, pero esa funcion ya se proyecto (finalizada): por eso
-- no se podra borrar. El boleto A2 de la funcion 6 tambien se
-- reembolso, pero esa funcion sigue 'programada': si se podra
-- borrar. Lo mismo el boleto E1 de la funcion 7, que se cancelo.
INSERT INTO boletos (id_funcion, nombre_cliente, asiento, estado) VALUES
    (1, 'Fernanda Ochoa', 'A1', 'usado'),
    (1, 'Bryan Cifuentes', 'A2', 'usado'),
    (1, 'Melissa Torres', 'A3', 'usado'),
    (1, 'Josue Villagran', 'A4', 'usado'),
    (1, 'Karen Ixba', 'A5', 'reembolsado'),
    (2, 'Diego Marroquin', 'B1', 'usado'),
    (2, 'Andrea Solis', 'B2', 'usado'),
    (2, 'Cesar Rios', 'B3', 'usado'),
    (2, 'Ingrid Say', 'B4', 'usado'),
    (2, 'Marvin Chach', 'B5', 'usado'),
    (2, 'Paola Fuentes', 'B6', 'usado'),
    (3, 'Estuardo Ba', 'C1', 'usado'),
    (3, 'Renata Ixchel', 'C2', 'usado'),
    (3, 'Carlos Mota', 'C3', 'usado'),
    (4, 'Valentina Roca', 'B1', 'vendido'),
    (5, 'Kimberly Solares', 'D1', 'vendido'),
    (6, 'Herminio Coy', 'A1', 'vendido'),
    (6, 'Susana Lemus', 'A2', 'reembolsado'),
    (7, 'Wilmer Chiquin', 'E1', 'reembolsado');

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados:

-- 1) Registro repetido: el asiento A1 ya esta vendido en la funcion 1, viola el UNIQUE compuesto.
-- INSERT INTO boletos (id_funcion, nombre_cliente, asiento) VALUES (1, 'Otro Cliente', 'A1');

-- 2) Valor fuera de rango: precio_boleto = 0 no es una funcion valida, viola el CHECK.
-- INSERT INTO funciones (id_pelicula, id_sala, fecha_hora, precio_boleto) VALUES (5, 2, '2026-10-06 20:00', 0);
