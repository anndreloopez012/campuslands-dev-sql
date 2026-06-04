PRAGMA foreign_keys = ON;

-- Inserte aqui los datos de prueba.
-- Requisitos minimos:
-- 5 peliculas, 5 salas, 8 funciones y 10 boletos.

-- Casos de error sugeridos:
-- Mantenga comentadas las inserciones que deben fallar para que el script principal ejecute correctamente.

insert into Peliculas (Nombre, Duracion) values ('El Viaje de Chihiro', 125);
insert into Peliculas (Nombre, Duracion) values ('El Señor de los Anillos: La Comunidad del Anillo', 178);
insert into Peliculas (Nombre, Duracion) values ('Matrix', 136);
insert into Peliculas (Nombre, Duracion) values ('Inception', 148);
insert into Peliculas (Nombre, Duracion) values ('Coco', 105);

-- Inserción de 5 salas
insert into Salas (Nombre, Capacidad) values ('Sala 1', 100);
insert into Salas (Nombre, Capacidad) values ('Sala 2', 150);
insert into Salas (Nombre, Capacidad) values ('Sala 3', 120);
insert into Salas (Nombre, Capacidad) values ('Sala 4', 80);
insert into Salas (Nombre, Capacidad) values ('Sala 5', 200);

-- Inserción de 8 funciones
-- Inserción de 8 funciones con fecha y hora separadas
insert into Funciones (PeliculaID, SalaID, Fecha, Hora) values (1, 1, '2026-06-05', '14:00:00');
insert into Funciones (PeliculaID, SalaID, Fecha, Hora) values (2, 2, '2026-06-05', '16:00:00');
insert into Funciones (PeliculaID, SalaID, Fecha, Hora) values (3, 3, '2026-06-05', '18:00:00');
insert into Funciones (PeliculaID, SalaID, Fecha, Hora) values (4, 4, '2026-06-05', '20:00:00');
insert into Funciones (PeliculaID, SalaID, Fecha, Hora) values (5, 5, '2026-06-05', '22:00:00');
insert into Funciones (PeliculaID, SalaID, Fecha, Hora) values (1, 2, '2026-06-06', '14:00:00');
insert into Funciones (PeliculaID, SalaID, Fecha, Hora) values (2, 3, '2026-06-06', '16:00:00');
insert into Funciones (PeliculaID, SalaID, Fecha, Hora) values (3, 4, '2026-06-06', '18:00:00');

-- Inserción de 10 boletos
insert into Boletos (FuncionID, Asiento, Precio) values (1, 'A1', 50.00);
insert into Boletos (FuncionID, Asiento, Precio) values (1, 'A2', 50.00);
insert into Boletos (FuncionID, Asiento, Precio) values (2, 'B1', 60.00);
insert into Boletos (FuncionID, Asiento, Precio) values (2, 'B2', 60.00);
insert into Boletos (FuncionID, Asiento, Precio) values (3, 'C1', 55.00);
insert into Boletos (FuncionID, Asiento, Precio) values (3, 'C2', 55.00);
insert into Boletos (FuncionID, Asiento, Precio) values (4, 'D1', 70.00);
insert into Boletos (FuncionID, Asiento, Precio) values (4, 'D2', 70.00);
insert into Boletos (FuncionID, Asiento, Precio) values (5, 'E1', 65.00);
insert into Boletos (FuncionID, Asiento, Precio) values (5, 'E2', 65.00);


insert into Funciones (PeliculaID, SalaID, Fecha, Hora) values (999, 999, '2026-06-07', '12:00:00'); 
insert into Salas (Nombre, Capacidad) values ('Sala 7', -50); 
