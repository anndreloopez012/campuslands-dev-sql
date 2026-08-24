PRAGMA foreign_keys = ON;

-- Ejercicio 070: Soldadura Industrial
-- Datos de prueba.

INSERT INTO clientes (nombre_cliente, telefono) VALUES
    ('Constructora Los Pinos', '5555-9001'),
    ('Metalurgica Sur', '5555-9002'),
    ('Talleres Andrade', '5555-9003');

INSERT INTO tecnicos (nombre_tecnico, especialidad) VALUES
    ('Hugo Marroquin', 'soldadura MIG'),
    ('Cristina Barrios', 'soldadura TIG'),
    ('Esteban Cifuentes', 'soldadura por arco');

INSERT INTO ordenes (id_cliente, id_tecnico, descripcion, fecha_orden, estado) VALUES
    (1, 1, 'Reparacion de estructura metalica de bodega', '2026-08-01', 'finalizada'),
    (2, 2, 'Fabricacion de portones industriales', '2026-08-03', 'en_proceso'),
    (3, 1, 'Refuerzo de vigas de techo', '2026-08-05', 'pendiente'),
    (1, 3, 'Soldadura de tuberia de gas', '2026-08-06', 'cancelada');

INSERT INTO materiales (id_orden, nombre_material, cantidad, costo_unitario) VALUES
    (1, 'Electrodo 6011', 20, 3.50),
    (1, 'Lamina de acero 3mm', 4, 45.00),
    (2, 'Electrodo 7018', 30, 4.20),
    (2, 'Tubo cuadrado 2x2', 6, 28.75),
    (3, 'Lamina de acero 5mm', 2, 60.00);

-- Material cargado dos veces por error de digitacion en la orden 2
-- (mismo material, misma cantidad, mismo costo): es el unico caso de
-- este modelo donde un DELETE real es aceptable, porque la orden 2
-- todavia no tiene ninguna inspeccion asociada (se corrige en
-- dml/operaciones.sql).
INSERT INTO materiales (id_orden, nombre_material, cantidad, costo_unitario) VALUES
    (2, 'Electrodo 7018', 30, 4.20);

-- inspecciones: historico de calidad de cada orden.
INSERT INTO inspecciones (id_orden, resultado, observaciones) VALUES
    (1, 'aprobada', 'Estructura verificada, sin observaciones'),
    (1, 'aprobada', 'Segunda revision de cierre de proyecto'),
    (3, 'rechazada', 'Falta reforzar dos uniones antes de continuar');

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados. Cada uno demuestra uno de los tres errores que pidio
-- detectar el cliente:

-- 1) Registro repetido: nombre_cliente ya existe, viola el UNIQUE.
-- INSERT INTO clientes (nombre_cliente, telefono) VALUES ('Constructora Los Pinos', '5555-9099');

-- 2) Relacion invalida: id_tecnico = 99 no existe, viola el FOREIGN KEY.
-- INSERT INTO ordenes (id_cliente, id_tecnico, descripcion) VALUES (1, 99, 'Orden con tecnico inexistente');

-- 3) Valor fuera de rango: cantidad negativa, viola el CHECK.
-- INSERT INTO materiales (id_orden, nombre_material, cantidad, costo_unitario) VALUES (1, 'Electrodo 6011', -5, 3.50);
