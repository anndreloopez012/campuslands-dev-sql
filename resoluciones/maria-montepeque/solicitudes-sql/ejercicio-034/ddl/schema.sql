PRAGMA foreign_keys = ON;

-- Ejercicio 034: Estudio Animacion 3D
-- Modelo: dos catalogos independientes (clientes, artistas) que
-- alimentan una tabla de movimientos (proyectos) con dos FOREIGN KEY.

CREATE TABLE clientes (
    id_cliente     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente TEXT NOT NULL UNIQUE,
    email          TEXT NOT NULL
);

CREATE TABLE artistas (
    id_artista     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_artista TEXT NOT NULL UNIQUE,
    especialidad   TEXT NOT NULL CHECK (especialidad IN ('modelado', 'animacion', 'texturizado', 'iluminacion'))
);

-- proyectos: tabla principal. NOT NULL en los campos que, si faltaran,
-- romperian el reporte semanal que pide el cliente.
CREATE TABLE proyectos (
    id_proyecto     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente      INTEGER NOT NULL,
    id_artista      INTEGER NOT NULL,
    nombre_proyecto TEXT NOT NULL,
    fecha_entrega   TEXT NOT NULL,
    presupuesto     REAL NOT NULL CHECK (presupuesto > 0),
    estado          TEXT NOT NULL DEFAULT 'pendiente' CHECK (estado IN ('pendiente', 'en_progreso', 'en_revision', 'finalizado', 'cancelado')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_artista) REFERENCES artistas (id_artista)
);
