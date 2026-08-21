PRAGMA foreign_keys = ON;

-- Ejercicio 62: AUTO_INCREMENT Nivel Basico
-- Datos de prueba: 3 rutas, campers y sus inscripciones.
-- No se indica el id en ningun INSERT: lo genera AUTOINCREMENT.

INSERT INTO rutas (nombre) VALUES
    ('Desarrollo Web'),
    ('Ciencia de Datos'),
    ('Ciberseguridad');

INSERT INTO campers (nombre, email) VALUES
    ('Manuel Estrada', 'manuel.estrada@correo.com'),
    ('Alejandra Chinchilla', 'alejandra.chinchilla@correo.com'),
    ('Byron Xicay', 'byron.xicay@correo.com'),
    ('Cristina Barrios', 'cristina.barrios@correo.com'),
    ('Douglas Pineda', 'douglas.pineda@correo.com');
-- ids esperados 1..5, asignados automaticamente por AUTOINCREMENT.

-- Se elimina un camper (id 3, Byron Xicay) para demostrar que
-- AUTOINCREMENT nunca reutiliza un id ya usado.
DELETE FROM campers WHERE id_camper = 3;

-- Nuevo camper: SQLite le asigna el id 6 (siguiente al maximo historico
-- de sqlite_sequence), NO el id 3 que quedo libre.
INSERT INTO campers (nombre, email) VALUES
    ('Ingrid Say', 'ingrid.say@correo.com');

INSERT INTO inscripciones (id_camper, id_ruta) VALUES
    (1, 1),
    (1, 2),
    (2, 1),
    (4, 3),
    (5, 2),
    (6, 1);

-- Caso que debe fallar (queda comentado): forzar manualmente un id que
-- ya existe viola la PRIMARY KEY (id_camper = 1 ya esta usado).
-- INSERT INTO campers (id_camper, nombre, email) VALUES (1, 'Duplicado', 'duplicado@correo.com');
