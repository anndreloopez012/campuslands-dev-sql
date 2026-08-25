CREATE DATABASE IF NOT EXISTS cine;
USE cine;

CREATE TABLE IF NOT EXISTS peliculas (
    id_pelicula INT PRIMARY KEY AUTO_INCREMENT,
    nombre_pelicula VARCHAR(100) NOT NULL,
    duracion INT NOT NULL COMMENT 'Duración en minutos',
    clasificacion VARCHAR(10),
    genero VARCHAR(50),
    fecha_estreno DATE,
    estado ENUM('ACTIVA', 'INACTIVA') DEFAULT 'ACTIVA'
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS salas (
    id_sala INT PRIMARY KEY AUTO_INCREMENT,
    nombre_sala VARCHAR(50) NOT NULL,
    capacidad INT NOT NULL,
    tipo_sala ENUM('2D', '3D', 'IMAX') DEFAULT '2D',
    estado ENUM('ACTIVA', 'MANTENIMIENTO', 'INACTIVA') DEFAULT 'ACTIVA'
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS funciones (
    id_funcion INT PRIMARY KEY AUTO_INCREMENT,
    id_pelicula INT NOT NULL,
    id_sala INT NOT NULL,
    fecha_funcion DATE NOT NULL,
    hora_funcion TIME NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    idioma VARCHAR(30) DEFAULT 'Español',
    formato ENUM('2D', '3D', 'IMAX') DEFAULT '2D',
    estado ENUM('PROGRAMADA', 'CANCELADA', 'FINALIZADA')
        DEFAULT 'PROGRAMADA',

    CONSTRAINT fk_funciones_peliculas
        FOREIGN KEY (id_pelicula)
        REFERENCES peliculas(id_pelicula)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_funciones_salas
        FOREIGN KEY (id_sala)
        REFERENCES salas(id_sala)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT uq_funcion_sala_fecha_hora
        UNIQUE (id_sala, fecha_funcion, hora_funcion)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS boletos (
    id_boleto INT PRIMARY KEY AUTO_INCREMENT,
    id_funcion INT NOT NULL,
    numero_asiento VARCHAR(10) NOT NULL,
    fecha_compra DATETIME DEFAULT CURRENT_TIMESTAMP,
    precio_pagado DECIMAL(10, 2) NOT NULL,
    comprador VARCHAR(100),
    estado ENUM('RESERVADO', 'PAGADO', 'CANCELADO')
        DEFAULT 'PAGADO',

    CONSTRAINT fk_boletos_funciones
        FOREIGN KEY (id_funcion)
        REFERENCES funciones(id_funcion)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT uq_boleto_asiento
        UNIQUE (id_funcion, numero_asiento)
) ENGINE = InnoDB;
