PRAGMA foreign_keys = ON;

-- Ejercicio 055: Cine Horror Nights
-- Operaciones de mantenimiento: UPDATE de estado y DELETE controlado.

-- 1. La funcion de Posesion Nocturna en Sala 2 (id_funcion = 4)
--    termino: se corrige el estado de 'en_curso' a 'finalizada'.
UPDATE funciones
SET estado = 'finalizada'
WHERE id_funcion = 4 AND estado = 'en_curso';

-- 2. La funcion de Munecas de Porcelana (id_funcion = 5) comenzo: se
--    corrige el estado de 'programada' a 'en_curso'.
UPDATE funciones
SET estado = 'en_curso'
WHERE id_funcion = 5 AND estado = 'programada';

-- 3. DELETE controlado: solo se borran boletos 'reembolsado' cuya
--    funcion todavia este 'programada' o 'cancelada' (no se ha
--    proyectado). Los boletos de las funciones 6 y 7 cumplen la
--    condicion; el boleto reembolsado de la funcion 1 (ya
--    'finalizada') no se toca, porque esa funcion ya se proyecto y
--    el boleto es historial de auditoria.
DELETE FROM boletos
WHERE estado = 'reembolsado'
  AND EXISTS (
      SELECT 1 FROM funciones
      WHERE funciones.id_funcion = boletos.id_funcion
        AND funciones.estado IN ('programada', 'cancelada')
  );

-- 4. Se elimina la funcion duplicada (id_funcion = 9): es una copia
--    exacta de la funcion 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila (error de captura, no una
--    decision de negocio); no tiene boletos propios asociados, asi
--    que no deja huerfanos.
DELETE FROM funciones
WHERE id_funcion = 9;
