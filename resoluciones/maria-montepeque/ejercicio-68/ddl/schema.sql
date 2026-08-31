PRAGMA foreign_keys = ON;

-- Ejercicio 68: DROP Nivel Basico
-- Tema central: DROP
-- Contexto: prestamos de libros tecnicos de una biblioteca.

-- Tabla principal, permanente.
CREATE TABLE libros (
    id_libro     INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo       TEXT NOT NULL UNIQUE,
    categoria    TEXT NOT NULL
                     CHECK (categoria IN ('programacion', 'redes', 'bases_de_datos', 'sistemas_operativos')),
    disponible   INTEGER NOT NULL DEFAULT 1 CHECK (disponible IN (0, 1))
);

-- Tabla temporal de importacion: la biblioteca recibio un listado de
-- libros nuevos en un formato plano, sin las restricciones finales, y
-- se uso esta tabla solo para migrar los datos a la tabla definitiva.
CREATE TABLE libros_importacion_temporal (
    titulo_bruto      TEXT,
    categoria_bruta   TEXT
);

INSERT INTO libros_importacion_temporal (titulo_bruto, categoria_bruta) VALUES
    ('Clean Code', 'programacion'),
    ('Redes de Computadoras', 'redes'),
    ('Designing Data-Intensive Applications', 'bases_de_datos');

-- Se migran los datos ya validados hacia la tabla definitiva.
INSERT INTO libros (titulo, categoria)
SELECT titulo_bruto, categoria_bruta FROM libros_importacion_temporal;

-- DROP TABLE: la tabla de importacion ya cumplio su proposito (los
-- datos ya viven en `libros`) y se elimina para no dejar datos
-- duplicados ni confundir a quien use la base de datos despues. Este es
-- el riesgo de DROP: si se ejecutara antes de migrar los datos, esa
-- informacion se perderia para siempre.
DROP TABLE libros_importacion_temporal;

-- Se crea un indice para acelerar busquedas por categoria...
CREATE INDEX idx_libros_categoria ON libros (categoria);

-- ...pero la biblioteca decide que, con tan pocos libros, el indice no
-- aporta beneficio y prefiere no mantenerlo. DROP INDEX lo elimina sin
-- afectar los datos de la tabla.
DROP INDEX idx_libros_categoria;

-- Se crea una vista de apoyo para un reporte puntual...
CREATE VIEW vista_libros_programacion AS
    SELECT id_libro, titulo, disponible
    FROM libros
    WHERE categoria = 'programacion';

-- ...y una vez entregado el reporte, se elimina porque ya no se va a
-- reutilizar. DROP VIEW solo borra la definicion de la vista: los datos
-- de `libros` siguen intactos.
DROP VIEW vista_libros_programacion;

-- Caso que debe fallar / no recomendable (queda comentado): intentar
-- eliminar una tabla que no existe (por ejemplo, por un error de tipeo
-- o porque ya se elimino antes) falla si no se usa IF EXISTS.
-- DROP TABLE libros_importacion_temporal;
