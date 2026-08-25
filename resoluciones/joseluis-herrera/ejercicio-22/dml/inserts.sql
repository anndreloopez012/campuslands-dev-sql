INSERT INTO clientes VALUES
(1,'Carlos Ramirez','50010001','55510001','Zona 1'),
(2,'Ana Lopez','50010002','55510002','Zona 5'),
(3,'Luis Martinez','50010003','55510003','Zona 7'),
(4,'Sofia Garcia','50010004','55510004','Zona 10'),
(5,'Diego Castillo','50010005','55510005','Mixco');

INSERT INTO restaurantes VALUES
(1,'Pizza House','Pizza','Zona 4',4.8),
(2,'Burger City','Hamburguesas','Zona 9',4.6),
(3,'Sushi Go','Sushi','Zona 10',4.9),
(4,'Taco Express','Mexicana','Zona 11',4.4),
(5,'Pasta Italia','Italiana','Zona 14',4.7);

INSERT INTO repartidores VALUES
(1,'Miguel Perez','MOT001','55520001','DISPONIBLE'),
(2,'Laura Gomez','MOT002','55520002','OCUPADO'),
(3,'Jose Morales','MOT003','55520003','DISPONIBLE'),
(4,'Andrea Ruiz','MOT004','55520004','OCUPADO'),
(5,'Pedro Diaz','MOT005','55520005','DISPONIBLE');

INSERT INTO pedidos VALUES
(1,1,1,1,'2026-08-01 12:10',95,'ENTREGADO'),
(2,2,2,2,'2026-08-01 13:20',75,'ENTREGADO'),
(3,3,3,3,'2026-08-02 18:00',160,'EN_CAMINO'),
(4,4,4,4,'2026-08-02 19:30',60,'PREPARANDO'),
(5,5,5,5,'2026-08-03 20:15',120,'PENDIENTE'),
(6,1,2,1,'2026-08-04 11:45',85,'ENTREGADO'),
(7,2,3,3,'2026-08-04 18:25',145,'EN_CAMINO'),
(8,3,1,5,'2026-08-05 12:30',110,'ENTREGADO'),
(9,4,5,2,'2026-08-05 19:10',130,'PREPARANDO'),
(10,5,4,4,'2026-08-06 21:00',70,'ENTREGADO');