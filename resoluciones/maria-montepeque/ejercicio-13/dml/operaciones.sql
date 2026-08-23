-- Ejercicio 13: Banco Cuentas
-- Operaciones sobre los datos base

-- 2 INSERT adicionales
INSERT INTO clientes (nombre, dpi, correo) VALUES
    ('Ingrid Say', 'DPI-2006', 'ingrid.say@correo.com');

INSERT INTO transacciones (id_cuenta, tipo, monto, fecha) VALUES
    (2, 'deposito', 250.00, '2026-07-10');

-- 2 UPDATE validos
UPDATE cuentas
SET saldo = saldo + 500.00
WHERE id_cuenta = 1;

UPDATE tarjetas
SET fecha_expira = '2030-01-01'
WHERE id_tarjeta = 4;

-- 2 DELETE controlados con WHERE
DELETE FROM transacciones
WHERE id_transaccion = 10;

DELETE FROM tarjetas
WHERE id_tarjeta = 5;
