-- database: :memory:
CREATE TABLE IF NOT EXISTS peliculas (
    id_pelicula INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_pelicula TEXT NOT NULL
);

CREATE TABLE  salas (
    id_sala INTEGER PRIMARY KEY,
    numero_sala INT NOT NULL
);

CREATE TABLE boletos_vendidos(
    id_boleto INTEGER PRIMARY KEY UNIQUE,
    numero_boleto INT NOT NULL UNIQUE CHECK(numero_boleto > 0),
    id_funciones INTEGER NOT NULL

);

CREATE TABLE funciones (
    id_funciones INTEGER PRIMARY KEY,
    id_pelicula INTEGER NOT NULL,
    id_sala INTEGER NOT NULL,
    hora_funcion TEXT NOT NULL,
    fecha_funcion TEXT,
    
    FOREIGN KEY (id_pelicula) REFERENCES peliculas(id_pelicula),
    FOREIGN KEY (id_sala) REFERENCES salas(id_sala),
    FOREIGN KEY (id_funciones) REFERENCES boletos_vendidos(id_funciones)
);
