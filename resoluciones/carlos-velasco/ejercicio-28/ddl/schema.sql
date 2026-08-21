PRAGMA foreign_keys = ON;

DROP VIEW IF EXISTS vw_resumen_ventas;
DROP VIEW IF EXISTS vw_estado_pagos;
DROP VIEW IF EXISTS vw_ventas_vendedores;

DROP TABLE IF EXISTS pagos;
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS vendedores;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre_completo VARCHAR(150) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    telefono VARCHAR(30) NOT NULL
);

CREATE TABLE vendedores (
    id_vendedor INTEGER PRIMARY KEY,
    nombre_completo VARCHAR(150) NOT NULL,
    correo VARCHAR(150) NOT NULL UNIQUE,
    comision_porcentaje DECIMAL(5, 2) NOT NULL
        CHECK (comision_porcentaje >= 0 AND comision_porcentaje <= 100)
);

CREATE TABLE ventas (
    id_venta INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_vendedor INTEGER NOT NULL,
    total DECIMAL(10, 2) NOT NULL CHECK (total > 0),
    fecha_venta TEXT NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'Completada'
        CHECK (estado IN ('Completada', 'Pendiente', 'Cancelada')),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE pagos (
    id_pago INTEGER PRIMARY KEY,
    id_venta INTEGER NOT NULL,
    monto DECIMAL(10, 2) NOT NULL CHECK (monto > 0),
    fecha_pago TEXT NOT NULL,
    metodo_pago VARCHAR(30) NOT NULL
        CHECK (metodo_pago IN ('Efectivo', 'Tarjeta', 'Transferencia')),
    estado VARCHAR(20) NOT NULL DEFAULT 'Confirmado'
        CHECK (estado IN ('Confirmado', 'Pendiente', 'Rechazado')),
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE INDEX idx_ventas_cliente
ON ventas(id_cliente);

CREATE INDEX idx_ventas_vendedor
ON ventas(id_vendedor);

CREATE INDEX idx_ventas_fecha
ON ventas(fecha_venta);

CREATE INDEX idx_ventas_estado
ON ventas(estado);

CREATE INDEX idx_pagos_venta
ON pagos(id_venta);

CREATE INDEX idx_pagos_fecha
ON pagos(fecha_pago);

CREATE VIEW vw_resumen_ventas AS
SELECT
    v.id_venta,
    c.nombre_completo AS cliente,
    ven.nombre_completo AS vendedor,
    v.total,
    v.fecha_venta,
    v.estado
FROM ventas AS v
INNER JOIN clientes AS c
    ON c.id_cliente = v.id_cliente
INNER JOIN vendedores AS ven
    ON ven.id_vendedor = v.id_vendedor;

CREATE VIEW vw_estado_pagos AS
SELECT
    v.id_venta,
    c.nombre_completo AS cliente,
    v.total AS total_venta,
    COALESCE(SUM(
        CASE
            WHEN p.estado = 'Confirmado' THEN p.monto
            ELSE 0
        END
    ), 0) AS total_pagado,
    v.total - COALESCE(SUM(
        CASE
            WHEN p.estado = 'Confirmado' THEN p.monto
            ELSE 0
        END
    ), 0) AS saldo_pendiente
FROM ventas AS v
INNER JOIN clientes AS c
    ON c.id_cliente = v.id_cliente
LEFT JOIN pagos AS p
    ON p.id_venta = v.id_venta
GROUP BY
    v.id_venta,
    c.nombre_completo,
    v.total;

CREATE VIEW vw_ventas_vendedores AS
SELECT
    ven.id_vendedor,
    ven.nombre_completo AS vendedor,
    COUNT(v.id_venta) AS total_ventas,
    COALESCE(SUM(v.total), 0) AS monto_vendido,
    COALESCE(AVG(v.total), 0) AS ticket_promedio
FROM vendedores AS ven
LEFT JOIN ventas AS v
    ON v.id_vendedor = ven.id_vendedor
    AND v.estado = 'Completada'
GROUP BY
    ven.id_vendedor,
    ven.nombre_completo;