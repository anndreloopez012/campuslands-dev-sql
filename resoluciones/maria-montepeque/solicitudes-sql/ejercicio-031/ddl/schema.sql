PRAGMA foreign_keys = ON;

-- Ejercicio 031: Renta Autos de Lujo
-- Modelo: dos catalogos independientes (vehiculos, clientes) que
-- alimentan una tabla de movimientos (reservas) con dos FOREIGN KEY.

CREATE TABLE vehiculos (
    id_vehiculo INTEGER PRIMARY KEY AUTOINCREMENT,
    placa       TEXT NOT NULL UNIQUE,
    marca       TEXT NOT NULL,
    modelo      TEXT NOT NULL,
    precio_dia  REAL NOT NULL CHECK (precio_dia > 0),
    estado      TEXT NOT NULL DEFAULT 'disponible' CHECK (estado IN ('disponible', 'rentado', 'mantenimiento'))
);

CREATE TABLE clientes (
    id_cliente     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente TEXT NOT NULL UNIQUE,
    licencia       TEXT NOT NULL UNIQUE
);

-- reservas: tabla principal (movimiento). Conecta vehiculos y clientes,
-- los dos catalogos permanentes, sin mezclarse con ellos.
CREATE TABLE reservas (
    id_reserva   INTEGER PRIMARY KEY AUTOINCREMENT,
    id_vehiculo  INTEGER NOT NULL,
    id_cliente   INTEGER NOT NULL,
    fecha_inicio TEXT NOT NULL,
    fecha_fin    TEXT NOT NULL,
    monto_total  REAL NOT NULL CHECK (monto_total > 0),
    estado       TEXT NOT NULL DEFAULT 'confirmada' CHECK (estado IN ('confirmada', 'en_curso', 'finalizada', 'cancelada')),

    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos (id_vehiculo),
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);
