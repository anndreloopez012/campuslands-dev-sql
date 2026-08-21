-- Ejercicio 24: Recursos Humanos
-- Entidad central: contratos

-- 1. Listar todos los registros principales de la entidad central
SELECT * FROM contratos;

-- 2. Mostrar solo dos columnas relevantes
SELECT tipo, salario FROM contratos;

-- 3. Filtrar registros por una condicion numerica
SELECT * FROM contratos WHERE salario > 5000;

-- 4. Ordenar resultados por fecha de inicio
SELECT * FROM contratos ORDER BY fecha_inicio;

-- 5. Mostrar los 5 contratos con mayor salario
SELECT * FROM contratos ORDER BY salario DESC LIMIT 5;

-- 6. Contar registros totales
SELECT COUNT(*) AS total_contratos FROM contratos;

-- 7. Promedio, minimo y maximo del salario contratado
SELECT
    AVG(salario) AS promedio,
    MIN(salario) AS minimo,
    MAX(salario) AS maximo
FROM contratos;

-- 8. Agrupar contratos por tipo
SELECT tipo, COUNT(*) AS cantidad_contratos
FROM contratos
GROUP BY tipo;

-- 9. Relacionar contratos, empleados y departamentos con JOIN
SELECT c.id_contrato, e.nombre AS empleado, d.nombre AS departamento
FROM contratos c
JOIN empleados e ON e.id_empleado = c.id_empleado
JOIN departamentos d ON d.id_departamento = e.id_departamento;

-- 10. WHERE + ORDER BY + LIMIT
SELECT * FROM contratos
WHERE estado = 'activo'
ORDER BY salario DESC
LIMIT 3;

-- 11. Reporte con alias legibles
SELECT
    e.nombre AS empleado,
    d.nombre AS departamento,
    ca.nombre AS cargo,
    c.tipo AS tipo_contrato,
    c.salario AS salario_contrato,
    c.estado AS estado_contrato
FROM contratos c
JOIN empleados e ON e.id_empleado = c.id_empleado
JOIN departamentos d ON d.id_departamento = e.id_departamento
JOIN cargos ca ON ca.id_cargo = e.id_cargo;

-- 12. Consulta para decision de negocio: departamento con mayor gasto en salarios de contratos activos
SELECT d.nombre, SUM(c.salario) AS gasto_total
FROM contratos c
JOIN empleados e ON e.id_empleado = c.id_empleado
JOIN departamentos d ON d.id_departamento = e.id_departamento
WHERE c.estado = 'activo'
GROUP BY d.nombre
ORDER BY gasto_total DESC
LIMIT 1;
