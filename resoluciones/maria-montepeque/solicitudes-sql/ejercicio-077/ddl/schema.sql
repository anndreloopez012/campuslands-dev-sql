PRAGMA foreign_keys = ON;

-- Ejercicio 077: Taller de Motos
-- Modelo: clientes -> motos (1:N); motos -> ordenes_servicio (1:N);
-- ordenes_servicio + repuestos -> detalle_repuestos (1:N cada una).

CREATE TABLE clientes (
    id_cliente      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente  TEXT NOT NULL,
    telefono        TEXT NOT NULL UNIQUE
);

CREATE TABLE motos (
    id_moto       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente    INTEGER NOT NULL,
    placa         TEXT NOT NULL UNIQUE,
    modelo        TEXT NOT NULL,

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

CREATE TABLE repuestos (
    id_repuesto      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_repuesto  TEXT NOT NULL UNIQUE,
    precio_unitario  REAL NOT NULL CHECK (precio_unitario >= 0)
);

-- ordenes_servicio: el estado se corrige siempre con UPDATE. No se
-- borra una orden para "reiniciarla", tal como pidio el cliente.
CREATE TABLE ordenes_servicio (
    id_orden       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_moto        INTEGER NOT NULL,
    descripcion    TEXT NOT NULL,
    fecha_orden    TEXT NOT NULL DEFAULT (date('now')),
    estado         TEXT NOT NULL DEFAULT 'recibida'
                       CHECK (estado IN ('recibida', 'en_reparacion', 'finalizada', 'cancelada')),

    FOREIGN KEY (id_moto) REFERENCES motos (id_moto)
);

-- detalle_repuestos: el UNIQUE compuesto impide que un repuesto quede
-- registrado dos veces como linea separada en la misma orden.
CREATE TABLE detalle_repuestos (
    id_detalle        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_orden          INTEGER NOT NULL,
    id_repuesto       INTEGER NOT NULL,
    cantidad          INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario   REAL NOT NULL CHECK (precio_unitario >= 0),

    FOREIGN KEY (id_orden) REFERENCES ordenes_servicio (id_orden),
    FOREIGN KEY (id_repuesto) REFERENCES repuestos (id_repuesto),
    UNIQUE (id_orden, id_repuesto)
);
