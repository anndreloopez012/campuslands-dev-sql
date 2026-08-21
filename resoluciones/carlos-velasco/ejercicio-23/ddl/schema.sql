PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS detalle_factura;
DROP TABLE IF EXISTS facturas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    documento TEXT NOT NULL UNIQUE,
    correo TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL,
    CHECK (length(nombre_completo) >= 5),
    CHECK (length(documento) >= 6)
);

CREATE TABLE productos (
    id_producto INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    descripcion TEXT NOT NULL,
    precio REAL NOT NULL,
    stock INTEGER NOT NULL DEFAULT 0,
    CHECK (precio > 0),
    CHECK (stock >= 0)
);

CREATE TABLE facturas (
    id_factura INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    numero_factura TEXT NOT NULL UNIQUE,
    fecha TEXT NOT NULL,
    impuesto REAL NOT NULL DEFAULT 0.19,
    estado TEXT NOT NULL DEFAULT 'EMITIDA',
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CHECK (date(fecha) IS NOT NULL),
    CHECK (impuesto >= 0 AND impuesto <= 1),
    CHECK (estado IN ('EMITIDA', 'PAGADA', 'ANULADA'))
);

CREATE TABLE detalle_factura (
    id_detalle INTEGER PRIMARY KEY,
    id_factura INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    precio_unitario REAL NOT NULL,
    FOREIGN KEY (id_factura) REFERENCES facturas(id_factura),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    UNIQUE (id_factura, id_producto),
    CHECK (cantidad > 0),
    CHECK (precio_unitario > 0)
);