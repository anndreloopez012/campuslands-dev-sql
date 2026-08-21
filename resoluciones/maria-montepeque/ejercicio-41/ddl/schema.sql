PRAGMA foreign_keys = ON;

-- Ejercicio 41: Tipos de datos Nivel Basico
-- Tema central: Tipos de datos
-- Contexto: inventario de dispositivos tecnologicos en bodega.

-- categorias: catalogo simple, solo texto.
CREATE TABLE categorias (
    id_categoria  INTEGER PRIMARY KEY AUTOINCREMENT,   -- INTEGER: identificador numerico entero
    nombre        TEXT NOT NULL UNIQUE                 -- TEXT: cadena de longitud variable
);

-- productos: tabla principal, aqui se concentran los distintos tipos de dato.
CREATE TABLE productos (
    id_producto     INTEGER PRIMARY KEY AUTOINCREMENT,   -- INTEGER: llave primaria autoincremental
    id_categoria    INTEGER NOT NULL,                     -- INTEGER: llave foranea (siempre entero)
    nombre          TEXT NOT NULL,                        -- TEXT: texto libre, longitud variable
    precio          REAL NOT NULL CHECK (precio > 0),      -- REAL: numero con decimales (precio en quetzales)
    stock           INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),   -- INTEGER: cantidades siempre son enteras, nunca "2.5 unidades"

    -- BOOLEAN simulado: SQLite no tiene tipo BOOLEAN nativo. Se usa INTEGER
    -- restringido a 0/1 (0 = inactivo, 1 = activo) con DEFAULT y CHECK para
    -- que se comporte como un booleano real y no acepte otros valores.
    activo          INTEGER NOT NULL DEFAULT 1 CHECK (activo IN (0, 1)),

    FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
);

-- movimientos: entradas y salidas de inventario.
CREATE TABLE movimientos (
    id_movimiento    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_producto      INTEGER NOT NULL,
    tipo             TEXT NOT NULL CHECK (tipo IN ('entrada', 'salida')),   -- TEXT restringido con CHECK (enum simulado)
    cantidad         INTEGER NOT NULL CHECK (cantidad > 0),                 -- INTEGER: unidades movidas

    -- DATE simulado: SQLite no tiene tipo DATE nativo. Se usa TEXT en
    -- formato ISO 'YYYY-MM-DD', validado con CHECK + GLOB. El formato ISO
    -- se eligio porque ademas de ser texto legible, ordena correctamente
    -- como texto (comparaciones '<' / '>' funcionan igual que con fechas).
    fecha_movimiento TEXT NOT NULL CHECK (fecha_movimiento GLOB '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),

    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);
