PRAGMA foreign_keys = ON;

-- Ejercicio 02: Campus Shop
-- Cree aqui las tablas necesarias para el modelo.
-- Debe incluir PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE y CHECK.

-- Ejemplo de estructura esperada:
-- CREATE TABLE nombre_tabla (
--   id INTEGER PRIMARY KEY AUTOINCREMENT,
--   nombre TEXT NOT NULL UNIQUE,
--   estado TEXT NOT NULL CHECK (estado IN ('activo', 'inactivo'))
-- );
DROP DATABASE IF EXISTS campus_shop_02;
CREATE DATABASE IF NOT EXISTS campus_shop_02;

-- =====lIMPIEZA DE TABLAS EXISTENTES =====
DROP TABLE IF EXISTS  categoria;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS ventas;


-- ======== CREACION DE TABLAS EXISTES =======
CREATE TABLE categoria(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_categoria VARCHAR(80) NOT NULL
);

CREATE TABLE productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_producto INT NOT NULL,
    categoria INT NOT NULL,
    stock_actual INT NOT NULL CHECK(stock_actual > 0) DEFAULT 0,
    stock_minimo INT NOT NULL DEFAULT 0,
    precio DECIMAL(10,2),

    CONSTRAINT fk_categira_producto
        Foreign Key (categoria) REFERENCES categoria(id)
);

CREATE TABLE clientes(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(15) NOT NULL
);

CREATE TABLE ventas(
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT CHECK(cantidad > 0) DEFAULT 0,
    total DECIMAL(10,2) DEFAULT 0 CHECK(total > 0),

    CONSTRAINT FK_id_cliente
        Foreign Key (id_cliente) REFERENCES clientes(id),
    
    CONSTRAINT FK_id_producto
        Foreign Key (id_producto) REFERENCES productos(id)
);