PRAGMA foreign_keys = ON;

-- Ejercicio 023: Clanes Shooter
INSERT INTO clanes (nombre, tag) VALUES
	('Vanguard Elite', 'VNG'),
	('ShadowOps', 'SHD');

INSERT INTO jugadores (clan_id, gamertag) VALUES
	(1, 'Vng_Leader'),
	(1, 'Vng_Sniper'),
	(2, 'Shd_Ghost');

INSERT INTO guerras (clan_1_id, clan_2_id, mapa, ganador_id) VALUES
	(1, 2, 'Dust_II', 1);