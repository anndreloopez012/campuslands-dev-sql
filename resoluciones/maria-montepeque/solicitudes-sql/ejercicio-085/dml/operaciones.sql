PRAGMA foreign_keys = ON;

-- Ejercicio 085: Biblioteca Sci-Fi
-- Operaciones de mantenimiento sobre los datos base.

-- 1 DELETE controlado: la devolucion del prestamo 2 se registro por
-- error (Bryan Solis todavia no ha devuelto Fundacion). Se elimina
-- porque fue un error de captura confirmado.
DELETE FROM devoluciones
WHERE id_prestamo = 2;

-- 1 UPDATE de estado: el prestamo 4 (Jorge Cifuentes, 1984) paso su
-- fecha de devolucion esperada sin que el libro volviera, se marca
-- como atrasado.
UPDATE prestamos
SET estado = 'atrasado'
WHERE id_prestamo = 4 AND estado = 'prestado';

-- Caso que debe fallar / no ser recomendable (queda comentado):
-- borrar una devolucion real ya confirmada, por ejemplo la del
-- prestamo 1. El historico real de devoluciones no se borra.
-- DELETE FROM devoluciones WHERE id_prestamo = 1;
