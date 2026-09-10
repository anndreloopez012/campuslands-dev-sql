PRAGMA foreign_keys = ON;

-- Ejercicio 106: Triggers Nivel Aplicado
-- Tema central: Triggers
-- Contexto: torneo de videojuegos, equipos y sus partidas.

CREATE TABLE equipos (
    id_equipo       INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_equipo   TEXT NOT NULL UNIQUE,
    puntaje_total   INTEGER NOT NULL DEFAULT 0 CHECK (puntaje_total >= 0)
);

CREATE TABLE jugadores (
    id_jugador      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo       INTEGER NOT NULL,
    nombre_jugador  TEXT NOT NULL,
    gamer_tag       TEXT NOT NULL UNIQUE,

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);

CREATE TABLE partidas (
    id_partida      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_equipo       INTEGER NOT NULL,
    puntaje         INTEGER NOT NULL CHECK (puntaje >= 0),
    fecha_partida   TEXT NOT NULL,
    resultado       TEXT NOT NULL DEFAULT 'pendiente'
                        CHECK (resultado IN ('victoria', 'derrota', 'empate', 'pendiente')),

    FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
);

-- =====================================================================
-- Caso de negocio: la tabla de posiciones del torneo necesita el
-- puntaje total de cada equipo actualizado en todo momento, sin tener
-- que recalcular SUM(puntaje) sobre "partidas" cada vez que alguien
-- consulta el ranking. equipos.puntaje_total es una columna
-- desnormalizada (una copia calculada), y estos 3 triggers son los
-- que la mantienen sincronizada automaticamente ante los 3 eventos
-- posibles sobre "partidas": INSERT, UPDATE y DELETE.
-- =====================================================================

-- Trigger 1: al registrar una partida nueva, suma su puntaje al
-- equipo correspondiente.
CREATE TRIGGER trg_sumar_puntaje_partida_insert
AFTER INSERT ON partidas
FOR EACH ROW
BEGIN
    UPDATE equipos
    SET puntaje_total = puntaje_total + NEW.puntaje
    WHERE id_equipo = NEW.id_equipo;
END;

-- Trigger 2: al corregir el puntaje de una partida existente, ajusta
-- el total del equipo solo por la diferencia (nuevo menos anterior).
CREATE TRIGGER trg_ajustar_puntaje_partida_update
AFTER UPDATE OF puntaje ON partidas
FOR EACH ROW
WHEN OLD.puntaje <> NEW.puntaje
BEGIN
    UPDATE equipos
    SET puntaje_total = puntaje_total + (NEW.puntaje - OLD.puntaje)
    WHERE id_equipo = NEW.id_equipo;
END;

-- Trigger 3: al eliminar una partida, resta su puntaje del equipo.
CREATE TRIGGER trg_restar_puntaje_partida_delete
AFTER DELETE ON partidas
FOR EACH ROW
BEGIN
    UPDATE equipos
    SET puntaje_total = puntaje_total - OLD.puntaje
    WHERE id_equipo = OLD.id_equipo;
END;
