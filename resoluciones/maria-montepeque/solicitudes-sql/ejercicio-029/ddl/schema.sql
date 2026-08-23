PRAGMA foreign_keys = ON;

-- Ejercicio 029: Tienda Sneakers
-- Modelo: clientes -> pedidos (1:N) -> eventos_pedido (1:N, historico
-- de auditoria).

CREATE TABLE clientes (
    id_cliente     INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre_cliente TEXT NOT NULL UNIQUE,
    email          TEXT NOT NULL UNIQUE
);

-- pedidos: catalogo/cabecera. Los datos permanentes de un pedido
-- (cliente, modelo, talla, precio) no cambian.
CREATE TABLE pedidos (
    id_pedido     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente    INTEGER NOT NULL,
    nombre_modelo TEXT NOT NULL,
    talla         INTEGER NOT NULL CHECK (talla BETWEEN 20 AND 46),
    precio        REAL NOT NULL CHECK (precio > 0),

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

-- eventos_pedido: tabla principal, es el historico de auditoria. Cada
-- fila es un evento real que le ocurrio a un pedido; no se borra, solo
-- se corrige su estado cuando cambia el resultado.
CREATE TABLE eventos_pedido (
    id_evento    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pedido    INTEGER NOT NULL,
    tipo_evento  TEXT NOT NULL CHECK (tipo_evento IN ('creado', 'pagado', 'enviado', 'entregado', 'devuelto')),
    fecha_evento TEXT NOT NULL DEFAULT (datetime('now')),
    estado       TEXT NOT NULL DEFAULT 'valido' CHECK (estado IN ('valido', 'anulado')),
    comentario   TEXT,

    FOREIGN KEY (id_pedido) REFERENCES pedidos (id_pedido)
);
