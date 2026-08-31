PRAGMA foreign_keys = ON;

-- Ejercicio 089: Mecanica de Autos
-- Modelo: clientes -> vehiculos (1:N); vehiculos -> diagnosticos
-- (1:N); diagnosticos -> reparaciones (1:1); reparaciones +
-- repuestos -> detalle_repuestos (1:N cada una).

CREATE TABLE clientes (
    id_cliente      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente  TEXT NOT NULL,
    telefono        TEXT NOT NULL UNIQUE
);

CREATE TABLE vehiculos (
    id_vehiculo   INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente    INTEGER NOT NULL,
    placa         TEXT NOT NULL UNIQUE,
    modelo        TEXT NOT NULL,

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

-- diagnosticos: historico, nunca se borra.
CREATE TABLE diagnosticos (
    id_diagnostico       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_vehiculo          INTEGER NOT NULL,
    fecha_diagnostico    TEXT NOT NULL,
    descripcion          TEXT NOT NULL,
    gravedad             TEXT NOT NULL CHECK (gravedad IN ('leve', 'moderada', 'grave')),

    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos (id_vehiculo)
);

-- reparaciones: el UNIQUE sobre id_diagnostico garantiza como maximo
-- una reparacion oficial por diagnostico, para que una auditoria
-- nunca encuentre reparaciones contradictorias.
CREATE TABLE reparaciones (
    id_reparacion       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_diagnostico       INTEGER NOT NULL UNIQUE,
    fecha_reparacion      TEXT NOT NULL,
    estado                TEXT NOT NULL DEFAULT 'pendiente'
                              CHECK (estado IN ('pendiente', 'en_proceso', 'completada', 'cancelada')),
    costo_mano_obra       REAL NOT NULL CHECK (costo_mano_obra >= 0),

    FOREIGN KEY (id_diagnostico) REFERENCES diagnosticos (id_diagnostico)
);

CREATE TABLE repuestos (
    id_repuesto      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_repuesto  TEXT NOT NULL UNIQUE,
    precio_unitario  REAL NOT NULL CHECK (precio_unitario >= 0)
);

-- detalle_repuestos: el UNIQUE compuesto impide registrar el mismo
-- repuesto dos veces como linea separada en la misma reparacion.
CREATE TABLE detalle_repuestos (
    id_detalle     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_reparacion  INTEGER NOT NULL,
    id_repuesto    INTEGER NOT NULL,
    cantidad       INTEGER NOT NULL CHECK (cantidad > 0),

    FOREIGN KEY (id_reparacion) REFERENCES reparaciones (id_reparacion),
    FOREIGN KEY (id_repuesto) REFERENCES repuestos (id_repuesto),
    UNIQUE (id_reparacion, id_repuesto)
);

-- Vista SQL (requerida en nivel 5): responde directamente "que paso y
-- cuando paso" con cada vehiculo, tal como pidio el cliente.
CREATE VIEW vista_historial_vehiculo AS
    SELECT
        d.id_diagnostico,
        cl.nombre_cliente,
        v.placa,
        v.modelo,
        d.fecha_diagnostico,
        d.descripcion,
        d.gravedad,
        r.fecha_reparacion,
        r.estado AS estado_reparacion,
        r.costo_mano_obra
    FROM diagnosticos d
    JOIN vehiculos v ON v.id_vehiculo = d.id_vehiculo
    JOIN clientes cl ON cl.id_cliente = v.id_cliente
    LEFT JOIN reparaciones r ON r.id_diagnostico = d.id_diagnostico;
