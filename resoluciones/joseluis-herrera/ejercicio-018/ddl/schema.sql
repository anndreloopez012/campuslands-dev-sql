PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS compras;
DROP TABLE IF EXISTS medicamentos;
DROP TABLE IF EXISTS laboratorios;

CREATE TABLE laboratorios (
    id_laboratorio INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    ciudad TEXT NOT NULL,
    telefono TEXT NOT NULL UNIQUE
);

CREATE TABLE medicamentos (
    id_medicamento INTEGER PRIMARY KEY,
    id_laboratorio INTEGER NOT NULL,
    nombre TEXT NOT NULL,
    principio_activo TEXT NOT NULL,
    precio_venta REAL NOT NULL CHECK (precio_venta > 0),
    stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
    fecha_vencimiento TEXT NOT NULL CHECK (date(fecha_vencimiento) IS NOT NULL),
    UNIQUE (id_laboratorio, nombre),
    FOREIGN KEY (id_laboratorio) REFERENCES laboratorios(id_laboratorio)
);

CREATE TABLE compras (
    id_compra INTEGER PRIMARY KEY,
    id_medicamento INTEGER NOT NULL,
    fecha_compra TEXT NOT NULL CHECK (date(fecha_compra) IS NOT NULL),
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario REAL NOT NULL CHECK (precio_unitario > 0),
    proveedor TEXT NOT NULL,
    FOREIGN KEY (id_medicamento) REFERENCES medicamentos(id_medicamento)
);

CREATE TABLE ventas (
    id_venta INTEGER PRIMARY KEY,
    id_medicamento INTEGER NOT NULL,
    fecha_venta TEXT NOT NULL CHECK (date(fecha_venta) IS NOT NULL),
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario REAL NOT NULL CHECK (precio_unitario > 0),
    cliente TEXT NOT NULL,
    FOREIGN KEY (id_medicamento) REFERENCES medicamentos(id_medicamento)
);

CREATE INDEX idx_medicamentos_laboratorio
ON medicamentos(id_laboratorio);

CREATE INDEX idx_medicamentos_stock
ON medicamentos(stock);

CREATE INDEX idx_compras_medicamento
ON compras(id_medicamento);

CREATE INDEX idx_compras_fecha
ON compras(fecha_compra);

CREATE INDEX idx_ventas_medicamento
ON ventas(id_medicamento);

CREATE INDEX idx_ventas_fecha
ON ventas(fecha_venta);