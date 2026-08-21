PRAGMA foreign_keys = ON;

-- Ejercicio 044: Diseno 3D Arquitectura
-- Datos de prueba.

INSERT INTO clientes (nombre_cliente, email) VALUES
    ('Constructora Ceibal', 'contacto@ceibal.com'),
    ('Grupo Inmobiliario Norte', 'proyectos@inmobiliarianorte.com'),
    ('Desarrollos Pacifico', 'info@desarrollospacifico.com'),
    ('Residencial Las Flores', 'ventas@lasflores.com'),
    ('Torre Central S.A.', 'contacto@torrecentral.com');

-- Constructora Ceibal (id_cliente = 1) tiene dos proyectos.
INSERT INTO proyectos (nombre_proyecto, id_cliente, fecha_inicio) VALUES
    ('Torre Ceibal Fase 1', 1, '2026-07-01'),
    ('Residencial Norte Lotes A', 2, '2026-07-10'),
    ('Plaza Pacifico', 3, '2026-07-15'),
    ('Casas Las Flores Modelo B', 4, '2026-07-20'),
    ('Torre Central Lobby', 5, '2026-07-25'),
    ('Torre Ceibal Fase 2', 1, '2026-08-01');

-- El render 11 es un duplicado por error de digitacion (mismo
-- proyecto, nombre, fecha y estado que el render 1): se corrige en
-- dml/operaciones.sql. El render 10 es una prueba que se creo por
-- error, sigue 'en_proceso' y nunca se envio a revision: se borrara
-- de forma controlada.
INSERT INTO renders (id_proyecto, nombre_render, fecha_entrega_estimada, estado) VALUES
    (1, 'Fachada Principal', '2026-08-05', 'aprobado'),
    (2, 'Vista Aerea Lotes', '2026-08-06', 'en_revision'),
    (3, 'Interior Plaza Nivel 1', '2026-08-08', 'en_proceso'),
    (4, 'Fachada Modelo B', '2026-08-04', 'aprobado'),
    (1, 'Interior Torre - Piso 10', '2026-08-10', 'en_revision'),
    (5, 'Lobby Render Nocturno', '2026-08-07', 'rechazado'),
    (6, 'Fachada Fase 2', '2026-08-12', 'en_proceso'),
    (2, 'Vista Nocturna Lotes', '2026-08-09', 'aprobado'),
    (3, 'Fachada Plaza Pacifico', '2026-08-11', 'en_proceso'),
    (1, 'Prueba Render Duplicado', '2026-08-13', 'en_proceso'),
    (1, 'Fachada Principal', '2026-08-05', 'aprobado');

INSERT INTO revisiones (id_render, fecha_revision, comentario, resultado) VALUES
    (1, '2026-08-05', 'Se aprueba sin cambios', 'aprobado'),
    (2, '2026-08-06', 'Falta detalle en fachada norte', 'cambios_solicitados'),
    (4, '2026-08-04', 'Se aprueba, listo para entrega', 'aprobado'),
    (5, '2026-08-10', 'Iluminacion interior muy oscura', 'cambios_solicitados'),
    (6, '2026-08-07', 'No cumple con la iluminacion solicitada', 'cambios_solicitados'),
    (8, '2026-08-09', 'Colores correctos, se aprueba', 'aprobado');

-- Casos comentados que deben fallar (no ser recomendables), dejar
-- comentados:

-- 1) Registro repetido: nombre_proyecto ya existe, viola el UNIQUE.
-- INSERT INTO proyectos (nombre_proyecto, id_cliente, fecha_inicio) VALUES ('Plaza Pacifico', 2, '2026-08-15');

-- 2) Valor fuera de rango: estado no valido, viola el CHECK.
-- INSERT INTO renders (id_proyecto, nombre_render, fecha_entrega_estimada, estado) VALUES (2, 'Render Cancelado', '2026-08-15', 'cancelado');
