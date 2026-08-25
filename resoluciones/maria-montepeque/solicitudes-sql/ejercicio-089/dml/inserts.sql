PRAGMA foreign_keys = ON;

-- Ejercicio 089: Mecanica de Autos
-- Datos base: 3 clientes, 3 vehiculos, 4 diagnosticos, 4 reparaciones
-- (2 completadas, 2 pendientes), 4 repuestos y 5 lineas de detalle
-- (incluye 1 cargada por error en una reparacion todavia pendiente).

INSERT INTO clientes (nombre_cliente, telefono) VALUES
    ('Manuel Estrada', '5555-6301'),
    ('Alejandra Chinchilla', '5555-6302'),
    ('Byron Xicay', '5555-6303');

INSERT INTO vehiculos (id_cliente, placa, modelo) VALUES
    (1, 'P-101ABC', 'Toyota Corolla'),
    (2, 'P-102DEF', 'Honda Civic'),
    (3, 'P-103GHI', 'Nissan Sentra');

INSERT INTO repuestos (nombre_repuesto, precio_unitario) VALUES
    ('Pastillas de Freno', 250.00),
    ('Filtro de Aceite', 80.00),
    ('Bujia NGK', 45.00),
    ('Bateria 12V', 600.00);

-- Diagnostico 1: Toyota Corolla de Manuel, frenos desgastados.
INSERT INTO diagnosticos (id_vehiculo, fecha_diagnostico, descripcion, gravedad) VALUES
    (1, '2026-08-01', 'Frenos desgastados', 'moderada');
INSERT INTO reparaciones (id_diagnostico, fecha_reparacion, estado, costo_mano_obra) VALUES
    (1, '2026-08-02', 'completada', 300.00);
INSERT INTO detalle_repuestos (id_reparacion, id_repuesto, cantidad) VALUES
    (1, 1, 1);

-- Diagnostico 2: Honda Civic de Alejandra, fuga de aceite.
INSERT INTO diagnosticos (id_vehiculo, fecha_diagnostico, descripcion, gravedad) VALUES
    (2, '2026-08-02', 'Fuga de aceite', 'grave');
INSERT INTO reparaciones (id_diagnostico, fecha_reparacion, estado, costo_mano_obra) VALUES
    (2, '2026-08-03', 'completada', 500.00);
INSERT INTO detalle_repuestos (id_reparacion, id_repuesto, cantidad) VALUES
    (2, 2, 1);

-- Diagnostico 3: Nissan Sentra de Byron, bujias en mal estado.
INSERT INTO diagnosticos (id_vehiculo, fecha_diagnostico, descripcion, gravedad) VALUES
    (3, '2026-08-03', 'Bujias en mal estado', 'leve');
INSERT INTO reparaciones (id_diagnostico, fecha_reparacion, estado, costo_mano_obra) VALUES
    (3, '2026-08-04', 'pendiente', 150.00);
INSERT INTO detalle_repuestos (id_reparacion, id_repuesto, cantidad) VALUES
    (3, 3, 4);

-- Linea de repuesto cargada por error para la reparacion 3 (todavia
-- 'pendiente'): el mecanico anoto un filtro de aceite que este
-- vehiculo no necesita. Se corrige con DELETE en
-- dml/operaciones.sql.
INSERT INTO detalle_repuestos (id_reparacion, id_repuesto, cantidad) VALUES
    (3, 2, 1);

-- Diagnostico 4: Toyota Corolla de Manuel otra vez, bateria
-- descargada.
INSERT INTO diagnosticos (id_vehiculo, fecha_diagnostico, descripcion, gravedad) VALUES
    (1, '2026-08-10', 'Bateria descargada', 'leve');
INSERT INTO reparaciones (id_diagnostico, fecha_reparacion, estado, costo_mano_obra) VALUES
    (4, '2026-08-11', 'pendiente', 100.00);
INSERT INTO detalle_repuestos (id_reparacion, id_repuesto, cantidad) VALUES
    (4, 4, 1);

-- Caso comentado que debe fallar (queda comentado): registrar una
-- segunda reparacion oficial para el diagnostico 1, exactamente el
-- problema de historico contradictorio que este UNIQUE esta disenado
-- para evitar.
-- INSERT INTO reparaciones (id_diagnostico, fecha_reparacion, estado, costo_mano_obra) VALUES (1, '2026-08-03', 'pendiente', 50.00);
