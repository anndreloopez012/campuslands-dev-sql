PRAGMA foreign_keys = ON;

-- Ejercicio 61: DEFAULT Nivel Aplicado
-- Tema central: DEFAULT
-- Contexto: ventas diarias de una cafeteria (clientes, productos, ventas).

-- clientes: DEFAULT para tipo_cliente y fecha_registro.
CREATE TABLE clientes (
    id_cliente      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre          TEXT NOT NULL,
    correo          TEXT NOT NULL UNIQUE,

    -- DEFAULT para tipo_cliente: si no se indica, todo cliente nuevo
    -- entra como 'regular'.
    tipo_cliente    TEXT NOT NULL DEFAULT 'regular'
                        CHECK (tipo_cliente IN ('regular', 'frecuente', 'vip')),

    -- DEFAULT para fecha_registro: se registra automaticamente la fecha
    -- del dia si no se especifica otra.
    fecha_registro  TEXT NOT NULL DEFAULT (date('now'))
);

-- productos: DEFAULT para categoria y disponible.
CREATE TABLE productos (
    id_producto   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre        TEXT NOT NULL UNIQUE,

    -- DEFAULT para categoria: la mayoria de productos nuevos de la
    -- cafeteria son bebidas, por eso es el valor por defecto.
    categoria     TEXT NOT NULL DEFAULT 'bebida'
                      CHECK (categoria IN ('bebida', 'postre', 'snack')),

    precio        REAL NOT NULL CHECK (precio > 0),

    -- DEFAULT para disponible: un producto nuevo entra disponible (1)
    -- salvo que se indique lo contrario.
    disponible    INTEGER NOT NULL DEFAULT 1 CHECK (disponible IN (0, 1))
);

-- ventas: DEFAULT para cantidad, fecha_venta y estado.
CREATE TABLE ventas (
    id_venta       INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente     INTEGER NOT NULL,
    id_producto    INTEGER NOT NULL,

    -- DEFAULT para cantidad: la mayoria de ventas de mostrador son de
    -- una sola unidad.
    cantidad       INTEGER NOT NULL DEFAULT 1 CHECK (cantidad > 0),

    -- DEFAULT para fecha_venta: se registra el momento exacto de la
    -- venta si no se indica otro.
    fecha_venta    TEXT NOT NULL DEFAULT (datetime('now')),

    -- DEFAULT para estado: toda venta nueva inicia 'pendiente' hasta
    -- que se cobre.
    estado         TEXT NOT NULL DEFAULT 'pendiente'
                       CHECK (estado IN ('pendiente', 'pagada', 'cancelada')),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);
