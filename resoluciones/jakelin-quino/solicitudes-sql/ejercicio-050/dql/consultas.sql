.headers on
.mode column

-- Ejercicio 050: Track Day Hiperdeportivos
-- 1. Vehiculos inscritos y sus pilotos
SELECT v.auto, v.potencia_hp, p.nombre AS piloto FROM vehiculos v JOIN pilotos p ON p.id = v.piloto_id;

-- 2. Tiempos de vuelta por circuito
SELECT s.id, v.auto, s.circuito, s.tiempo_vuelta_seg FROM sesiones s JOIN vehiculos v ON v.id = s.vehiculo_id ORDER BY s.tiempo_vuelta_seg ASC;

-- 3. Mejor tiempo de vuelta registrado por auto
SELECT v.auto, MIN(s.tiempo_vuelta_seg) AS mejor_tiempo FROM sesiones s JOIN vehiculos v ON v.id = s.vehiculo_id GROUP BY v.id, v.auto;