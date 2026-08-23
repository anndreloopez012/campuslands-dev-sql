PRAGMA foreign_keys = ON;

-- Ejercicio 45: PRIMARY KEY Nivel Intermedio
-- Tema central: PRIMARY KEY
-- Contexto: ventas diarias de una cafeteria.

-- productos: PRIMARY KEY NATURAL. El codigo de barras ya es unico por
-- definicion del negocio, no cambia con el tiempo (a diferencia de un
-- documento de identidad, que si puede corregirse) y es exactamente lo que
-- se lee al vender el producto. Por eso aqui SI conviene usarlo como
-- PRIMARY KEY en vez de crear un id autoincremental adicional.
CREATE TABLE productos (
    codigo_barras   TEXT PRIMARY KEY,
    nombre          TEXT NOT NULL,
    precio          REAL NOT NULL CHECK (precio > 0)
);

-- clientes: PRIMARY KEY SUBROGADA (autoincremental). Aqui no hay un dato
-- natural tan estable como el codigo de barras: el correo se puede
-- actualizar, y no todos los clientes lo dan. Por eso se prefiere un id
-- generado por la base de datos.
CREATE TABLE clientes (
    id_cliente  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    correo      TEXT UNIQUE
);

-- ventas: relaciona clientes y productos. Su PRIMARY KEY (id_venta) es
-- ademas lo que hace posible que exista una FOREIGN KEY hacia ella desde
-- otras tablas si el negocio lo necesitara mas adelante (por ejemplo, un
-- detalle de pago): solo se puede referenciar una PRIMARY KEY.
CREATE TABLE ventas (
    id_venta         INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente       INTEGER NOT NULL,
    codigo_barras    TEXT NOT NULL,
    cantidad         INTEGER NOT NULL CHECK (cantidad > 0),
    fecha_venta      TEXT NOT NULL,

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (codigo_barras) REFERENCES productos (codigo_barras)
);
