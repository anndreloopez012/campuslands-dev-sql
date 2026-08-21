-- Ejercicio 47: FOREIGN KEY Nivel Basico
-- Tema central: FOREIGN KEY
-- Contexto: ventas diarias de una cafeteria.

-- SQLite NO aplica las FOREIGN KEY por defecto: hay que activarlas en cada
-- conexion con este PRAGMA. Sin el, todo lo demas de este ejercicio (los
-- dos casos que deben fallar) simplemente NO fallaria, y las llaves
-- foraneas quedarian como simple documentacion sin efecto real.
PRAGMA foreign_keys = ON;

CREATE TABLE clientes (
    id_cliente  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    correo      TEXT UNIQUE
);

CREATE TABLE productos (
    id_producto  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL UNIQUE,
    precio       REAL NOT NULL CHECK (precio > 0)
);

-- ventas: tabla principal. id_cliente e id_producto son FOREIGN KEY: cada
-- una apunta a la PRIMARY KEY de su tabla de catalogo, y garantiza que no
-- se pueda registrar una venta de un cliente o un producto que no existe.
CREATE TABLE ventas (
    id_venta      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente    INTEGER NOT NULL,
    id_producto   INTEGER NOT NULL,
    cantidad      INTEGER NOT NULL CHECK (cantidad > 0),
    fecha_venta   TEXT NOT NULL,

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto)
);
