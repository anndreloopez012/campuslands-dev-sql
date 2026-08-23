PRAGMA foreign_keys = ON;

-- Ejercicio 13: Banco Cuentas
-- Modelo: clientes, cuentas, transacciones, tarjetas

CREATE TABLE clientes (
    id_cliente  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    dpi         TEXT NOT NULL UNIQUE,
    correo      TEXT NOT NULL UNIQUE
);

CREATE TABLE cuentas (
    id_cuenta       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente      INTEGER NOT NULL,
    numero_cuenta   TEXT NOT NULL UNIQUE,
    tipo            TEXT NOT NULL CHECK (tipo IN ('ahorro', 'corriente')),
    saldo           REAL NOT NULL DEFAULT 0 CHECK (saldo >= 0),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

CREATE TABLE transacciones (
    id_transaccion    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cuenta         INTEGER NOT NULL,
    tipo              TEXT NOT NULL CHECK (tipo IN ('deposito', 'retiro', 'transferencia')),
    monto             REAL NOT NULL CHECK (monto > 0),
    fecha             TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'

    FOREIGN KEY (id_cuenta) REFERENCES cuentas (id_cuenta)
);

CREATE TABLE tarjetas (
    id_tarjeta      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cuenta       INTEGER NOT NULL,
    numero_tarjeta  TEXT NOT NULL UNIQUE,
    tipo            TEXT NOT NULL CHECK (tipo IN ('debito', 'credito')),
    fecha_expira    TEXT NOT NULL,   -- ISO 'YYYY-MM-DD'

    FOREIGN KEY (id_cuenta) REFERENCES cuentas (id_cuenta)
);
