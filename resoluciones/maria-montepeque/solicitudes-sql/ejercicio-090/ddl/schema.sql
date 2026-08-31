PRAGMA foreign_keys = ON;

-- Ejercicio 090: Laboratorio Quimico
-- Modelo: tecnicos -> muestras (1:N); formulas -> muestras (1:N);
-- muestras -> resultados (1:1); muestras + reactivos ->
-- detalle_reactivos (1:N cada una).

CREATE TABLE tecnicos (
    id_tecnico      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_tecnico  TEXT NOT NULL,
    codigo_tecnico  TEXT NOT NULL UNIQUE
);

CREATE TABLE formulas (
    id_formula      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_formula  TEXT NOT NULL UNIQUE,
    categoria       TEXT NOT NULL
);

CREATE TABLE reactivos (
    id_reactivo        INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_reactivo    TEXT NOT NULL UNIQUE,
    unidad_medida      TEXT NOT NULL,
    stock_disponible   REAL NOT NULL DEFAULT 0 CHECK (stock_disponible >= 0)
);

-- muestras: historico, nunca se borra.
CREATE TABLE muestras (
    id_muestra       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_formula       INTEGER NOT NULL,
    id_tecnico       INTEGER NOT NULL,
    fecha_recepcion  TEXT NOT NULL,
    estado           TEXT NOT NULL DEFAULT 'recibida'
                         CHECK (estado IN ('recibida', 'en_analisis', 'finalizada', 'rechazada')),

    FOREIGN KEY (id_formula) REFERENCES formulas (id_formula),
    FOREIGN KEY (id_tecnico) REFERENCES tecnicos (id_tecnico)
);

-- resultados: el UNIQUE sobre id_muestra garantiza como maximo un
-- resultado oficial por muestra, para que una auditoria nunca
-- encuentre resultados contradictorios.
CREATE TABLE resultados (
    id_resultado      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_muestra        INTEGER NOT NULL UNIQUE,
    fecha_resultado   TEXT NOT NULL,
    valor_medido      REAL NOT NULL CHECK (valor_medido >= 0),
    veredicto         TEXT NOT NULL CHECK (veredicto IN ('aprobado', 'rechazado')),

    FOREIGN KEY (id_muestra) REFERENCES muestras (id_muestra)
);

-- detalle_reactivos: el UNIQUE compuesto impide registrar el mismo
-- reactivo dos veces como linea separada en la misma muestra.
CREATE TABLE detalle_reactivos (
    id_detalle       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_muestra       INTEGER NOT NULL,
    id_reactivo      INTEGER NOT NULL,
    cantidad_usada   REAL NOT NULL CHECK (cantidad_usada > 0),

    FOREIGN KEY (id_muestra) REFERENCES muestras (id_muestra),
    FOREIGN KEY (id_reactivo) REFERENCES reactivos (id_reactivo),
    UNIQUE (id_muestra, id_reactivo)
);

-- Vista SQL (requerida en nivel 5): responde directamente "que paso y
-- cuando paso" con cada muestra, tal como pidio el cliente.
CREATE VIEW vista_historial_muestra AS
    SELECT
        m.id_muestra,
        t.nombre_tecnico,
        f.nombre_formula,
        f.categoria,
        m.fecha_recepcion,
        m.estado,
        r.fecha_resultado,
        r.valor_medido,
        r.veredicto
    FROM muestras m
    JOIN formulas f ON f.id_formula = m.id_formula
    JOIN tecnicos t ON t.id_tecnico = m.id_tecnico
    LEFT JOIN resultados r ON r.id_muestra = m.id_muestra;
