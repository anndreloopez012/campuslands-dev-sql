PRAGMA foreign_keys = ON;

-- Ejercicio 60: DEFAULT Nivel Intermedio
-- Datos de prueba para validar el tema DEFAULT.

-- Casos con TODOS los valores explicitos (no dependen de ningun DEFAULT):
-- sirven de contraste contra los casos que si usan DEFAULT.
INSERT INTO campers (nombre, email, nivel, activo, fecha_registro) VALUES
    ('Karen Solis', 'karen.solis@campus.com', 'avanzado', 1, '2026-05-10'),
    ('Mario Ixtabalan', 'mario.ixtabalan@campus.com', 'intermedio', 0, '2026-05-15');

-- Casos validos que usan DEFAULT: se omiten nivel, activo y
-- fecha_registro a proposito para que la base los complete sola.
INSERT INTO campers (nombre, email) VALUES
    ('Ana Gomez', 'ana.gomez@campus.com'),
    ('Luis Marroquin', 'luis.marroquin@campus.com'),
    ('Rosa Chavez', 'rosa.chavez@campus.com');

-- Ruta con cupo_maximo explicito, y ruta que usa el DEFAULT de cantidad.
INSERT INTO rutas (nombre_ruta, cupo_maximo) VALUES
    ('Cumbre Extrema', 4);
INSERT INTO rutas (nombre_ruta) VALUES
    ('Sendero del Canon'),
    ('Ruta del Volcan');

-- Inscripciones con estado y fecha explicitos.
INSERT INTO inscripciones (id_camper, id_ruta, estado, fecha_inscripcion) VALUES
    (1, 1, 'completada', '2026-06-01 08:00:00'),
    (2, 2, 'cancelada', '2026-06-02 08:00:00');

-- Inscripciones validas que usan DEFAULT: se omiten estado y
-- fecha_inscripcion, la base las completa como 'activa' y con la fecha
-- actual.
INSERT INTO inscripciones (id_camper, id_ruta) VALUES
    (3, 2),
    (4, 3),
    (5, 1);

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- escribir el nivel a mano en vez de dejar que DEFAULT lo complete, y
-- equivocarse en el texto (typo), viola el CHECK de nivel.
-- INSERT INTO campers (nombre, email, nivel) VALUES ('Diego Paz', 'diego.paz@campus.com', 'avansado');
