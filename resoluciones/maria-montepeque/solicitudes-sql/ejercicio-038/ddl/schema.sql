PRAGMA foreign_keys = ON;

-- Ejercicio 038: Clinica de Tatuajes
-- Modelo: dos catalogos independientes (clientes, artistas) que
-- alimentan una tabla de movimientos (sesiones) con dos FOREIGN KEY.

CREATE TABLE clientes (
    id_cliente     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente TEXT NOT NULL UNIQUE,
    telefono       TEXT NOT NULL
);

CREATE TABLE artistas (
    id_artista     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_artista TEXT NOT NULL UNIQUE,
    estilo         TEXT NOT NULL CHECK (estilo IN ('realismo', 'tradicional', 'blackwork', 'acuarela', 'minimalista'))
);

-- sesiones: tabla principal. costo_total y monto_pagado permiten
-- calcular el saldo pendiente sin necesidad de una tabla de pagos
-- aparte (ver supuestos en analisis/requerimiento.md).
CREATE TABLE sesiones (
    id_sesion     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente    INTEGER NOT NULL,
    id_artista    INTEGER NOT NULL,
    fecha_sesion  TEXT NOT NULL,
    costo_total   REAL NOT NULL CHECK (costo_total > 0),
    monto_pagado  REAL NOT NULL DEFAULT 0 CHECK (monto_pagado >= 0 AND monto_pagado <= costo_total),
    estado        TEXT NOT NULL DEFAULT 'agendada' CHECK (estado IN ('agendada', 'completada', 'cancelada')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_artista) REFERENCES artistas (id_artista)
);
