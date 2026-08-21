-- Ejercicio 39: Normalizacion Recursos Humanos

-- 1. Reconstruir una vista similar al archivo original usando JOIN
-- (beneficios de cada contrato concatenados con '|', como en el CSV original)
SELECT
    c.id_contrato,
    e.nombre AS empleado,
    ca.nombre AS cargo,
    d.nombre AS departamento,
    j.nombre AS jefe,
    (SELECT GROUP_CONCAT(b.nombre, '|')
        FROM asignaciones a JOIN beneficios b ON b.id_beneficio = a.id_beneficio
        WHERE a.id_contrato = c.id_contrato) AS beneficios,
    c.salario AS salario,
    c.fecha_contrato AS fecha_contrato
FROM contratos c
JOIN empleados e ON e.id_empleado = c.id_empleado
JOIN cargos ca ON ca.id_cargo = c.id_cargo
JOIN departamentos d ON d.id_departamento = c.id_departamento
LEFT JOIN empleados j ON j.id_empleado = c.id_jefe
ORDER BY c.id_contrato;

-- 2. Listar entidades principales sin duplicados
SELECT DISTINCT nombre FROM empleados;
SELECT DISTINCT nombre FROM cargos;
SELECT DISTINCT nombre FROM departamentos;
SELECT DISTINCT nombre FROM beneficios;

-- 3. Contar registros por categoria o estado (contratos por departamento)
SELECT d.nombre AS departamento, COUNT(*) AS cantidad_contratos
FROM contratos c
JOIN departamentos d ON d.id_departamento = c.id_departamento
GROUP BY d.nombre;

-- 4. Calcular un total por transaccion (cantidad de beneficios por contrato)
SELECT c.id_contrato, COUNT(*) AS cantidad_beneficios
FROM asignaciones a
JOIN contratos c ON c.id_contrato = a.id_contrato
GROUP BY c.id_contrato;

-- 5. Calcular promedio, minimo y maximo del salario
SELECT
    AVG(salario) AS promedio,
    MIN(salario) AS minimo,
    MAX(salario) AS maximo
FROM contratos;

-- 6. Buscar registros por texto con LIKE
SELECT * FROM empleados WHERE nombre LIKE 'Marco%';
SELECT * FROM cargos WHERE nombre LIKE '%Developer%';

-- 7. Filtrar por fecha o rango numerico
SELECT * FROM contratos WHERE fecha_contrato >= '2026-02-01';
SELECT * FROM contratos WHERE salario > 7000;

-- 8. Mostrar top 5 por cantidad o monto (empleados con mayor salario)
SELECT e.nombre AS empleado, c.salario AS salario
FROM contratos c
JOIN empleados e ON e.id_empleado = c.id_empleado
ORDER BY c.salario DESC
LIMIT 5;

-- 9. Detectar registros relacionados sin detalle (contratos sin beneficios asignados)
SELECT c.id_contrato, e.nombre AS empleado
FROM contratos c
JOIN empleados e ON e.id_empleado = c.id_empleado
LEFT JOIN asignaciones a ON a.id_contrato = c.id_contrato
WHERE a.id_asignacion IS NULL;

-- 10. Reporte final con alias legibles
SELECT
    e.nombre AS empleado,
    ca.nombre AS cargo,
    d.nombre AS departamento,
    COALESCE(j.nombre, 'Sin jefe') AS jefe,
    c.salario AS salario,
    c.fecha_contrato AS fecha_contrato,
    (SELECT GROUP_CONCAT(b.nombre, ', ')
        FROM asignaciones a JOIN beneficios b ON b.id_beneficio = a.id_beneficio
        WHERE a.id_contrato = c.id_contrato) AS beneficios
FROM contratos c
JOIN empleados e ON e.id_empleado = c.id_empleado
JOIN cargos ca ON ca.id_cargo = c.id_cargo
JOIN departamentos d ON d.id_departamento = c.id_departamento
LEFT JOIN empleados j ON j.id_empleado = c.id_jefe
ORDER BY c.id_contrato;
