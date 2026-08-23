PRAGMA foreign_keys = ON;

-- Ejercicio 28: Vistas y Reportes
-- Modelo: clientes, vendedores, ventas, pagos

CREATE TABLE clientes (
    id_cliente  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    correo      TEXT NOT NULL UNIQUE
);

CREATE TABLE vendedores (
    id_vendedor  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL,
    correo       TEXT NOT NULL UNIQUE
);

CREATE TABLE ventas (
    id_venta      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente    INTEGER NOT NULL,
    id_vendedor   INTEGER NOT NULL,
    total         REAL NOT NULL CHECK (total > 0),
    fecha         TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores (id_vendedor)
);

CREATE TABLE pagos (
    id_pago    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_venta   INTEGER NOT NULL,
    monto      REAL NOT NULL CHECK (monto > 0),
    metodo     TEXT NOT NULL CHECK (metodo IN ('efectivo', 'tarjeta', 'transferencia')),
    fecha      TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'

    FOREIGN KEY (id_venta) REFERENCES ventas (id_venta)
);

-- Vistas para reportes (tema del ejercicio)

-- Resumen de cada venta: total facturado, total pagado y saldo pendiente
CREATE VIEW vista_resumen_ventas AS
SELECT
    v.id_venta,
    c.nombre AS cliente,
    ve.nombre AS vendedor,
    v.total AS total_venta,
    COALESCE(SUM(p.monto), 0) AS total_pagado,
    v.total - COALESCE(SUM(p.monto), 0) AS saldo_pendiente,
    v.fecha AS fecha_venta
FROM ventas v
JOIN clientes c ON c.id_cliente = v.id_cliente
JOIN vendedores ve ON ve.id_vendedor = v.id_vendedor
LEFT JOIN pagos p ON p.id_venta = v.id_venta
GROUP BY v.id_venta;

-- Ranking de vendedores por total vendido
CREATE VIEW vista_ranking_vendedores AS
SELECT
    ve.nombre AS vendedor,
    COUNT(v.id_venta) AS cantidad_ventas,
    SUM(v.total) AS total_vendido
FROM ventas v
JOIN vendedores ve ON ve.id_vendedor = v.id_vendedor
GROUP BY ve.nombre;
