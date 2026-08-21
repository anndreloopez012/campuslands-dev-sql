PRAGMA foreign_keys = ON;

-- Ejercicio 041: Hotel Gamers
-- Modelo: dos catalogos (huespedes, habitaciones) que alimentan
-- reservas (doble FOREIGN KEY), y consumos que depende a su vez de
-- reservas (un tercer nivel de relacion, 4 tablas en total).

CREATE TABLE huespedes (
    id_huesped     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_huesped TEXT NOT NULL UNIQUE,
    email          TEXT NOT NULL UNIQUE
);

CREATE TABLE habitaciones (
    id_habitacion     INTEGER PRIMARY KEY AUTOINCREMENT,
    numero_habitacion TEXT NOT NULL UNIQUE,
    tipo              TEXT NOT NULL CHECK (tipo IN ('individual', 'doble', 'suite_gamer')),
    precio_noche      REAL NOT NULL CHECK (precio_noche > 0)
);

-- reservas: tabla principal de estadias.
CREATE TABLE reservas (
    id_reserva      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_huesped      INTEGER NOT NULL,
    id_habitacion   INTEGER NOT NULL,
    fecha_checkin   TEXT NOT NULL,
    fecha_checkout  TEXT NOT NULL,
    estado          TEXT NOT NULL DEFAULT 'confirmada' CHECK (estado IN ('confirmada', 'en_curso', 'finalizada', 'cancelada')),

    FOREIGN KEY (id_huesped) REFERENCES huespedes (id_huesped),
    FOREIGN KEY (id_habitacion) REFERENCES habitaciones (id_habitacion),
    CHECK (fecha_checkout > fecha_checkin)
);

-- consumos: gastos extra de una reserva (incluye torneos internos,
-- renta de equipo, snacks, depositos, etc.).
CREATE TABLE consumos (
    id_consumo     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_reserva     INTEGER NOT NULL,
    descripcion    TEXT NOT NULL,
    monto          REAL NOT NULL CHECK (monto > 0),
    fecha_consumo  TEXT NOT NULL,

    FOREIGN KEY (id_reserva) REFERENCES reservas (id_reserva)
);
