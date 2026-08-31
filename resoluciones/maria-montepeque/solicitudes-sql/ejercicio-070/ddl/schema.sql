PRAGMA foreign_keys = ON;

-- Ejercicio 070: Soldadura Industrial
-- Modelo: clientes -> ordenes (1:N), tecnicos -> ordenes (1:N), y
-- ordenes -> materiales / ordenes -> inspecciones (1:N cada una).
-- Cada restriccion ataca uno de los tres errores que pidio detectar
-- el cliente: repetidos (UNIQUE), relaciones invalidas
-- (FOREIGN KEY) y valores fuera de rango (CHECK).

CREATE TABLE clientes (
    id_cliente     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente TEXT NOT NULL UNIQUE,
    telefono       TEXT NOT NULL UNIQUE
);

CREATE TABLE tecnicos (
    id_tecnico     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_tecnico TEXT NOT NULL UNIQUE,
    especialidad   TEXT NOT NULL
);

CREATE TABLE ordenes (
    id_orden      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente    INTEGER NOT NULL,
    id_tecnico    INTEGER NOT NULL,
    descripcion   TEXT NOT NULL,
    fecha_orden   TEXT NOT NULL DEFAULT (date('now')),
    estado        TEXT NOT NULL DEFAULT 'pendiente'
                      CHECK (estado IN ('pendiente', 'en_proceso', 'finalizada', 'cancelada')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_tecnico) REFERENCES tecnicos (id_tecnico)
);

-- materiales: detalle de costos de cada orden. cantidad y
-- costo_unitario nunca pueden ser valores fuera de rango.
CREATE TABLE materiales (
    id_material     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_orden        INTEGER NOT NULL,
    nombre_material TEXT NOT NULL,
    cantidad        INTEGER NOT NULL CHECK (cantidad > 0),
    costo_unitario  REAL NOT NULL CHECK (costo_unitario >= 0),

    FOREIGN KEY (id_orden) REFERENCES ordenes (id_orden)
);

-- inspecciones: historico de calidad. No se borra ninguna fila de
-- esta tabla en operaciones normales.
CREATE TABLE inspecciones (
    id_inspeccion    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_orden         INTEGER NOT NULL,
    fecha_inspeccion TEXT NOT NULL DEFAULT (datetime('now')),
    resultado        TEXT NOT NULL DEFAULT 'pendiente'
                         CHECK (resultado IN ('aprobada', 'rechazada', 'pendiente')),
    observaciones    TEXT,

    FOREIGN KEY (id_orden) REFERENCES ordenes (id_orden)
);
