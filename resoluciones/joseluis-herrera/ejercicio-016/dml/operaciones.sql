INSERT INTO aeropuertos (
    id_aeropuerto,
    codigo,
    nombre,
    ciudad,
    pais
) VALUES (
    6,
    'LIM',
    'Aeropuerto Internacional Jorge Chavez',
    'Lima',
    'Peru'
);

INSERT INTO aviones (
    id_avion,
    matricula,
    modelo,
    capacidad,
    estado
) VALUES (
    6,
    'N606FF',
    'Airbus A319',
    156,
    'activo'
);

UPDATE aeropuertos
SET ciudad = 'Ciudad de Guatemala'
WHERE id_aeropuerto = 1;

UPDATE aviones
SET estado = 'activo'
WHERE id_avion = 4;

DELETE FROM aeropuertos
WHERE id_aeropuerto = 6;

DELETE FROM aviones
WHERE id_avion = 6;

-- OPERACION INVALIDA: UNIQUE
-- INSERT INTO aeropuertos (
--     id_aeropuerto,
--     codigo,
--     nombre,
--     ciudad,
--     pais
-- ) VALUES (
--     7,
--     'GUA',
--     'Aeropuerto Duplicado',
--     'Guatemala',
--     'Guatemala'
-- );

-- OPERACION INVALIDA: CHECK
-- INSERT INTO aviones (
--     id_avion,
--     matricula,
--     modelo,
--     capacidad,
--     estado
-- ) VALUES (
--     7,
--     'N707GG',
--     'Modelo Invalido',
--     -50,
--     'activo'
-- );