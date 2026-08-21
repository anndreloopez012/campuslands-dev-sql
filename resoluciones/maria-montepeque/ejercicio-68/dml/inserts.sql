PRAGMA foreign_keys = ON;

-- Ejercicio 68: DROP Nivel Basico
-- Se ejecuta despues de que ddl/schema.sql migro los datos y elimino la
-- tabla temporal, el indice y la vista de apoyo. Aqui solo se agregan
-- libros nuevos directamente a la tabla definitiva.

INSERT INTO libros (titulo, categoria) VALUES
    ('Kafka: The Definitive Guide', 'bases_de_datos'),
    ('Sistemas Operativos Modernos', 'sistemas_operativos');

INSERT INTO libros (titulo, categoria, disponible) VALUES
    ('Computer Networking: A Top-Down Approach', 'redes', 0);
