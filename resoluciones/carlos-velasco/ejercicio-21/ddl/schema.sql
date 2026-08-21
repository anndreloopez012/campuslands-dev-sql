PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS envios;
DROP TABLE IF EXISTS paquetes;
DROP TABLE IF EXISTS rutas;
DROP TABLE IF EXISTS clientes;

-- CLIENTES

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL,
    ciudad TEXT NOT NULL
);

-- RUTAS

CREATE TABLE rutas (
    id_ruta INTEGER PRIMARY KEY,
    origen TEXT NOT NULL,
    destino TEXT NOT NULL,
    distancia_km REAL NOT NULL CHECK (distancia_km > 0),
    UNIQUE (origen, destino),
    CHECK (origen <> destino)
);

-- PAQUETES

CREATE TABLE paquetes (
    id_paquete INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    peso_kg REAL NOT NULL CHECK (peso_kg > 0),
    tipo TEXT NOT NULL CHECK (tipo IN ('DOCUMENTO', 'CAJA', 'SOBRE')),
    descripcion TEXT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- ENVIOS

CREATE TABLE envios (
    id_envio INTEGER PRIMARY KEY,
    id_paquete INTEGER NOT NULL,
    id_ruta INTEGER NOT NULL,
    fecha_envio TEXT NOT NULL,
    fecha_entrega TEXT,
    estado TEXT NOT NULL DEFAULT 'PENDIENTE'
        CHECK (estado IN ('PENDIENTE', 'EN_TRANSITO', 'ENTREGADO', 'CANCELADO')),
    costo REAL NOT NULL CHECK (costo > 0),
    FOREIGN KEY (id_paquete) REFERENCES paquetes(id_paquete)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (id_ruta) REFERENCES rutas(id_ruta)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CHECK (fecha_entrega IS NULL OR fecha_entrega >= fecha_envio)
);

CREATE INDEX idx_paquetes_cliente
ON paquetes(id_cliente);

CREATE INDEX idx_envios_paquete
ON envios(id_paquete);

CREATE INDEX idx_envios_ruta
ON envios(id_ruta);

CREATE INDEX idx_envios_estado
ON envios(estado);