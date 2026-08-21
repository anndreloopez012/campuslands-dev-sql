INSERT INTO viajes (
    id_viaje,
    id_ruta,
    id_bus,
    id_conductor,
    fecha_viaje,
    hora_salida,
    pasajeros,
    estado
) VALUES (
    11,
    1,
    3,
    5,
    '2026-08-26',
    '07:00',
    38,
    'Programado'
);

INSERT INTO viajes (
    id_viaje,
    id_ruta,
    id_bus,
    id_conductor,
    fecha_viaje,
    hora_salida,
    pasajeros,
    estado
) VALUES (
    12,
    2,
    4,
    1,
    '2026-08-26',
    '09:00',
    44,
    'Programado'
);

UPDATE buses
SET capacidad = 48
WHERE id_bus = 3;

UPDATE conductores
SET experiencia_anios = 13
WHERE id_conductor = 2;

DELETE FROM viajes
WHERE id_viaje = 11;

DELETE FROM viajes
WHERE id_viaje = 12;