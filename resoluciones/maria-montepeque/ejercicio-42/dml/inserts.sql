PRAGMA foreign_keys = ON;

-- Ejercicio 42: Tipos de datos Nivel Intermedio
-- Datos de prueba para validar el tema Tipos de datos.

INSERT INTO rutas (nombre, duracion_semanas, precio, activa) VALUES
    ('Desarrollo Web', 20, 8500.00, 1),
    ('Ciencia de Datos', 24, 9800.00, 1),
    ('Infraestructura Cloud', 18, 7600.00, 1),
    ('Diseno UX/UI', 16, 6200.00, 0),   -- activa = 0: ruta cerrada temporalmente
    ('Ciberseguridad', 22, 9200.00, 1);

-- fecha_nacimiento usa el DATE simulado; becado usa el BOOLEAN simulado.
INSERT INTO campers (nombre, correo, fecha_nacimiento, becado) VALUES
    ('Manuel Estrada', 'manuel.estrada@correo.com', '2001-03-15', 1),
    ('Alejandra Chinchilla', 'alejandra.chinchilla@correo.com', '2000-07-22', 0),
    ('Byron Xicay', 'byron.xicay@correo.com', '1999-11-05', 0),
    ('Cristina Barrios', 'cristina.barrios@correo.com', '2002-01-30', 1),
    ('Douglas Pineda', 'douglas.pineda@correo.com', '2000-09-12', 0);

-- nota_final acepta NULL (camper todavia cursando); aprobado es BOOLEAN simulado.
INSERT INTO inscripciones (id_camper, id_ruta, fecha_inscripcion, nota_final, aprobado) VALUES
    (1, 1, '2026-01-15', 92.0, 1),
    (2, 2, '2026-01-15', 78.5, 1),
    (3, 1, '2026-02-01', NULL, 0),    -- todavia en curso, sin nota
    (4, 3, '2026-02-01', 88.0, 1),
    (5, 5, '2026-03-01', 55.0, 0),    -- curso terminado, no aprobado
    (1, 2, '2026-03-10', NULL, 0);    -- Manuel tambien cursa otra ruta

-- Caso valido: nota_final puede ser NULL mientras el camper sigue en curso.
INSERT INTO inscripciones (id_camper, id_ruta, fecha_inscripcion, nota_final, aprobado) VALUES
    (2, 3, '2026-04-01', NULL, 0);

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- nota_final = 150 esta fuera del rango 0-100 (REAL valido en tipo, pero
-- fuera del dominio del negocio); el CHECK lo rechaza.
-- INSERT INTO inscripciones (id_camper, id_ruta, fecha_inscripcion, nota_final, aprobado) VALUES (3, 4, '2026-04-05', 150.0, 1);

-- Otro caso que no es recomendable: usar TEXT 'si'/'no' para un booleano en
-- vez de INTEGER 0/1 rompe la simulacion (aqui directamente falla por el
-- CHECK, que solo acepta 0 o 1, ademas de que "becado" es INTEGER):
-- INSERT INTO campers (nombre, correo, fecha_nacimiento, becado) VALUES ('Prueba', 'prueba@correo.com', '2000-01-01', 'si');
