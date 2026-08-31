PRAGMA foreign_keys = ON;

-- Ejercicio 059: Estudio Animacion 3D
INSERT INTO clientes (empresa, contacto) VALUES
	('Pixie Studios', 'Diana Ramos'),
	('VFX Motion', 'Oscar Cruz');

INSERT INTO proyectos (cliente_id, nombre, presupuesto) VALUES
	(1, 'Comercial Bebida 3D', 5000.00),
	(2, 'Cortometraje SciFi', 12000.00);

INSERT INTO renders (proyecto_id, escena, tiempo_horas, estado) VALUES
	(1, 'Escena 01 - Intro', 4.5, 'finalizado'),
	(2, 'Escena 05 - Batalla', 12.0, 'en_proceso');