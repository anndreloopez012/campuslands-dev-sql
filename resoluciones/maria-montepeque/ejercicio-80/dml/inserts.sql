PRAGMA foreign_keys = ON;

-- Ejercicio 80: SELECT Nivel Basico
-- Datos de prueba.

INSERT INTO campers (nombre, fecha_nacimiento, nivel) VALUES
    ('Karen Solis', '2000-03-15', 'avanzado'),
    ('Mario Ixtabalan', '2003-07-22', 'intermedio'),
    ('Ana Gomez', '2005-11-02', 'principiante'),
    ('Luis Marroquin', '1998-01-30', 'avanzado'),
    ('Rosa Chavez', '2001-09-18', 'intermedio');

INSERT INTO rutas (nombre_ruta, distancia_km, costo_inscripcion) VALUES
    ('Cumbre Extrema', 18.5, 250.00),
    ('Sendero del Canon', 9.2, 120.00),
    ('Ruta del Volcan', 25.0, 300.00);

INSERT INTO inscripciones (id_camper, id_ruta) VALUES
    (1, 1),
    (2, 1),
    (3, 2),
    (4, 3),
    (5, 3);
