PRAGMA foreign_keys = ON;

-- Ejercicio 080: Cine Horror Nights
-- Datos base: 2 peliculas, 2 salas, 4 funciones (2 finalizadas, 1
-- finalizada-por-error que se corrige despues, 1 programada), 6
-- boletos (incluye 1 sin pagar en la funcion que se cancela) y 5
-- pagos.

INSERT INTO peliculas (titulo, clasificacion, duracion_minutos) VALUES
    ('La Noche del Espanto', 'R', 105),
    ('Grito Eterno', 'PG-13', 98);

INSERT INTO salas (nombre_sala, capacidad) VALUES
    ('Sala Terror 1', 50),
    ('Sala Terror 2', 80);

-- Funcion 1: La Noche del Espanto, Sala Terror 1, finalizada.
INSERT INTO funciones (id_pelicula, id_sala, fecha_funcion, hora_funcion, estado) VALUES
    (1, 1, '2026-08-01', '20:00', 'finalizada');

-- Funcion 2: Grito Eterno, Sala Terror 2, finalizada.
INSERT INTO funciones (id_pelicula, id_sala, fecha_funcion, hora_funcion, estado) VALUES
    (2, 2, '2026-08-01', '22:00', 'finalizada');

-- Funcion 3: La Noche del Espanto, Sala Terror 1. Se marco
-- 'finalizada' y se vendio un boleto, pero el proyector fallo y la
-- funcion se cancelo despues. Se corrige en dml/operaciones.sql.
INSERT INTO funciones (id_pelicula, id_sala, fecha_funcion, hora_funcion, estado) VALUES
    (1, 1, '2026-08-02', '20:00', 'finalizada');

-- Funcion 4: Grito Eterno, Sala Terror 2, todavia no se proyecta.
INSERT INTO funciones (id_pelicula, id_sala, fecha_funcion, hora_funcion, estado) VALUES
    (2, 2, '2026-08-03', '20:00', 'programada');

-- Boletos de la funcion 1.
INSERT INTO boletos (id_funcion, asiento, precio) VALUES
    (1, 'A1', 45.00),
    (1, 'A2', 45.00),
    (1, 'A3', 45.00);

-- Boletos de la funcion 2.
INSERT INTO boletos (id_funcion, asiento, precio) VALUES
    (2, 'B1', 50.00),
    (2, 'B2', 50.00);

-- Boleto de la funcion 3, vendido antes de saber que el proyector
-- habia fallado. Todavia no tiene pago registrado; se elimina en
-- dml/operaciones.sql cuando la funcion se cancela.
INSERT INTO boletos (id_funcion, asiento, precio) VALUES
    (3, 'A1', 45.00);

-- Pagos de los 5 boletos de las funciones 1 y 2 (el boleto de la
-- funcion 3 se queda sin pago, por diseno).
INSERT INTO pagos (id_boleto, monto, metodo_pago) VALUES
    (1, 45.00, 'tarjeta'),
    (2, 45.00, 'efectivo'),
    (3, 45.00, 'tarjeta'),
    (4, 50.00, 'tarjeta'),
    (5, 50.00, 'efectivo');

-- Caso comentado que debe fallar (queda comentado): vender de nuevo
-- el asiento A1 de la funcion 1, exactamente el problema que este
-- UNIQUE esta disenado para evitar.
-- INSERT INTO boletos (id_funcion, asiento, precio) VALUES (1, 'A1', 45.00);
