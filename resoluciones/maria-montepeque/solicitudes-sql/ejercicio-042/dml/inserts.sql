PRAGMA foreign_keys = ON;

-- Ejercicio 042: Streaming Musica
-- Datos de prueba.

INSERT INTO artistas (nombre_artista, genero) VALUES
    ('Luna Marbella', 'pop'),
    ('Los Cerrones', 'rock'),
    ('DJ Kaqchikel', 'electronica'),
    ('Valeria Norte', 'pop'),
    ('Trio Ceibal', 'jazz');

INSERT INTO canciones (titulo, id_artista, duracion_segundos) VALUES
    ('Luz de Neon', 1, 210),
    ('Carretera Sola', 2, 245),
    ('Pulso Digital', 3, 198),
    ('Horizonte Verde', 4, 230),
    ('Noche de Jazz', 5, 265),
    ('Eco de Ciudad', 1, 200),
    ('Bajo el Volcan', 2, 220),
    ('Circuito Cerrado', 3, 205);

INSERT INTO usuarios (nombre_usuario, email, plan) VALUES
    ('Camila Rios', 'camila.rios@correo.com', 'premium'),
    ('Esteban Coy', 'esteban.coy@correo.com', 'gratuito'),
    ('Natalia Boror', 'natalia.boror@correo.com', 'premium'),
    ('Julio Herrera', 'julio.herrera@correo.com', 'gratuito'),
    ('Priscila Ajanel', 'priscila.ajanel@correo.com', 'premium');

-- La reproduccion 11 es un duplicado por error de digitacion (mismo
-- usuario, cancion, fecha, monto y estado que la reproduccion 1): se
-- corrige en dml/operaciones.sql. Las reproducciones 9, 10 y 12
-- nacen 'en_revision' para demostrar el flujo de correccion de
-- estados y el DELETE controlado.
INSERT INTO reproducciones (id_usuario, id_cancion, fecha_reproduccion, monto_regalia, estado) VALUES
    (1, 1, '2026-08-01', 0.0045, 'contabilizada'),
    (2, 2, '2026-08-01', 0.0010, 'contabilizada'),
    (3, 3, '2026-08-02', 0.0045, 'contabilizada'),
    (1, 4, '2026-08-02', 0.0045, 'contabilizada'),
    (4, 1, '2026-08-03', 0.0010, 'contabilizada'),
    (5, 5, '2026-08-03', 0.0045, 'contabilizada'),
    (1, 6, '2026-08-04', 0.0045, 'contabilizada'),
    (2, 3, '2026-08-04', 0.0010, 'contabilizada'),
    (3, 7, '2026-08-05', 0.0045, 'en_revision'),
    (1, 1, '2026-08-06', 0.0200, 'en_revision'),
    (1, 1, '2026-08-01', 0.0045, 'contabilizada'),
    (4, 8, '2026-08-07', 0.0010, 'en_revision');

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados:

-- 1) Registro repetido: mismo titulo para el mismo artista, viola el UNIQUE compuesto.
-- INSERT INTO canciones (titulo, id_artista, duracion_segundos) VALUES ('Luz de Neon', 1, 200);

-- 2) Valor fuera de rango: duracion_segundos = 0 no es una cancion valida, viola el CHECK.
-- INSERT INTO canciones (titulo, id_artista, duracion_segundos) VALUES ('Silencio Total', 2, 0);
