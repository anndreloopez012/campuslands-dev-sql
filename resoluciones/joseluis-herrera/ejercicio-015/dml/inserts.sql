INSERT INTO clientes (id_cliente, nombre, telefono, email) VALUES
(1, 'Carlos Ramirez', '55510001', 'carlos.ramirez@gmail.com'),
(2, 'Ana Lopez', '55510002', 'ana.lopez@gmail.com'),
(3, 'Luis Martinez', '55510003', 'luis.martinez@gmail.com'),
(4, 'Sofia Garcia', '55510004', 'sofia.garcia@gmail.com'),
(5, 'Diego Castillo', '55510005', 'diego.castillo@gmail.com');

INSERT INTO motos (id_moto, id_cliente, placa, marca, modelo, anio) VALUES
(1, 1, 'MOT001', 'Honda', 'CB190R', 2022),
(2, 2, 'MOT002', 'Yamaha', 'FZ25', 2021),
(3, 3, 'MOT003', 'Suzuki', 'GSX150', 2023),
(4, 4, 'MOT004', 'Kawasaki', 'Ninja 400', 2022),
(5, 5, 'MOT005', 'Bajaj', 'Pulsar NS200', 2020);

INSERT INTO servicios (id_servicio, nombre, descripcion, precio_base) VALUES
(1, 'Cambio de aceite', 'Cambio de aceite y revision basica del motor', 180.00),
(2, 'Revision de frenos', 'Inspeccion y ajuste del sistema de frenos', 250.00),
(3, 'Cambio de cadena', 'Reemplazo y tension de cadena de transmision', 450.00),
(4, 'Mantenimiento general', 'Revision general de componentes de la motocicleta', 600.00),
(5, 'Cambio de llanta', 'Instalacion y balanceo de llanta', 350.00);

INSERT INTO ordenes_servicio (
    id_orden,
    id_moto,
    id_servicio,
    fecha,
    kilometraje,
    costo,
    estado
) VALUES
(1, 1, 1, '2026-08-01', 12500, 180.00, 'finalizada'),
(2, 2, 2, '2026-08-02', 18200, 250.00, 'finalizada'),
(3, 3, 3, '2026-08-03', 9700, 450.00, 'en_proceso'),
(4, 4, 4, '2026-08-04', 15400, 600.00, 'finalizada'),
(5, 5, 5, '2026-08-05', 22000, 350.00, 'recibida'),
(6, 1, 4, '2026-08-06', 13100, 600.00, 'finalizada'),
(7, 2, 1, '2026-08-07', 19000, 180.00, 'finalizada'),
(8, 3, 2, '2026-08-08', 10300, 250.00, 'en_proceso'),
(9, 4, 3, '2026-08-09', 16100, 450.00, 'recibida'),
(10, 5, 4, '2026-08-10', 23100, 600.00, 'finalizada');