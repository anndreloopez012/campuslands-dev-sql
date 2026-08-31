.headers on
.mode column

-- Ejercicio 100: Vistas Nivel Aplicado
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales usando la vista de disponibilidad.
SELECT * FROM vista_disponibilidad_libros;

-- 2. Consulta con WHERE: solo los prestamos que siguen activos.
SELECT id_prestamo, id_libro, nombre_prestatario, fecha_prestamo
FROM prestamos
WHERE estado = 'prestado';

-- 3. Consulta con ORDER BY: prestamos ordenados por fecha.
SELECT id_prestamo, id_libro, estado, fecha_prestamo
FROM prestamos
ORDER BY fecha_prestamo;

-- 4. Conteo o resumen: total de prestamos historicos por libro.
SELECT id_libro, COUNT(*) AS total_prestamos
FROM prestamos
GROUP BY id_libro;

-- 5. Caso de negocio con Vistas: reporte final de libros agotados
-- (sin copias disponibles ahora mismo), filtrando directamente sobre
-- vista_disponibilidad_libros. La vista ya calculo
-- "copias_disponibles" combinando libros, autores y el conteo de
-- prestamos activos; el reporte de negocio solo necesita agregar
-- "WHERE copias_disponibles <= 0" sobre ella, sin repetir el JOIN ni
-- el CASE de conteo.
SELECT titulo, nombre_autor, stock_total, prestamos_activos, copias_disponibles
FROM vista_disponibilidad_libros
WHERE copias_disponibles <= 0;

-- Caso comentado que no es recomendable, dejar comentado: intentar
-- "actualizar" la definicion de una vista existente con
-- CREATE VIEW IF NOT EXISTS. Como la vista ya existe, SQLite no lanza
-- error, pero tampoco reemplaza su definicion: la ignora en
-- silencio. Se verifico con Python (sqlite3) que, despues de correr
-- esta sentencia con un umbral distinto (copias_disponibles <= 1),
-- vista_disponibilidad_libros sigue siendo exactamente la definicion
-- original. SQLite no tiene "CREATE OR REPLACE VIEW"; la forma
-- correcta de cambiar una vista es "DROP VIEW nombre_vista;" seguido
-- de un "CREATE VIEW nombre_vista AS ...".
-- CREATE VIEW IF NOT EXISTS vista_disponibilidad_libros AS
-- SELECT l.id_libro, l.titulo, l.stock_total
-- FROM libros l
-- WHERE l.stock_total <= 1;
