-- Mostrar películas
SELECT * FROM peliculas;

-- Mostrar salas
SELECT * FROM salas;

-- Mostrar funciones con película y sala
SELECT
    f.id_funcion,
    p.nombre_pelicula,
    s.nombre_sala,
    f.fecha_funcion,
    f.hora_funcion,
    f.precio,
    f.estado
FROM funciones f
INNER JOIN peliculas p
    ON f.id_pelicula = p.id_pelicula
INNER JOIN salas s
    ON f.id_sala = s.id_sala;

-- Mostrar boletos vendidos o reservados
SELECT
    b.id_boleto,
    p.nombre_pelicula,
    s.nombre_sala,
    f.fecha_funcion,
    f.hora_funcion,
    b.numero_asiento,
    b.comprador,
    b.precio_pagado,
    b.estado
FROM boletos b
INNER JOIN funciones f
    ON b.id_funcion = f.id_funcion
INNER JOIN peliculas p
    ON f.id_pelicula = p.id_pelicula
INNER JOIN salas s
    ON f.id_sala = s.id_sala;