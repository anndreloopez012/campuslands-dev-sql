PRAGMA foreign_keys = ON;

-- Cree aqui las tablas del modelo CineMax.
-- Recuerde usar maximo 4 tablas e incluir:
-- PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE y CHECK.

CREATE TABLE pelicula (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL UNIQUE,
    genero TEXT,
    duracion INTEGER NOT  NULL CHECK(duracion > 0),
    clasificacion TEXT
);

CREATE TABLE sala (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_sala TEXT NOT NULL UNIQUE,
    tipo_sala TEXT,
    capacidad INTEGER CHECK (capacidad>0)
);

CREATE TABLE funcion (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pelicula INTEGER NOT NULL,
    id_sala INTEGER NOT NULL,
    fecha_hora TEXT NOT NULL,
    estado TEXT,
    FOREIGN KEY (id_pelicula) REFERENCES pelicula(id),
    FOREIGN KEY (id_sala) REFERENCES sala(id)
);

CREATE TABLE boleto (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_funcion INTEGER NOT NULL,
    numero_asiento TEXT,
    precio DECIMAL NOT NULL CHECK(precio >= 0),
    estado TEXT, 
    FOREIGN KEY (id_funcion) REFERENCES funcion(id)
);