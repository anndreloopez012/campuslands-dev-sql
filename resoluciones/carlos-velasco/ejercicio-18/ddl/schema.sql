PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS compras;
DROP TABLE IF EXISTS medicamentos;
DROP TABLE IF EXISTS laboratorios;

CREATE TABLE laboratorios (
    id_laboratorio INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL,
    ciudad TEXT NOT NULL,
    CHECK (length(nombre) >= 3),
    CHECK (length(telefono) >= 7)
);

CREATE TABLE medicamentos (
    id_medicamento INTEGER PRIMARY KEY,
    id_laboratorio INTEGER NOT NULL,
    nombre TEXT NOT NULL,
    principio_activo TEXT NOT NULL,
    precio_venta REAL NOT NULL,
    stock INTEGER NOT NULL DEFAULT 0,
    fecha_vencimiento TEXT NOT NULL,
    UNIQUE (nombre, id_laboratorio),
    FOREIGN KEY (id_laboratorio) REFERENCES laboratorios(id_laboratorio),
    CHECK (precio_venta > 0),
    CHECK (stock >= 0),
    CHECK (date(fecha_vencimiento) IS NOT NULL)
);

CREATE TABLE compras (
    id_compra INTEGER PRIMARY KEY,
    id_medicamento INTEGER NOT NULL,
    fecha_compra TEXT NOT NULL,
    cantidad INTEGER NOT NULL,
    precio_compra REAL NOT NULL,
    proveedor TEXT NOT NULL,
    FOREIGN KEY (id_medicamento) REFERENCES medicamentos(id_medicamento),
    CHECK (cantidad > 0),
    CHECK (precio_compra > 0),
    CHECK (date(fecha_compra) IS NOT NULL)
);

CREATE TABLE ventas (
    id_venta INTEGER PRIMARY KEY,
    id_medicamento INTEGER NOT NULL,
    fecha_venta TEXT NOT NULL,
    cantidad INTEGER NOT NULL,
    precio_unitario REAL NOT NULL,
    cliente TEXT NOT NULL,
    FOREIGN KEY (id_medicamento) REFERENCES medicamentos(id_medicamento),
    CHECK (cantidad > 0),
    CHECK (precio_unitario > 0),
    CHECK (date(fecha_venta) IS NOT NULL)
);

CREATE INDEX idx_medicamentos_laboratorio
ON medicamentos(id_laboratorio);

CREATE INDEX idx_compras_medicamento
ON compras(id_medicamento);

CREATE INDEX idx_ventas_medicamento
ON ventas(id_medicamento);

CREATE INDEX idx_ventas_fecha
ON ventas(fecha_venta);