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
    nombre_completo TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL,
    fecha_registro TEXT NOT NULL,
    CHECK (length(trim(nombre_completo)) >= 5),
    CHECK (date(fecha_registro) IS NOT NULL)
);

CREATE TABLE vendedores (
    id_vendedor INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    comision REAL NOT NULL DEFAULT 0.05,
    CHECK (length(trim(nombre_completo)) >= 5),
    CHECK (comision >= 0 AND comision <= 1)
);

CREATE TABLE ventas (
    id_venta INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_vendedor INTEGER NOT NULL,
    fecha_venta TEXT NOT NULL,
    total REAL NOT NULL,
    estado TEXT NOT NULL DEFAULT 'completada',
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor),
    CHECK (total > 0),
    CHECK (estado IN ('pendiente', 'completada', 'cancelada')),
    CHECK (date(fecha_venta) IS NOT NULL)
);

CREATE TABLE pagos (
    id_pago INTEGER PRIMARY KEY,
    id_venta INTEGER NOT NULL,
    fecha_pago TEXT NOT NULL,
    monto REAL NOT NULL,
    metodo_pago TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'aprobado',
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    CHECK (monto > 0),
    CHECK (metodo_pago IN ('efectivo', 'tarjeta', 'transferencia')),
    CHECK (estado IN ('pendiente', 'aprobado', 'rechazado')),
    CHECK (date(fecha_pago) IS NOT NULL)
);

CREATE INDEX idx_ventas_cliente
ON ventas(id_cliente);

CREATE INDEX idx_ventas_vendedor
ON ventas(id_vendedor);

CREATE INDEX idx_ventas_fecha
ON ventas(fecha_venta);

CREATE INDEX idx_pagos_venta
ON pagos(id_venta);

CREATE INDEX idx_pagos_fecha
ON pagos(fecha_pago);

CREATE VIEW vw_resumen_ventas AS
SELECT
    v.id_venta,
    v.fecha_venta,
    c.nombre_completo AS cliente,
    ven.nombre_completo AS vendedor,
    v.total,
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
    COALESCE(SUM(CASE WHEN p.estado = 'aprobado' THEN p.monto ELSE 0 END), 0) AS total_pagado,
    v.total - COALESCE(SUM(CASE WHEN p.estado = 'aprobado' THEN p.monto ELSE 0 END), 0) AS saldo_pendiente
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
    COUNT(v.id_venta) AS cantidad_ventas,
    COALESCE(SUM(v.total), 0) AS total_vendido,
    COALESCE(SUM(v.total * ven.comision), 0) AS comision_generada
FROM vendedores AS ven
LEFT JOIN ventas AS v
    ON v.id_vendedor = ven.id_vendedor
    AND v.estado = 'completada'
GROUP BY
    ven.id_vendedor,
    ven.nombre_completo;