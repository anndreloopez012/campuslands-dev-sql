PRAGMA foreign_keys = ON;

-- Ejercicio 050: Track Day Hiperdeportivos
DROP TABLE IF EXISTS sesiones;
DROP TABLE IF EXISTS vehiculos;
DROP TABLE IF EXISTS pilotos;

CREATE TABLE pilotos (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	nombre TEXT NOT NULL,
	categoria TEXT NOT NULL CHECK (categoria IN ('Amateur', 'Pro'))
);

CREATE TABLE vehiculos (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	piloto_id INTEGER NOT NULL,
	auto TEXT NOT NULL,
	potencia_hp INTEGER NOT NULL CHECK (potencia_hp > 0),
	FOREIGN KEY (piloto_id) REFERENCES pilotos(id)
);

CREATE TABLE sesiones (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	vehiculo_id INTEGER NOT NULL,
	tiempo_vuelta_seg REAL NOT NULL CHECK (tiempo_vuelta_seg > 0),
	circuito TEXT NOT NULL,
	FOREIGN KEY (vehiculo_id) REFERENCES vehiculos(id)
);