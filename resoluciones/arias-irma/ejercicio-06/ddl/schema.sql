PRAGMA foreign_keys = ON;

-- 1. Tabla de Equipos
CREATE TABLE equipos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE,
    region TEXT NOT NULL,
    anio_fundacion INTEGER NOT NULL CHECK (anio_fundacion > 2000)
);

-- 2. Tabla de Jugadores (Relacionada con Equipos)
CREATE TABLE jugadores (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    equipo_id INTEGER NOT NULL,
    gamertag TEXT NOT NULL UNIQUE,
    rol TEXT NOT NULL,
    edad INTEGER NOT NULL CHECK (edad >= 16),
    FOREIGN KEY (equipo_id) REFERENCES equipos(id) ON DELETE RESTRICT
);

-- 3. Tabla de Partidas
CREATE TABLE partidas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    fase TEXT NOT NULL,
    fecha_hora TEXT NOT NULL, -- Formato ISO YYYY-MM-DD HH:MM
    mapa TEXT NOT NULL
);

-- 4. Tabla de Resultados (Tabla transaccional: relaciona Partidas y Equipos)
CREATE TABLE resultados (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    partida_id INTEGER NOT NULL,
    equipo_id INTEGER NOT NULL,
    puntuacion INTEGER NOT NULL CHECK (puntuacion >= 0),
    resultado TEXT NOT NULL CHECK (resultado IN ('victoria', 'derrota', 'empate')),
    FOREIGN KEY (partida_id) REFERENCES partidas(id) ON DELETE CASCADE,
    FOREIGN KEY (equipo_id) REFERENCES equipos(id) ON DELETE RESTRICT
);