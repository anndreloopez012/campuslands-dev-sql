PRAGMA foreign_keys = ON;

-- Ejercicio 44: PRIMARY KEY Nivel Basico
-- Tema central: PRIMARY KEY
-- Contexto: registro de campers inscritos en rutas de entrenamiento.

-- rutas: PRIMARY KEY simple autoincremental (llave subrogada / surrogate key).
CREATE TABLE rutas (
    id_ruta   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre    TEXT NOT NULL UNIQUE
);

-- campers: tabla principal del ejercicio.
-- `id_camper` es la PRIMARY KEY (llave subrogada, autoincremental).
-- `documento` es un candidato natural a llave primaria (es unico en la vida
-- real), pero se dejo como UNIQUE en vez de PRIMARY KEY: un documento puede
-- escribirse mal y corregirse despues, y no queremos que corregir un dato
-- de negocio obligue a cambiar la llave que usan todas las tablas
-- relacionadas. Por eso se prefiere una llave subrogada estable.
CREATE TABLE campers (
    id_camper   INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL,
    documento   TEXT NOT NULL UNIQUE
);

-- inscripciones: PRIMARY KEY COMPUESTA (id_camper, id_ruta).
-- Aqui la PRIMARY KEY no es un solo identificador autoincremental: es la
-- combinacion de las dos columnas. Esto es lo que evita el duplicado real
-- del negocio (que el mismo camper quede inscrito dos veces en la misma
-- ruta), sin necesitar una restriccion UNIQUE aparte.
CREATE TABLE inscripciones (
    id_camper           INTEGER NOT NULL,
    id_ruta             INTEGER NOT NULL,
    fecha_inscripcion   TEXT NOT NULL,

    PRIMARY KEY (id_camper, id_ruta),
    FOREIGN KEY (id_camper) REFERENCES campers (id_camper),
    FOREIGN KEY (id_ruta) REFERENCES rutas (id_ruta)
);
