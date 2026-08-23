PRAGMA foreign_keys = ON;

-- Ejercicio 017: Streaming Musica
-- Datos de prueba.

INSERT INTO artistas (nombre_artista, genero_principal) VALUES
    ('Luna Estrella', 'pop'),
    ('Los Rockeros', 'rock'),
    ('DJ Pulso', 'electronica'),
    ('Ritmo Tropical', 'reggaeton'),
    ('Trio Azul', 'jazz');

-- La cancion 9 es una entrada de prueba ("Cancion de Prueba") que se
-- cargo por error: se elimina en dml/operaciones.sql. Es la UNICA fila
-- que se elimina; el resto de casos especiales (retirada, bloqueada) se
-- resuelven corrigiendo el estado, no borrando el registro.
INSERT INTO canciones (id_artista, titulo, duracion_segundos, fecha_lanzamiento, estado) VALUES
    (1, 'Brillo de Luna', 210, '2025-01-15', 'disponible'),
    (2, 'Trueno Electrico', 245, '2025-02-20', 'disponible'),
    (3, 'Pulso Nocturno', 198, '2025-03-10', 'bloqueada_por_derechos'),
    (1, 'Cielo Infinito', 200, '2025-04-05', 'disponible'),
    (4, 'Calor Tropical', 220, '2025-05-12', 'disponible'),
    (2, 'Furia de Acero', 260, '2025-06-01', 'retirada_temporalmente'),
    (5, 'Noches de Jazz', 300, '2025-07-08', 'disponible'),
    (3, 'Bass Infinito', 215, '2025-08-01', 'disponible'),
    (1, 'Cancion de Prueba', 100, '2025-01-15', 'disponible');

-- Caso comentado que debe fallar (no ser recomendable), dejar comentado:
-- duracion_segundos en cero, viola el CHECK de canciones.
-- INSERT INTO canciones (id_artista, titulo, duracion_segundos) VALUES (2, 'Silencio Total', 0);
