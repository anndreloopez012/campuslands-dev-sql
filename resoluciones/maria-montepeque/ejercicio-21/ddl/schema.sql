PRAGMA foreign_keys = ON;

-- Ejercicio 21: Logistica Envios
-- Modelo: clientes, paquetes, rutas, envios

CREATE TABLE clientes (
    id_cliente  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    telefono    TEXT NOT NULL UNIQUE,
    correo      TEXT NOT NULL UNIQUE
);

CREATE TABLE paquetes (
    id_paquete    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente    INTEGER NOT NULL,
    descripcion   TEXT NOT NULL,
    peso          REAL NOT NULL CHECK (peso > 0),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

CREATE TABLE rutas (
    id_ruta        INTEGER PRIMARY KEY AUTOINCREMENT,
    origen         TEXT NOT NULL,
    destino        TEXT NOT NULL,
    distancia_km   REAL NOT NULL CHECK (distancia_km > 0),

    UNIQUE (origen, destino)
);

CREATE TABLE envios (
    id_envio      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_paquete    INTEGER NOT NULL,
    id_ruta       INTEGER NOT NULL,
    fecha_envio   TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'
    estado        TEXT NOT NULL CHECK (estado IN ('pendiente', 'en_transito', 'entregado', 'cancelado')),
    costo         REAL NOT NULL CHECK (costo > 0),

    FOREIGN KEY (id_paquete) REFERENCES paquetes (id_paquete),
    FOREIGN KEY (id_ruta) REFERENCES rutas (id_ruta)
);
