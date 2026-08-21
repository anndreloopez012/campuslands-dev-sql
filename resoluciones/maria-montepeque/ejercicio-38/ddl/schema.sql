PRAGMA foreign_keys = ON;

-- Ejercicio 38: Normalizacion Ecommerce Envios
-- Modelo normalizado (3FN): compradores, productos, cupones, ordenes,
-- detalle_orden (tabla puente productos<->ordenes), pagos, envios

CREATE TABLE compradores (
    id_comprador  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre        TEXT NOT NULL UNIQUE
);

CREATE TABLE productos (
    id_producto  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL UNIQUE,
    precio       REAL NOT NULL CHECK (precio > 0)
);

-- Catalogo de cupones. "SIN_CUPON" del CSV original NO se guarda como un
-- cupon mas: se representa como id_cupon = NULL en ordenes (ausencia de
-- cupon), evitando un valor centinela ficticio en el catalogo.
CREATE TABLE cupones (
    id_cupon  INTEGER PRIMARY KEY AUTOINCREMENT,
    codigo    TEXT NOT NULL UNIQUE
);

-- Encabezado de orden: un comprador, con un cupon opcional.
CREATE TABLE ordenes (
    id_orden       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_comprador   INTEGER NOT NULL,
    id_cupon       INTEGER,   -- NULL si la orden no uso cupon

    FOREIGN KEY (id_comprador) REFERENCES compradores (id_comprador),
    FOREIGN KEY (id_cupon) REFERENCES cupones (id_cupon)
);

-- Tabla puente / detalle: una orden puede tener varios productos y un
-- producto puede aparecer en varias ordenes (relacion N:M), con la cantidad
-- y el precio aplicado en esa orden.
CREATE TABLE detalle_orden (
    id_detalle        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_orden          INTEGER NOT NULL,
    id_producto       INTEGER NOT NULL,
    cantidad          INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario   REAL NOT NULL CHECK (precio_unitario > 0),

    FOREIGN KEY (id_orden) REFERENCES ordenes (id_orden),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto),
    UNIQUE (id_orden, id_producto)
);

-- Pago de una orden (relacion 1 a 1: UNIQUE en id_orden evita pagos duplicados)
CREATE TABLE pagos (
    id_pago       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_orden      INTEGER NOT NULL UNIQUE,
    metodo_pago   TEXT NOT NULL CHECK (metodo_pago IN ('Tarjeta', 'Transferencia', 'Efectivo')),
    monto         REAL NOT NULL CHECK (monto > 0),

    FOREIGN KEY (id_orden) REFERENCES ordenes (id_orden)
);

-- Envio de una orden (relacion 1 a 1: UNIQUE en id_orden evita envios duplicados)
CREATE TABLE envios (
    id_envio           INTEGER PRIMARY KEY AUTOINCREMENT,
    id_orden           INTEGER NOT NULL UNIQUE,
    direccion_envio    TEXT NOT NULL,
    transportadora     TEXT NOT NULL CHECK (transportadora IN ('FastShip', 'CargoGT', 'EnvioRapido')),

    FOREIGN KEY (id_orden) REFERENCES ordenes (id_orden)
);
