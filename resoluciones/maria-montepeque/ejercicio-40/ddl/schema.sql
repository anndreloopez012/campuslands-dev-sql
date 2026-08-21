PRAGMA foreign_keys = ON;

-- Ejercicio 40: Normalizacion Integrador Avanzado
-- Modelo normalizado (3FN, con discusion de descomposicion 4FN en el
-- analisis): clientes, vendedores, productos, operaciones, detalle_producto,
-- movimientos

CREATE TABLE clientes (
    id_cliente  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT NOT NULL UNIQUE
);

CREATE TABLE vendedores (
    id_vendedor  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL UNIQUE
);

CREATE TABLE productos (
    id_producto  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre       TEXT NOT NULL UNIQUE
);

-- Encabezado de la operacion: un cliente atendido por un vendedor.
CREATE TABLE operaciones (
    id_operacion  INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente    INTEGER NOT NULL,
    id_vendedor   INTEGER NOT NULL,

    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores (id_vendedor)
);

-- Primer hecho multivaluado, INDEPENDIENTE del segundo: los productos
-- comprados en la operacion (su cantidad no coincide con la cantidad de
-- pagos/entregas de la misma operacion en los datos originales).
CREATE TABLE detalle_producto (
    id_detalle    INTEGER PRIMARY KEY AUTOINCREMENT,
    id_operacion  INTEGER NOT NULL,
    id_producto   INTEGER NOT NULL,

    FOREIGN KEY (id_operacion) REFERENCES operaciones (id_operacion),
    FOREIGN KEY (id_producto) REFERENCES productos (id_producto),
    UNIQUE (id_operacion, id_producto)
);

-- Segundo hecho multivaluado: cada "movimiento" agrupa un pago parcial con
-- su entrega y estado asociados. En el CSV original, pagos/cuotas/entregas/
-- estados siempre aparecen en la misma cantidad y orden dentro de una fila,
-- lo que evidencia que son un unico evento compuesto (ver justificacion en
-- analisis/normalizacion.md sobre por que no se separo pago de entrega).
CREATE TABLE movimientos (
    id_movimiento   INTEGER PRIMARY KEY AUTOINCREMENT,
    id_operacion    INTEGER NOT NULL,
    metodo_pago     TEXT NOT NULL CHECK (metodo_pago IN ('Tarjeta', 'Efectivo', 'Transferencia', 'Credito')),
    cuotas          INTEGER NOT NULL CHECK (cuotas >= 0),
    zona_entrega    TEXT NOT NULL,
    estado          TEXT NOT NULL CHECK (estado IN ('Pagado', 'Pendiente', 'Entregado', 'Cancelado')),

    FOREIGN KEY (id_operacion) REFERENCES operaciones (id_operacion)
);
