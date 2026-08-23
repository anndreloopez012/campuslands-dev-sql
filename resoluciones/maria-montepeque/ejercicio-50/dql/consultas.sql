.headers on
.mode column

-- Ejercicio 50: UNIQUE Nivel Basico
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT * FROM libros;

-- 2. Consulta con WHERE.
SELECT titulo, isbn
FROM libros
WHERE isbn IS NOT NULL;

-- 3. Consulta con ORDER BY.
SELECT titulo, isbn
FROM libros
ORDER BY titulo;

-- 4. Conteo o resumen.
SELECT
    COUNT(*) AS total_libros,
    COUNT(isbn) AS libros_con_isbn,
    COUNT(*) - COUNT(isbn) AS libros_sin_isbn
FROM libros;

-- 5. Validacion especifica del tema UNIQUE:
--    a) confirmar que no hay isbn repetidos entre los libros que si lo
--       tienen: si UNIQUE no estuviera funcionando, el total de isbn
--       distintos seria menor que el total de libros con isbn.
SELECT
    COUNT(isbn) AS libros_con_isbn,
    COUNT(DISTINCT isbn) AS isbn_distintos
FROM libros;

--    b) los libros sin isbn (NULL) conviven sin problema, aunque haya mas
--       de uno: UNIQUE no los considera duplicados entre si.
SELECT titulo
FROM libros
WHERE isbn IS NULL;
