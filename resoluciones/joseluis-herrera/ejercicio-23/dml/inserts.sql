INSERT INTO clientes VALUES
(1,'Carlos Ramirez','CF001','carlos@email.com','Zona 1'),
(2,'Ana Lopez','CF002','ana@email.com','Zona 5'),
(3,'Luis Martinez','CF003','luis@email.com','Zona 7'),
(4,'Sofia Garcia','CF004','sofia@email.com','Zona 10'),
(5,'Diego Castillo','CF005','diego@email.com','Mixco');

INSERT INTO productos VALUES
(1,'Laptop',4500,10,'Tecnologia'),
(2,'Mouse',120,40,'Accesorios'),
(3,'Teclado',280,25,'Accesorios'),
(4,'Monitor',1350,12,'Tecnologia'),
(5,'SSD 1TB',850,18,'Almacenamiento');

INSERT INTO facturas VALUES
(1,1,'F0001','2026-08-01',12),
(2,2,'F0002','2026-08-02',12),
(3,3,'F0003','2026-08-03',12),
(4,4,'F0004','2026-08-04',12),
(5,5,'F0005','2026-08-05',12);

INSERT INTO detalle_factura VALUES
(1,1,1,1,4500),
(2,1,2,2,120),
(3,2,3,1,280),
(4,2,2,1,120),
(5,3,4,1,1350),
(6,3,5,2,850),
(7,4,1,1,4500),
(8,4,3,3,280),
(9,5,5,1,850),
(10,5,2,4,120);