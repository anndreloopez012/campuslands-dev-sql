PRAGMA foreign_keys = ON;

-- Ejercicio 052: Taller de Motos
-- Modelo: clientes + mecanicos -> ordenes_servicio (doble FOREIGN
-- KEY), y ordenes_servicio -> repuestos_usados (1:N). 4 tablas.

CREATE TABLE clientes (
    id_cliente     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente TEXT NOT NULL UNIQUE,
    telefono       TEXT NOT NULL
);

CREATE TABLE mecanicos (
    id_mecanico     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_mecanico TEXT NOT NULL UNIQUE,
    especialidad    TEXT NOT NULL CHECK (especialidad IN ('motor', 'frenos', 'electrico', 'general'))
);

-- ordenes_servicio: encabezado de cada orden de trabajo.
CREATE TABLE ordenes_servicio (
    id_orden          INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente        INTEGER NOT NULL,
    id_mecanico       INTEGER NOT NULL,
    placa_moto        TEXT NOT NULL,
    fecha_orden       TEXT NOT NULL,
    costo_mano_obra   REAL NOT NULL CHECK (costo_mano_obra > 0),
    estado            TEXT NOT NULL DEFAULT 'recibida' CHECK (estado IN ('recibida', 'en_reparacion', 'listo', 'entregado', 'cancelada')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_mecanico) REFERENCES mecanicos (id_mecanico)
);

-- repuestos_usados: detalle de cada orden.
CREATE TABLE repuestos_usados (
    id_detalle       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_orden         INTEGER NOT NULL,
    nombre_repuesto  TEXT NOT NULL,
    cantidad         INTEGER NOT NULL CHECK (cantidad > 0),
    costo_unitario   REAL NOT NULL CHECK (costo_unitario > 0),

    FOREIGN KEY (id_orden) REFERENCES ordenes_servicio (id_orden)
);
