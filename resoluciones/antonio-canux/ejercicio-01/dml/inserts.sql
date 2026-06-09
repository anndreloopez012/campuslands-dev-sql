PRAGMA foreign_keys = ON;

-- Inserte aqui los datos de prueba.
-- Requisitos minimos:
-- 5 peliculas, 5 salas, 8 funciones y 10 boletos.

-- Casos de error sugeridos:
-- Mantenga comentadas las inserciones que deben fallar para que el script principal ejecute correctamente.

INSERT INTO Peliculas VALUES
(1,'Interstellar',169,'Ciencia Ficcion','PG-13','Christopher Nolan','2014-11-07'),
(2,'Titanic',195,'Drama','PG-13','James Cameron','1997-12-19'),
(3,'Avatar',162,'Ciencia Ficcion','PG-13','James Cameron','2009-12-18'),
(4,'Gladiador',155,'Accion','R','Ridley Scott','2000-05-05'),
(5,'El Señor de los Anillos',178,'Fantasia','PG-13','Peter Jackson','2001-12-19');

INSERT INTO Salas VALUES
(1,'Sala A',120,'2D','Activa'),

(2,'Sala B',150,'3D','Activa'),
(3,'Sala C',100,'IMAX','Activa'),
(4,'Sala D',80,'2D','Mantenimiento'),
(5,'Sala E',200,'VIP','Activa');
-- (6,'Sala A',90,'2D','Activa'); EROOR(Nombre de sala duplicada)

INSERT INTO Funciones VALUES
(1,1,1,'2026-06-15','2026-06-15 14:00','2026-06-15 16:49','2D'),
(2,1,2,'2026-06-15','2026-06-15 18:00','2026-06-15 20:49','3D'),
(3,2,1,'2026-06-16','2026-06-16 15:00','2026-06-16 18:15','2D'),
(4,3,3,'2026-06-16','2026-06-16 17:00','2026-06-16 19:42','IMAX'),
(5,4,5,'2026-06-17','2026-06-17 13:00','2026-06-17 15:35','VIP'),
(6,5,5,'2026-06-17','2026-06-17 18:00','2026-06-17 20:58','VIP'),
(7,3,2,'2026-06-18','2026-06-18 16:00','2026-06-18 18:42','3D'),
(8,2,3,'2026-06-18','2026-06-18 20:00','2026-06-18 23:15','IMAX');
-- (9,99,1,'2026-06-20','2026-06-20 14:00','2026-06-20 16:00','2D'); ERROR(pelicula_id inexistente)

INSERT INTO Boletos VALUES
(1,1,10,45.00,'Vendido'),
(2,1,11,45.00,'Reservado'),
(3,1,12,45.00,'Disponible'),
(4,2,5,55.00,'Vendido'),
(5,2,6,55.00,'Reservado'),
(6,3,20,40.00,'Disponible'),
(7,4,15,65.00,'Vendido'),
(8,5,8,70.00,'Reservado'),
(9,6,1,80.00,'Disponible'),
(10,8,30,60.00,'Vendido');
-- (11,1,25,-10,'Vendido'); ERROR(Precio menor a 0)