PRAGMA foreign_keys = ON;

-- CLIENTES

INSERT INTO clientes (
    id_cliente,
    nombre_completo,
    telefono,
    correo,
    fecha_registro
) VALUES
    (1, 'Carlos Mendoza', '55510001', 'carlos.mendoza@email.com', '2026-01-10'),
    (2, 'Ana Rodriguez', '55510002', 'ana.rodriguez@email.com', '2026-01-15'),
    (3, 'Luis Herrera', '55510003', 'luis.herrera@email.com', '2026-02-03'),
    (4, 'Sofia Martinez', '55510004', 'sofia.martinez@email.com', '2026-02-18'),
    (5, 'Diego Ramirez', '55510005', 'diego.ramirez@email.com', '2026-03-01');

-- MOTOS

INSERT INTO motos (
    id_moto,
    id_cliente,
    placa,
    marca,
    modelo,
    anio,
    kilometraje
) VALUES
    (1, 1, 'MOT001', 'Honda', 'CB190R', 2022, 18500),
    (2, 1, 'MOT002', 'Yamaha', 'FZ25', 2021, 22300),
    (3, 2, 'MOT003', 'Suzuki', 'Gixxer 150', 2023, 12700),
    (4, 2, 'MOT004', 'Bajaj', 'Pulsar NS200', 2020, 31800),
    (5, 3, 'MOT005', 'Kawasaki', 'Z400', 2022, 15600),
    (6, 3, 'MOT006', 'Honda', 'XR150L', 2019, 40200),
    (7, 4, 'MOT007', 'Yamaha', 'MT-03', 2024, 8300),
    (8, 4, 'MOT008', 'Suzuki', 'DR650', 2018, 45700),
    (9, 5, 'MOT009', 'KTM', 'Duke 390', 2023, 11200),
    (10, 5, 'MOT010', 'Honda', 'CB500F', 2021, 27400);

-- SERVICIOS

INSERT INTO servicios (
    id_servicio,
    nombre,
    descripcion,
    precio_base,
    duracion_minutos
) VALUES
    (1, 'Cambio de aceite', 'Cambio de aceite y revision basica', 180.00, 45),
    (2, 'Ajuste de frenos', 'Revision y ajuste del sistema de frenos', 220.00, 60),
    (3, 'Cambio de cadena', 'Reemplazo y tension de cadena de transmision', 450.00, 90),
    (4, 'Revision general', 'Inspeccion general de componentes mecanicos', 300.00, 90),
    (5, 'Cambio de bujia', 'Reemplazo de bujia y comprobacion de encendido', 150.00, 40),
    (6, 'Servicio de suspension', 'Revision y mantenimiento de suspension', 650.00, 120),
    (7, 'Cambio de pastillas', 'Reemplazo de pastillas de freno', 380.00, 75),
    (8, 'Limpieza de carburador', 'Limpieza y ajuste del sistema de carburacion', 420.00, 100),
    (9, 'Diagnostico electrico', 'Revision del sistema electrico de la motocicleta', 280.00, 80),
    (10, 'Cambio de llanta', 'Montaje y balanceo de una llanta', 250.00, 60);

-- ORDENES DE SERVICIO

INSERT INTO ordenes_servicio (
    id_orden,
    id_moto,
    id_servicio,
    fecha_servicio,
    kilometraje,
    estado,
    precio_final,
    observaciones
) VALUES
    (1, 1, 1, '2026-01-12 09:00', 17800, 'Completado', 180.00, 'Servicio realizado correctamente'),
    (2, 2, 2, '2026-01-20 10:30', 21800, 'Completado', 220.00, 'Frenos ajustados'),
    (3, 3, 4, '2026-02-05 08:30', 12000, 'Completado', 300.00, 'Revision sin novedades'),
    (4, 4, 3, '2026-02-12 14:00', 31000, 'Completado', 450.00, 'Cadena reemplazada'),
    (5, 5, 5, '2026-02-20 11:00', 15100, 'Completado', 150.00, 'Bujia reemplazada'),
    (6, 6, 6, '2026-03-05 09:30', 39700, 'En proceso', 650.00, 'Revision de suspension pendiente'),
    (7, 7, 7, '2026-03-10 13:00', 8100, 'Completado', 380.00, 'Pastillas delanteras reemplazadas'),
    (8, 8, 8, '2026-03-15 15:30', 45100, 'Completado', 420.00, 'Carburador limpiado'),
    (9, 9, 9, '2026-03-20 10:00', 10800, 'Pendiente', 280.00, 'Pendiente de diagnostico'),
    (10, 10, 10, '2026-03-25 16:00', 26900, 'Completado', 250.00, 'Llanta reemplazada');