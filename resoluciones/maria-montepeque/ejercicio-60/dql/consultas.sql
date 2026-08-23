.headers on
.mode column

-- Ejercicio 60: DEFAULT Nivel Intermedio
-- Consultas de validacion.

-- 1. Mostrar todos los datos principales.
SELECT * FROM inscripciones;

-- 2. Consulta con WHERE.
SELECT id_inscripcion, id_camper, id_ruta, fecha_inscripcion
FROM inscripciones
WHERE estado = 'activa';

-- 3. Consulta con ORDER BY.
SELECT id_inscripcion, fecha_inscripcion, estado
FROM inscripciones
ORDER BY fecha_inscripcion;

-- 4. Conteo o resumen: inscripciones por estado.
SELECT estado, COUNT(*) AS total
FROM inscripciones
GROUP BY estado
ORDER BY estado;

-- 5. Validacion especifica del tema DEFAULT:
--    a) los campers insertados SIN indicar nivel ni activo (Ana Gomez,
--       Luis Marroquin, Rosa Chavez) igual quedaron con esos campos
--       completos gracias a DEFAULT.
SELECT nombre, nivel, activo
FROM campers
WHERE email IN ('ana.gomez@campus.com', 'luis.marroquin@campus.com', 'rosa.chavez@campus.com');

--    b) las rutas insertadas SIN indicar cupo_maximo quedaron con el
--       cupo estandar de 10.
SELECT nombre_ruta, cupo_maximo
FROM rutas
WHERE nombre_ruta IN ('Sendero del Canon', 'Ruta del Volcan');
