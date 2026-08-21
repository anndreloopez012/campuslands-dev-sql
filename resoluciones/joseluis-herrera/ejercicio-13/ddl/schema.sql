PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS transacciones;
DROP TABLE IF EXISTS tarjetas;
DROP TABLE IF EXISTS cuentas;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL
);

CREATE TABLE cuentas (
    id_cuenta INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    numero_cuenta TEXT NOT NULL UNIQUE,
    tipo_cuenta TEXT NOT NULL,
    saldo REAL NOT NULL DEFAULT 0,
    fecha_apertura TEXT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CHECK (tipo_cuenta IN ('Ahorros', 'Corriente')),
    CHECK (saldo >= 0)
);

CREATE TABLE tarjetas (
    id_tarjeta INTEGER PRIMARY KEY,
    id_cuenta INTEGER NOT NULL,
    numero_tarjeta TEXT NOT NULL UNIQUE,
    tipo_tarjeta TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'Activa',
    fecha_emision TEXT NOT NULL,
    FOREIGN KEY (id_cuenta) REFERENCES cuentas(id_cuenta),
    CHECK (tipo_tarjeta IN ('Debito', 'Credito')),
    CHECK (estado IN ('Activa', 'Bloqueada', 'Vencida'))
);

CREATE TABLE transacciones (
    id_transaccion INTEGER PRIMARY KEY,
    id_cuenta INTEGER NOT NULL,
    tipo_transaccion TEXT NOT NULL,
    monto REAL NOT NULL,
    fecha_transaccion TEXT NOT NULL,
    descripcion TEXT NOT NULL,
    FOREIGN KEY (id_cuenta) REFERENCES cuentas(id_cuenta),
    CHECK (tipo_transaccion IN ('Deposito', 'Retiro', 'Transferencia')),
    CHECK (monto > 0)
);

CREATE INDEX idx_cuentas_cliente
ON cuentas(id_cliente);

CREATE INDEX idx_tarjetas_cuenta
ON tarjetas(id_cuenta);

CREATE INDEX idx_transacciones_cuenta
ON transacciones(id_cuenta);

CREATE INDEX idx_transacciones_fecha
ON transacciones(fecha_transaccion);