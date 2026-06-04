PRAGMA foreign_keys = ON;

-- Cree aqui las tablas del modelo CineMax.
-- Recuerde usar maximo 4 tablas e incluir:
-- PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE y CHECK.

create table Boletos(
    ID_Boleto INTEGER PRIMARY KEY AUTOINCREMENT,
    Numero_Asiento TEXT NOT NULL,
    ID_Funcion INTEGER NOT NULL,
    Precio REAL NOT NULL CHECK(Precio > 0)
);

create table Funciones(
    ID_Funcion INTEGER PRIMARY KEY AUTOINCREMENT,
    FechaFuncion date NOT NULL,
    Hora TEXT NOT NULL,
    ID_Pelicula INTEGER NOT NULL
    ID_Sala INTEGER NOT NULL
);

create table Peliculas(
    ID_Pelicula INTEGER PRIMARY KEY AUTOINCREMENT,
    Nombre TEXT NOT NULL,
    Duracion INTEGER NOT NULL CHECK(Duracion > 0)
);

create table Salas(
    ID_Sala INTEGER PRIMARY KEY AUTOINCREMENT,
    NumeroSala INTEGER NOT NULL UNIQUE,
    Capacidad INTEGER NOT NULL CHECK(Capacidad > 0)
);

alter table Boletos
add constraint fk_funcion
foreign key (ID_Funcion) references Funciones(ID_Funcion);

alter table Funciones
add constraint fk_pelicula
foreign key (ID_Pelicula) references Peliculas(ID_Pelicula);    

alter table Funciones
add constraint fk_sala
foreign key (ID_Sala) references Salas(ID_Sala);
