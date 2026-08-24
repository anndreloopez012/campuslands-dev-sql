PRAGMA foreign_keys = ON;

-- Ejercicio 76: UPDATE Nivel Aplicado
-- Caso de negocio: cada inscripcion activa debe restar 1 al cupo
-- disponible de su ruta, y cada cancelacion debe devolverlo. La
-- consulta 5 en dql/consultas.sql es la validacion final: confirma
-- que cupo_disponible siempre coincide con
-- cupo_maximo - inscripciones activas.

INSERT INTO campers (nombre, email) VALUES
    ('Karen Solis', 'karen.solis@campus.com'),
    ('Mario Ixtabalan', 'mario.ixtabalan@campus.com'),
    ('Ana Gomez', 'ana.gomez@campus.com'),
    ('Luis Marroquin', 'luis.marroquin@campus.com'),
    ('Rosa Chavez', 'rosa.chavez@campus.com'),
    ('Diego Paz', 'diego.paz@campus.com');

-- Rutas con cupo_disponible = cupo_maximo al inicio (nadie inscrito
-- todavia). Cumbre Extrema tiene cupo reducido a proposito para poder
-- demostrar el caso de ruta llena.
INSERT INTO rutas (nombre_ruta, cupo_maximo, cupo_disponible) VALUES
    ('Cumbre Extrema', 3, 3),
    ('Sendero del Canon', 5, 5),
    ('Ruta del Volcan', 10, 10);

-- Inscripciones en Cumbre Extrema: 3 campers llenan el cupo. Cada
-- INSERT va seguido de su UPDATE correspondiente, que resta 1 al
-- cupo_disponible de esa ruta con una expresion.
INSERT INTO inscripciones (id_camper, id_ruta) VALUES (1, 1);
UPDATE rutas SET cupo_disponible = cupo_disponible - 1 WHERE id_ruta = 1;

INSERT INTO inscripciones (id_camper, id_ruta) VALUES (2, 1);
UPDATE rutas SET cupo_disponible = cupo_disponible - 1 WHERE id_ruta = 1;

INSERT INTO inscripciones (id_camper, id_ruta) VALUES (3, 1);
UPDATE rutas SET cupo_disponible = cupo_disponible - 1 WHERE id_ruta = 1;

-- Caso comentado que debe fallar (no ser recomendable), dejar
-- comentado: Cumbre Extrema ya esta llena (cupo_disponible = 0);
-- inscribir a un cuarto camper y restar 1 dejaria el cupo en -1, lo
-- que viola el CHECK de cupo_disponible >= 0.
-- INSERT INTO inscripciones (id_camper, id_ruta) VALUES (4, 1);
-- UPDATE rutas SET cupo_disponible = cupo_disponible - 1 WHERE id_ruta = 1;

-- Inscripciones en Sendero del Canon.
INSERT INTO inscripciones (id_camper, id_ruta) VALUES (4, 2);
UPDATE rutas SET cupo_disponible = cupo_disponible - 1 WHERE id_ruta = 2;

INSERT INTO inscripciones (id_camper, id_ruta) VALUES (5, 2);
UPDATE rutas SET cupo_disponible = cupo_disponible - 1 WHERE id_ruta = 2;

-- Inscripcion en Ruta del Volcan.
INSERT INTO inscripciones (id_camper, id_ruta) VALUES (6, 3);
UPDATE rutas SET cupo_disponible = cupo_disponible - 1 WHERE id_ruta = 3;

-- Mario Ixtabalan cancela su inscripcion en Cumbre Extrema: se libera
-- un cupo. Dos UPDATE, uno por tabla: primero el estado de la
-- inscripcion, despues el cupo de la ruta.
UPDATE inscripciones SET estado = 'cancelada' WHERE id_inscripcion = 2;
UPDATE rutas SET cupo_disponible = cupo_disponible + 1 WHERE id_ruta = 1;
