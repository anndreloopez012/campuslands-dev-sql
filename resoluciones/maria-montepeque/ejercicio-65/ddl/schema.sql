PRAGMA foreign_keys = ON;

-- Ejercicio 65: ALTER TABLE Nivel Basico
-- Tema central: ALTER TABLE
-- Contexto: ventas diarias de una cafeteria.

-- Tabla principal: version inicial de productos, tal como se creo antes
-- de que el negocio pidiera nuevos datos.
CREATE TABLE productos (
    id_producto   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre        TEXT NOT NULL UNIQUE,
    precio        REAL NOT NULL CHECK (precio > 0)
);

-- Se insertan productos con la estructura original, antes de modificar
-- la tabla. Esto sirve para demostrar, mas adelante, que ALTER TABLE no
-- destruye los datos ya existentes.
INSERT INTO productos (nombre, precio) VALUES
    ('Cafe Americano', 15.00),
    ('Capuchino', 18.50),
    ('Pastel de Chocolate', 22.00);

-- ALTER TABLE 1: el negocio pide clasificar los productos por
-- categoria. Se agrega la columna con DEFAULT para que las 3 filas ya
-- existentes queden validas de inmediato (si se agregara NOT NULL sin
-- DEFAULT, SQLite rechazaria el ALTER porque esas filas no tendrian
-- valor para la columna nueva).
ALTER TABLE productos
    ADD COLUMN categoria TEXT NOT NULL DEFAULT 'bebida'
        CHECK (categoria IN ('bebida', 'postre', 'snack'));

-- ALTER TABLE 2: el negocio pide saber si un producto sigue a la venta.
ALTER TABLE productos
    ADD COLUMN disponible INTEGER NOT NULL DEFAULT 1
        CHECK (disponible IN (0, 1));

-- ALTER TABLE 3: renombrar una columna para que el nombre sea mas claro
-- (precio -> precio_unitario), ahora que la tabla tiene mas columnas.
ALTER TABLE productos
    RENAME COLUMN precio TO precio_unitario;

-- Caso que debe fallar / no recomendable (queda comentado): en SQLite,
-- ALTER TABLE ... ADD COLUMN con NOT NULL y sin DEFAULT falla si la
-- tabla ya tiene filas, porque no sabria que valor poner en las filas
-- existentes.
-- ALTER TABLE productos ADD COLUMN codigo_interno TEXT NOT NULL;
