PRAGMA foreign_keys = ON;

-- Ejercicio 65: ALTER TABLE Nivel Basico
-- Se ejecuta despues de los ALTER TABLE de ddl/schema.sql, por eso ya se
-- pueden usar las columnas nuevas (categoria, disponible) y el nombre
-- nuevo de columna (precio_unitario).

-- Los 3 productos originales llegaron con categoria = 'bebida' por el
-- DEFAULT del ALTER TABLE. Se corrige la categoria real del que no es
-- bebida.
UPDATE productos SET categoria = 'postre' WHERE nombre = 'Pastel de Chocolate';

-- Producto nuevo, creado ya con la estructura final (todas las columnas
-- indicadas de forma explicita, sin depender de los DEFAULT).
INSERT INTO productos (nombre, precio_unitario, categoria, disponible) VALUES
    ('Te Helado', 12.00, 'bebida', 0);
