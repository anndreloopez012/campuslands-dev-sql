PRAGMA foreign_keys = ON;

-- Ejercicio 02: Campus Shop
-- Agregue aqui INSERT, UPDATE y DELETE adicionales.

-- INSERT validos:

/* ====================================================
                 UPDATE validos con WHERE
   ==================================================== */ 
UPDATE productos SET precio = 100 WHERE id=1; 
UPDATE clientes SET nombre = 'Juan' WHERE nombre LIKE '%Martin%';
UPDATE categoria SET nombre_categoria='Tec' WHERE nombre_categoria = 'Tecnologia'

    -- PRUEBA
    
SELECT * FROM productos;
SELECT * FROM clientes;
SELECT * FROM categoria;



/* ====================================================
                DELETE controlados con WHERE
   ==================================================== */ 

DELETE FROM clientes WHERE nombre = 'Juan'



-- Casos que deben fallar por restricciones, dejelos comentados:
    --  Las maneras en que puede fallar delete es cuando queramos eliminar datos los cuales estan relacionados con otra tabla, al momento de realizar este ejercicio me doy cuenta que las relaciones son muy importantes.

-- INSERT INTO ...;
INSERT INTO clientes(nombre, apellido, email, telefono) VALUES ('Martin', 'Juarez', 'ma@gmail.com', '82681923')


