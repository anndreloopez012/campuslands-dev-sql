PRAGMA foreign_keys = ON;

-- Ejercicio 075: Track Day Hiperdeportivos
INSERT INTO pilotos (nombre, categoria) VALUES
	('Ayrton Senna', 'Pro'),
	('Lewis Hamilton', 'Pro'),
	('Max Verstappen', 'Pro');

INSERT INTO vehiculos (piloto_id, auto, potencia_hp) VALUES
	(1, 'McLaren P1', 903),
	(2, 'Mercedes AMG One', 1049),
	(3, 'Bugatti Chiron', 1500);

INSERT INTO sesiones (vehiculo_id, tiempo_vuelta_seg, circuito) VALUES
	(1, 88.5, 'Nurburgring'),
	(2, 86.2, 'Nurburgring'),
	(3, 89.1, 'Spa-Francorchamps');