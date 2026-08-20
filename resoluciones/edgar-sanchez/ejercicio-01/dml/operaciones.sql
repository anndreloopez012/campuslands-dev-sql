PRAGMA foreign_keys = ON;

-- 2 Operaciones INSERT adicionales
INSERT INTO funciones (pelicula_id, sala_id, fecha_hora_inicio, precio_boleto) VALUES
(5, 3, '2026-08-26 16:00', 70.00);

INSERT INTO boletos (funcion_id, numero_asiento, fecha_venta, metodo_pago, monto_pagado) VALUES
(6, 'VIP-01', '2026-08-20 16:05', 'Tarjeta', 70.00);

-- 2 Operaciones UPDATE validas
UPDATE salas 
SET capacidad_asientos = 160 
WHERE sala_id = 1;

UPDATE funciones 
SET precio_boleto = 58.00 
WHERE funcion_id = 2;

-- 2 Operaciones DELETE controladas
DELETE FROM boletos 
WHERE boleto_id = 10;

DELETE FROM funciones 
WHERE funcion_id = 5;

-- 2 Operaciones comentadas que fallan por restricciones:

-- Fallo 1: Violacion de restriccion UNIQUE (Misma sala y fecha/hora de inicio)
-- INSERT INTO funciones (pelicula_id, sala_id, fecha_hora_inicio, precio_boleto) 
-- VALUES (2, 1, '2026-08-25 14:00', 45.00);

-- Fallo 2: Violacion de restriccion CHECK (Metodo de pago no permitido)
-- INSERT INTO boletos (funcion_id, numero_asiento, fecha_venta, metodo_pago, monto_pagado) 
-- VALUES (1, 'Z99', '2026-08-20 17:00', 'Cripto', 50.00);