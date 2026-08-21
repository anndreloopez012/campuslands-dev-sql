PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS boletos;
DROP TABLE IF EXISTS asistentes;
DROP TABLE IF EXISTS eventos;
DROP TABLE IF EXISTS lugares;

CREATE TABLE lugares (
    id_lugar INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL UNIQUE,
    ciudad TEXT NOT NULL,
    capacidad INTEGER NOT NULL CHECK (capacidad > 0)
);

CREATE TABLE eventos (
    id_evento INTEGER PRIMARY KEY,
    id_lugar INTEGER NOT NULL,
    nombre TEXT NOT NULL UNIQUE,
    fecha TEXT NOT NULL,
    categoria TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'programado',
    FOREIGN KEY (id_lugar) REFERENCES lugares(id_lugar),
    CHECK (date(fecha) IS NOT NULL),
    CHECK (estado IN ('programado', 'finalizado', 'cancelado'))
);

CREATE TABLE asistentes (
    id_asistente INTEGER PRIMARY KEY,
    nombre_completo TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    telefono TEXT NOT NULL,
    CHECK (length(nombre_completo) >= 5),
    CHECK (instr(correo, '@') > 1)
);

CREATE TABLE boletos (
    id_boleto INTEGER PRIMARY KEY,
    id_evento INTEGER NOT NULL,
    id_asistente INTEGER NOT NULL,
    tipo TEXT NOT NULL,
    precio REAL NOT NULL,
    fecha_compra TEXT NOT NULL,
    estado TEXT NOT NULL DEFAULT 'activo',
    FOREIGN KEY (id_evento) REFERENCES eventos(id_evento),
    FOREIGN KEY (id_asistente) REFERENCES asistentes(id_asistente),
    UNIQUE (id_evento, id_asistente),
    CHECK (precio > 0),
    CHECK (tipo IN ('general', 'vip', 'preferencial')),
    CHECK (estado IN ('activo', 'usado', 'cancelado')),
    CHECK (datetime(fecha_compra) IS NOT NULL)
);

CREATE INDEX idx_eventos_fecha
ON eventos(fecha);

CREATE INDEX idx_boletos_evento
ON boletos(id_evento);

CREATE INDEX idx_boletos_asistente
ON boletos(id_asistente);