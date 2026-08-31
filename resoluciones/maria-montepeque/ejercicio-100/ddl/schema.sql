PRAGMA foreign_keys = ON;

-- Ejercicio 100: Vistas Nivel Aplicado
-- Tema central: Vistas
-- Contexto: prestamos de libros tecnicos en una biblioteca.

CREATE TABLE autores (
    id_autor      INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_autor  TEXT NOT NULL UNIQUE
);

CREATE TABLE libros (
    id_libro      INTEGER PRIMARY KEY AUTOINCREMENT,
    id_autor      INTEGER NOT NULL,
    titulo        TEXT NOT NULL,
    stock_total   INTEGER NOT NULL CHECK (stock_total > 0),

    FOREIGN KEY (id_autor) REFERENCES autores (id_autor)
);

CREATE TABLE prestamos (
    id_prestamo          INTEGER PRIMARY KEY AUTOINCREMENT,
    id_libro             INTEGER NOT NULL,
    nombre_prestatario    TEXT NOT NULL,
    fecha_prestamo        TEXT NOT NULL,
    estado                TEXT NOT NULL DEFAULT 'prestado'
                              CHECK (estado IN ('prestado', 'devuelto')),

    FOREIGN KEY (id_libro) REFERENCES libros (id_libro)
);

-- Vista: reporte de negocio final. Calcula, para cada libro, cuantos
-- prestamos siguen activos (estado = 'prestado') y cuantas copias
-- quedan disponibles (stock_total menos los prestamos activos), sin
-- que quien consulte el reporte tenga que repetir el JOIN con
-- autores ni la logica de conteo cada vez.
CREATE VIEW vista_disponibilidad_libros AS
SELECT l.id_libro,
       l.titulo,
       a.nombre_autor,
       l.stock_total,
       COUNT(CASE WHEN p.estado = 'prestado' THEN 1 END) AS prestamos_activos,
       l.stock_total - COUNT(CASE WHEN p.estado = 'prestado' THEN 1 END) AS copias_disponibles
FROM libros l
JOIN autores a ON a.id_autor = l.id_autor
LEFT JOIN prestamos p ON p.id_libro = l.id_libro
GROUP BY l.id_libro, l.titulo, a.nombre_autor, l.stock_total;
