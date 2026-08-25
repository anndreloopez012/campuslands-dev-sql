PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS envios;
DROP TABLE IF EXISTS paquetes;
DROP TABLE IF EXISTS rutas;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    documento TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL,
    ciudad TEXT NOT NULL
);

CREATE TABLE rutas (
    id_ruta INTEGER PRIMARY KEY,
    origen TEXT NOT NULL,
    destino TEXT NOT NULL,
    distancia_km REAL NOT NULL CHECK (distancia_km > 0),
    codigo TEXT NOT NULL UNIQUE
);

CREATE TABLE paquetes (
    id_paquete INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    descripcion TEXT NOT NULL,
    peso_kg REAL NOT NULL CHECK (peso_kg > 0),
    codigo TEXT NOT NULL UNIQUE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE envios (
    id_envio INTEGER PRIMARY KEY,
    id_paquete INTEGER NOT NULL,
    id_ruta INTEGER NOT NULL,
    fecha_envio TEXT NOT NULL CHECK (date(fecha_envio) IS NOT NULL),
    costo REAL NOT NULL CHECK (costo > 0),
    estado TEXT NOT NULL CHECK (
        estado IN ('pendiente','en_transito','entregado','cancelado')
    ),
    FOREIGN KEY (id_paquete) REFERENCES paquetes(id_paquete),
    FOREIGN KEY (id_ruta) REFERENCES rutas(id_ruta)
);

CREATE INDEX idx_paquetes_cliente ON paquetes(id_cliente);
CREATE INDEX idx_envios_paquete ON envios(id_paquete);
CREATE INDEX idx_envios_ruta ON envios(id_ruta);
CREATE INDEX idx_envios_estado ON envios(estado);