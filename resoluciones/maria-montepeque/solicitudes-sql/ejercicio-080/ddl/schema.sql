PRAGMA foreign_keys = ON;

-- Ejercicio 080: Cine Horror Nights
-- Modelo: peliculas + salas -> funciones (1:N cada una); funciones
-- -> boletos (1:N); boletos -> pagos (1:1). Cada restriccion ataca
-- uno de los tres errores que pidio detectar el cliente: repetidos
-- (UNIQUE), relaciones invalidas (FOREIGN KEY) y valores fuera de
-- rango (CHECK).

CREATE TABLE peliculas (
    id_pelicula        INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo             TEXT NOT NULL UNIQUE,
    clasificacion      TEXT NOT NULL CHECK (clasificacion IN ('PG-13', 'R', 'NC-17')),
    duracion_minutos   INTEGER NOT NULL CHECK (duracion_minutos > 0)
);

CREATE TABLE salas (
    id_sala       INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_sala   TEXT NOT NULL UNIQUE,
    capacidad     INTEGER NOT NULL CHECK (capacidad > 0)
);

CREATE TABLE funciones (
    id_funcion        INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pelicula       INTEGER NOT NULL,
    id_sala           INTEGER NOT NULL,
    fecha_funcion     TEXT NOT NULL,
    hora_funcion      TEXT NOT NULL,
    estado            TEXT NOT NULL DEFAULT 'programada'
                          CHECK (estado IN ('programada', 'en_curso', 'finalizada', 'cancelada')),

    FOREIGN KEY (id_pelicula) REFERENCES peliculas (id_pelicula),
    FOREIGN KEY (id_sala) REFERENCES salas (id_sala)
);

-- boletos: el UNIQUE compuesto impide vender el mismo asiento dos
-- veces para la misma funcion. Es la restriccion que ataca
-- directamente el problema de "registros repetidos" en un cine.
CREATE TABLE boletos (
    id_boleto     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_funcion    INTEGER NOT NULL,
    asiento       TEXT NOT NULL,
    precio        REAL NOT NULL CHECK (precio >= 0),

    FOREIGN KEY (id_funcion) REFERENCES funciones (id_funcion),
    UNIQUE (id_funcion, asiento)
);

-- pagos: el UNIQUE sobre id_boleto garantiza como maximo un pago
-- oficial por boleto (relacion 1:1).
CREATE TABLE pagos (
    id_pago       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_boleto     INTEGER NOT NULL UNIQUE,
    monto         REAL NOT NULL CHECK (monto >= 0),
    metodo_pago   TEXT NOT NULL CHECK (metodo_pago IN ('efectivo', 'tarjeta')),
    fecha_pago    TEXT NOT NULL DEFAULT (datetime('now')),

    FOREIGN KEY (id_boleto) REFERENCES boletos (id_boleto)
);
