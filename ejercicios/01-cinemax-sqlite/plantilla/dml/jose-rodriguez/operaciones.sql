PRAGMA foreign_keys = ON;

UPDATE funciones
SET precio = 95.00
WHERE id_funcion = 3;

UPDATE salas
SET capacidad = 170
WHERE id_sala = 2;

DELETE FROM boletos
WHERE id_boleto = 3;

DELETE FROM funciones WHERE id_funcion = 5;
