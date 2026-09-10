PRAGMA foreign_keys = ON;

-- Ejercicio 104: Triggers Nivel Basico
-- Tema central: Triggers
-- Contexto: catalogo de libros tecnicos de una biblioteca.

CREATE TABLE libros (
    id_libro      INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo        TEXT NOT NULL UNIQUE,
    stock_total   INTEGER NOT NULL CHECK (stock_total >= 0)
);

-- Tabla de auditoria: aqui queda el historial de cada cambio de stock,
-- sin que nadie tenga que escribir el registro a mano.
CREATE TABLE auditoria_libros (
    id_auditoria     INTEGER PRIMARY KEY AUTOINCREMENT,
    id_libro         INTEGER NOT NULL,
    stock_anterior   INTEGER NOT NULL,
    stock_nuevo      INTEGER NOT NULL,
    fecha_evento     TEXT NOT NULL DEFAULT (datetime('now')),

    FOREIGN KEY (id_libro) REFERENCES libros (id_libro)
);

-- Trigger: automatiza el registro de auditoria (tema central del
-- ejercicio). Cada vez que cambia stock_total en "libros", se dispara
-- DESPUES del UPDATE y guarda una fila en "auditoria_libros" con el
-- valor anterior (OLD) y el nuevo (NEW), sin que la aplicacion que
-- actualiza el stock tenga que acordarse de registrar el cambio.
CREATE TRIGGER trg_auditar_cambio_stock
AFTER UPDATE OF stock_total ON libros
FOR EACH ROW
WHEN OLD.stock_total <> NEW.stock_total
BEGIN
    INSERT INTO auditoria_libros (id_libro, stock_anterior, stock_nuevo)
    VALUES (NEW.id_libro, OLD.stock_total, NEW.stock_total);
END;
