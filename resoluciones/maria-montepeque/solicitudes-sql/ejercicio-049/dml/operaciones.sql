PRAGMA foreign_keys = ON;

-- Ejercicio 049: Liga Videojuego Futbol
-- Operaciones de mantenimiento: UPDATE de estado (y marcador) y
-- DELETE controlado.

-- 1. El partido 7 (Player_Bruno) se reviso y se confirmo legitimo:
--    se corrige el estado de 'en_revision' a 'jugado' y se registra
--    cuando paso.
UPDATE partidos
SET estado = 'jugado',
    fecha_ultimo_cambio = '2026-08-17'
WHERE id_partido = 7 AND estado = 'en_revision';

-- 2. Al revisar el replay del partido 8 (Player_Rayo), se corrigio el
--    marcador de 4 a 5 goles del usuario; se registra cuando paso la
--    correccion. Se corrige sin borrar nada, tal como pidio el
--    cliente para sus auditorias.
UPDATE partidos
SET goles_usuario = 5,
    fecha_ultimo_cambio = '2026-08-18'
WHERE id_partido = 8;

-- 3. DELETE controlado: solo se borra un partido 'anulado' si nunca
--    genero marcador real (goles_usuario = 0 AND goles_rival = 0).
--    El partido 9 cumple la condicion (se cayo la conexion antes de
--    empezar); el partido 11, que sigue 'en_revision' (no anulado),
--    no se toca.
DELETE FROM partidos
WHERE id_partido = 9
  AND estado = 'anulado'
  AND goles_usuario = 0
  AND goles_rival = 0;

-- 4. Se elimina el partido duplicado (id_partido = 12): es una copia
--    exacta del partido 1 por error de digitacion. DELETE seguro
--    porque usa el id exacto de la fila (error de captura, no una
--    decision de negocio).
DELETE FROM partidos
WHERE id_partido = 12;
