INSERT INTO sedes VALUES
(1,'Biblioteca Central','Zona 1','Guatemala'),
(2,'Biblioteca Norte','Zona 5','Guatemala'),
(3,'Biblioteca Sur','Villa Nueva','Guatemala'),
(4,'Biblioteca Este','Carretera a El Salvador','Guatemala'),
(5,'Biblioteca Oeste','Mixco','Guatemala');

INSERT INTO libros VALUES
(1,1,'Clean Code','Robert C. Martin','ISBN001',5),
(2,2,'El Quijote','Miguel de Cervantes','ISBN002',3),
(3,3,'1984','George Orwell','ISBN003',4),
(4,4,'Python Avanzado','Luciano Ramalho','ISBN004',6),
(5,5,'SQL para Todos','Alan Beaulieu','ISBN005',8);

INSERT INTO usuarios VALUES
(1,'Carlos Ramirez','70010001','carlos@email.com','55530001'),
(2,'Ana Lopez','70010002','ana@email.com','55530002'),
(3,'Luis Martinez','70010003','luis@email.com','55530003'),
(4,'Sofia Garcia','70010004','sofia@email.com','55530004'),
(5,'Diego Castillo','70010005','diego@email.com','55530005');

INSERT INTO prestamos VALUES
(1,1,1,'2026-08-01','2026-08-08','DEVUELTO'),
(2,2,2,'2026-08-02',NULL,'ACTIVO'),
(3,3,3,'2026-08-03','2026-08-10','DEVUELTO'),
(4,4,4,'2026-08-04',NULL,'ATRASADO'),
(5,5,5,'2026-08-05',NULL,'ACTIVO'),
(6,1,2,'2026-08-06',NULL,'ACTIVO'),
(7,2,3,'2026-08-07','2026-08-14','DEVUELTO'),
(8,3,4,'2026-08-08',NULL,'ATRASADO'),
(9,4,5,'2026-08-09',NULL,'ACTIVO'),
(10,5,1,'2026-08-10',NULL,'ACTIVO');