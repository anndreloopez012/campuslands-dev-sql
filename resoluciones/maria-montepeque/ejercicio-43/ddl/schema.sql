PRAGMA foreign_keys = ON;

-- Ejercicio 43: Tipos de datos Nivel Aplicado
-- Tema central: Tipos de datos
-- Contexto: ventas diarias de una cafeteria.

-- clientes: catalogo de clientes registrados (las ventas a clientes no
-- registrados quedan con id_cliente = NULL, ver tabla ventas).
CREATE TABLE clientes (
    id_cliente        INTEGER PRIMARY KEY AUTOINCREMENT,   -- INTEGER
    nombre            TEXT NOT NULL,                        -- TEXT
    correo            TEXT UNIQUE,                           -- TEXT, opcional (no todos los clientes lo dan)

    -- DATE simulado: TEXT en formato ISO 'YYYY-MM-DD', validado con CHECK.
    fecha_registro    TEXT NOT NULL CHECK (fecha_registro GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),

    -- BOOLEAN simulado: INTEGER 0/1 con CHECK + DEFAULT.
    frecuente         INTEGER NOT NULL DEFAULT 0 CHECK (frecuente IN (0, 1))
);

-- productos: catalogo del menu.
CREATE TABLE productos (
    id_producto    INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre         TEXT NOT NULL UNIQUE,
    categoria      TEXT NOT NULL CHECK (categoria IN ('Bebida', 'Comida', 'Postre')),   -- TEXT restringido (enum simulado)
    precio         REAL NOT NULL CHECK (precio > 0),                                     -- REAL: precio con decimales
    disponible     INTEGER NOT NULL DEFAULT 1 CHECK (disponible IN (0, 1))                -- BOOLEAN simulado
);

-- ventas: tabla transaccional, concentra todos los tipos de dato del tema.
CREATE TABLE ventas (
    id_venta           INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente         INTEGER,                              -- INTEGER, NULLABLE: venta a cliente no registrado
    id_producto        INTEGER NOT NULL,
    cantidad           INTEGER NOT NULL CHECK (cantidad > 0),  -- INTEGER: unidades vendidas
    precio_unitario    REAL NOT NULL CHECK (precio_unitario > 0),   -- REAL: precio cobrado en ese momento

    -- DATE simulado.
    fecha_venta        TEXT NOT NULL CHECK (fecha_venta GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),

    -- TIME simulado: SQLite tampoco tiene TIME nativo. Se usa TEXT en
    -- formato 'HH:MM' (24 horas), validado con CHECK + GLOB. Igual que con
    -- DATE, este formato ordena correctamente como texto.
    hora_venta         TEXT NOT NULL CHECK (hora_venta GLOB '[0-2][0-9]:[0-5][0-9]'),

    -- BOOLEAN simulado: forma de pago.
    pagado_tarjeta     INTEGER NOT NULL DEFAULT 0 CHECK (pagado_tarjeta IN (0, 1)),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);
