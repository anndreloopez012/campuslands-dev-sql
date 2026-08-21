PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS tarjetas;
DROP TABLE IF EXISTS transacciones;
DROP TABLE IF EXISTS cuentas;
DROP TABLE IF EXISTS clientes;

-- CLIENTES

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    documento TEXT NOT NULL UNIQUE,
    correo TEXT NOT NULL UNIQUE,
    fecha_registro TEXT NOT NULL,
    CHECK (length(trim(nombre_completo)) >= 3),
    CHECK (fecha_registro GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]')
);

-- CUENTAS

CREATE TABLE cuentas (
    id_cuenta INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    numero_cuenta TEXT NOT NULL UNIQUE,
    tipo_cuenta TEXT NOT NULL,
    saldo REAL NOT NULL DEFAULT 0,
    fecha_apertura TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'Activa',
    CHECK (tipo_cuenta IN ('Ahorros', 'Corriente')),
    CHECK (saldo >= 0),
    CHECK (estado IN ('Activa', 'Bloqueada', 'Cerrada')),
    CHECK (fecha_apertura GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- TRANSACCIONES

CREATE TABLE transacciones (
    id_transaccion INTEGER PRIMARY KEY,
    id_cuenta INTEGER NOT NULL,
    tipo_transaccion TEXT NOT NULL,
    monto REAL NOT NULL,
    fecha_hora TEXT NOT NULL,
    descripcion TEXT NOT NULL,
    CHECK (tipo_transaccion IN ('Deposito', 'Retiro', 'Transferencia')),
    CHECK (monto > 0),
    CHECK (
        fecha_hora GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]'
    ),
    FOREIGN KEY (id_cuenta) REFERENCES cuentas(id_cuenta)
);

-- TARJETAS

CREATE TABLE tarjetas (
    id_tarjeta INTEGER PRIMARY KEY,
    id_cuenta INTEGER NOT NULL,
    numero_tarjeta TEXT NOT NULL UNIQUE,
    tipo_tarjeta TEXT NOT NULL,
    fecha_emision TEXT NOT NULL,
    fecha_vencimiento TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'Activa',
    CHECK (tipo_tarjeta IN ('Debito', 'Credito')),
    CHECK (estado IN ('Activa', 'Bloqueada', 'Vencida')),
    CHECK (
        fecha_emision GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'
    ),
    CHECK (
        fecha_vencimiento GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'
    ),
    FOREIGN KEY (id_cuenta) REFERENCES cuentas(id_cuenta)
);

CREATE INDEX idx_cuentas_cliente
ON cuentas(id_cliente);

CREATE INDEX idx_transacciones_cuenta
ON transacciones(id_cuenta);

CREATE INDEX idx_transacciones_fecha
ON transacciones(fecha_hora);

CREATE INDEX idx_tarjetas_cuenta
ON tarjetas(id_cuenta);