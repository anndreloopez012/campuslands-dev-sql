INSERT INTO clientes VALUES
(6,'Maria Hernandez','40010006','55510006','Amatitlan');

INSERT INTO paquetes VALUES
(6,6,'Tablet',1.8,'P006');

UPDATE clientes
SET telefono='55519999'
WHERE id_cliente=6;

UPDATE paquetes
SET peso_kg=2.0
WHERE id_paquete=6;

DELETE FROM paquetes
WHERE id_paquete=6;

DELETE FROM clientes
WHERE id_cliente=6;

-- INSERT INTO clientes VALUES
-- (7,'Cliente','40010007','55510007','Guatemala');

-- INSERT INTO paquetes VALUES
-- (7,999,'Paquete Invalido',1.5,'P007');