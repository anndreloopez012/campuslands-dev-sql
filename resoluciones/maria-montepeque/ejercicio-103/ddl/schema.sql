PRAGMA foreign_keys = ON;

-- Ejercicio 103: Procedimientos almacenados Nivel Aplicado
-- Tema central: Procedimientos almacenados
-- Contexto: agenda de citas medicas programadas por fecha.

CREATE TABLE pacientes (
    id_paciente      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_paciente  TEXT NOT NULL,
    telefono         TEXT NOT NULL UNIQUE
);

CREATE TABLE medicos (
    id_medico       INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_medico   TEXT NOT NULL UNIQUE,
    especialidad    TEXT NOT NULL
);

CREATE TABLE citas (
    id_cita        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_paciente    INTEGER NOT NULL,
    id_medico      INTEGER NOT NULL,
    fecha_cita     TEXT NOT NULL,
    hora_cita      TEXT NOT NULL,
    estado         TEXT NOT NULL DEFAULT 'programada'
                       CHECK (estado IN ('programada', 'cancelada', 'atendida')),

    FOREIGN KEY (id_paciente) REFERENCES pacientes (id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medicos (id_medico)
);

-- =====================================================================
-- Procedimientos almacenados: SQLite no soporta CREATE PROCEDURE.
-- Aqui se documenta, como comentario, el procedimiento TEORICO
-- equivalente para MySQL y PostgreSQL: el caso de negocio final de
-- una agenda de citas es evitar que un mismo medico quede agendado
-- dos veces en la misma fecha y hora (choque de agenda). El
-- procedimiento valida esa condicion ANTES de insertar la cita y
-- cancela la operacion si ya existe un choque. Mas abajo se
-- implementa la alternativa SI ejecutable en SQLite con un TRIGGER.
-- =====================================================================

-- --- Version teorica MySQL ---
-- DELIMITER $$
-- CREATE PROCEDURE agendar_cita (
--     IN p_id_paciente  INT,
--     IN p_id_medico    INT,
--     IN p_fecha_cita   DATE,
--     IN p_hora_cita    TIME
-- )
-- BEGIN
--     DECLARE v_choques INT;
--
--     SELECT COUNT(*) INTO v_choques
--     FROM citas
--     WHERE id_medico = p_id_medico
--       AND fecha_cita = p_fecha_cita
--       AND hora_cita = p_hora_cita
--       AND estado = 'programada';
--
--     IF v_choques > 0 THEN
--         SIGNAL SQLSTATE '45000'
--             SET MESSAGE_TEXT = 'El medico ya tiene una cita programada en esa fecha y hora';
--     ELSE
--         INSERT INTO citas (id_paciente, id_medico, fecha_cita, hora_cita)
--         VALUES (p_id_paciente, p_id_medico, p_fecha_cita, p_hora_cita);
--     END IF;
-- END $$
-- DELIMITER ;
--
-- -- Uso: CALL agendar_cita(1, 1, '2026-09-01', '09:00');

-- --- Version teorica PostgreSQL ---
-- CREATE OR REPLACE PROCEDURE agendar_cita (
--     p_id_paciente  INT,
--     p_id_medico    INT,
--     p_fecha_cita   DATE,
--     p_hora_cita    TIME
-- )
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN
--     IF EXISTS (
--         SELECT 1 FROM citas
--         WHERE id_medico = p_id_medico
--           AND fecha_cita = p_fecha_cita
--           AND hora_cita = p_hora_cita
--           AND estado = 'programada'
--     ) THEN
--         RAISE EXCEPTION 'El medico ya tiene una cita programada en esa fecha y hora';
--     END IF;
--
--     INSERT INTO citas (id_paciente, id_medico, fecha_cita, hora_cita)
--     VALUES (p_id_paciente, p_id_medico, p_fecha_cita, p_hora_cita);
-- END;
-- $$;
--
-- -- Uso: CALL agendar_cita(1, 1, '2026-09-01', '09:00');

-- --- Alternativa ejecutable en SQLite: TRIGGER "BEFORE INSERT" ---
-- La misma validacion de choque de agenda, aplicada automaticamente
-- antes de cada INSERT en "citas". Si ya existe una cita programada
-- para el mismo medico, en la misma fecha y hora, el trigger aborta
-- la operacion completa con RAISE(ABORT, ...) y la nueva cita nunca
-- llega a registrarse.
CREATE TRIGGER trg_validar_choque_agenda
BEFORE INSERT ON citas
FOR EACH ROW
WHEN EXISTS (
    SELECT 1 FROM citas c
    WHERE c.id_medico = NEW.id_medico
      AND c.fecha_cita = NEW.fecha_cita
      AND c.hora_cita = NEW.hora_cita
      AND c.estado = 'programada'
)
BEGIN
    SELECT RAISE(ABORT, 'El medico ya tiene una cita programada en esa fecha y hora');
END;
