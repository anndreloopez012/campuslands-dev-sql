PRAGMA foreign_keys = ON;

-- Ejercicio 64: AUTO_INCREMENT Nivel Aplicado
-- Datos base: 3 autores, 6 libros, prestamos con numero de comprobante
-- generado por AUTOINCREMENT.

INSERT INTO autores (nombre) VALUES
    ('Robert C. Martin'),
    ('Andrew S. Tanenbaum'),
    ('Martin Kleppmann');

INSERT INTO libros (id_autor, titulo, categoria, ejemplares_disponibles) VALUES
    (1, 'Clean Code', 'programacion', 3),
    (1, 'Clean Architecture', 'programacion', 2),
    (2, 'Redes de Computadoras', 'redes', 2),
    (2, 'Sistemas Operativos Modernos', 'sistemas_operativos', 2),
    (3, 'Designing Data-Intensive Applications', 'bases_de_datos', 1),
    (3, 'Kafka: The Definitive Guide', 'bases_de_datos', 2);

-- prestamos: no se indica el id, AUTOINCREMENT genera el numero de
-- comprobante (id_prestamo).
INSERT INTO prestamos (id_libro, prestatario, fecha_prestamo, fecha_devolucion, estado) VALUES
    (1, 'Manuel Estrada', '2026-08-01', NULL, 'prestado'),
    (2, 'Alejandra Chinchilla', '2026-08-02', '2026-08-10', 'devuelto'),
    (1, 'Byron Xicay', '2026-08-03', NULL, 'prestado'),
    (3, 'Cristina Barrios', '2026-08-04', NULL, 'atrasado'),
    (5, 'Douglas Pineda', '2026-08-05', '2026-08-12', 'devuelto'),
    (4, 'Manuel Estrada', '2026-08-06', NULL, 'prestado');
-- ids esperados 1..6, asignados automaticamente por AUTOINCREMENT.

-- Se anula el comprobante 3 (Byron Xicay, registrado por error dos
-- veces el mismo dia) para demostrar que AUTOINCREMENT nunca reutiliza
-- un numero de comprobante ya emitido.
DELETE FROM prestamos WHERE id_prestamo = 3;

-- Nuevo prestamo: SQLite le asigna el comprobante 7, NO el 3 que quedo
-- libre. Esto es clave en un sistema real: un comprobante anulado no
-- deberia volver a aparecer identificando un prestamo distinto.
INSERT INTO prestamos (id_libro, prestatario, fecha_prestamo, estado) VALUES
    (1, 'Byron Xicay', '2026-08-07', 'prestado');

-- Caso que debe fallar (queda comentado): prestar un libro que no existe
-- en el catalogo viola la FOREIGN KEY de prestamos.id_libro.
-- INSERT INTO prestamos (id_libro, prestatario) VALUES (999, 'Ingrid Say');
