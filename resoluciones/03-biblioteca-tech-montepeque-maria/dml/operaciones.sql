PRAGMA foreign_keys = ON;

-- Ejercicio 03: Biblioteca Tech

INSERT INTO
    socios (
        nombre,
        email,
        fecha_registro,
        estado
    )
VALUES (
        'Pedro Castillo',
        'pedro@biblioteca.com',
        '2024-08-01',
        'activo'
    );

INSERT INTO
    libros (
        titulo,
        isbn,
        anio_publicacion,
        precio,
        stock,
        estado,
        categoria_id,
        autor_id
    )
VALUES (
        'Designing Data-Intensive Applications',
        '978-1449373320',
        2017,
        480.00,
        4,
        'disponible',
        2,
        6
    );

INSERT INTO
    prestamos (
        libro_id,
        socio_id,
        fecha_prestamo,
        fecha_devolucion,
        estado
    )
VALUES (
        11,
        7,
        '2024-08-05',
        NULL,
        'prestado'
    );

UPDATE prestamos
SET
    fecha_devolucion = '2024-08-15',
    estado = 'devuelto'
WHERE
    id = 2;

UPDATE libros
SET
    precio = ROUND(precio * 1.10, 2)
WHERE
    categoria_id = 1;

UPDATE libros
SET
    estado = 'agotado'
WHERE
    stock = 0
    AND estado <> 'agotado';

DELETE FROM prestamos WHERE libro_id = 11 AND socio_id = 7;

DELETE FROM socios
WHERE
    estado = 'inactivo'
    AND id NOT IN (
        SELECT DISTINCT
            socio_id
        FROM prestamos
    );