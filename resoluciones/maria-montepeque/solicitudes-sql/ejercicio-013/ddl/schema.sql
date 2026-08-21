PRAGMA foreign_keys = ON;

-- Ejercicio 013: Clinica de Tatuajes
-- Modelo minimo: catalogo de artistas y registro de sesiones.

CREATE TABLE artistas (
    id_artista       INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_artista   TEXT NOT NULL UNIQUE,
    estilo_principal TEXT NOT NULL CHECK (estilo_principal IN ('realismo', 'tradicional', 'blackwork', 'acuarela', 'minimalista'))
);

-- sesiones: tabla principal. NOT NULL en los campos que, si faltaran,
-- romperian un reporte confiable (la queja central del cliente).
CREATE TABLE sesiones (
    id_sesion      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_artista     INTEGER NOT NULL,
    nombre_cliente TEXT NOT NULL,
    fecha_sesion   TEXT NOT NULL,
    monto_pagado   REAL NOT NULL CHECK (monto_pagado > 0),
    estado         TEXT NOT NULL DEFAULT 'agendada' CHECK (estado IN ('agendada', 'completada', 'cancelada')),

    FOREIGN KEY (id_artista) REFERENCES artistas (id_artista)
);
