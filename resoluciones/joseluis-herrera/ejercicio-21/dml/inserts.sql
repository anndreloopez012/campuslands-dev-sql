INSERT INTO clientes VALUES
(1,'Carlos Ramirez','40010001','55510001','Guatemala'),
(2,'Ana Lopez','40010002','55510002','Mixco'),
(3,'Luis Martinez','40010003','55510003','Villa Nueva'),
(4,'Sofia Garcia','40010004','55510004','Antigua'),
(5,'Diego Castillo','40010005','55510005','Escuintla');

INSERT INTO rutas VALUES
(1,'Guatemala','Mixco',15,'R001'),
(2,'Guatemala','Antigua',45,'R002'),
(3,'Mixco','Villa Nueva',22,'R003'),
(4,'Guatemala','Escuintla',65,'R004'),
(5,'Antigua','Escuintla',58,'R005');

INSERT INTO paquetes VALUES
(1,1,'Laptop',2.5,'P001'),
(2,2,'Libros',4.2,'P002'),
(3,3,'Monitor',6.8,'P003'),
(4,4,'Teclado',1.1,'P004'),
(5,5,'Impresora',8.5,'P005');

INSERT INTO envios VALUES
(1,1,1,'2026-08-01',35,'entregado'),
(2,2,2,'2026-08-02',60,'entregado'),
(3,3,4,'2026-08-03',95,'en_transito'),
(4,4,3,'2026-08-04',28,'pendiente'),
(5,5,5,'2026-08-05',85,'entregado'),
(6,1,2,'2026-08-06',55,'en_transito'),
(7,2,1,'2026-08-07',30,'entregado'),
(8,3,4,'2026-08-08',98,'pendiente'),
(9,4,3,'2026-08-09',26,'en_transito'),
(10,5,5,'2026-08-10',88,'entregado');