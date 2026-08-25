SELECT * FROM contratos;

SELECT id_contrato, salario
FROM contratos;

SELECT id_contrato, fecha_inicio, salario
FROM contratos
WHERE salario >= 6000;

SELECT id_contrato, fecha_inicio
FROM contratos
ORDER BY fecha_inicio DESC;

SELECT id_contrato, salario
FROM contratos
ORDER BY salario DESC
LIMIT 5;

SELECT COUNT(*) AS total_contratos
FROM contratos;

SELECT
AVG(salario) AS promedio,
MIN(salario) AS minimo,
MAX(salario) AS maximo
FROM contratos;

SELECT
tipo,
COUNT(*) AS cantidad
FROM contratos
GROUP BY tipo;

SELECT
e.nombre AS empleado,
d.nombre AS departamento,
c.nombre AS cargo,
ct.tipo,
ct.salario
FROM contratos ct
JOIN empleados e ON ct.id_empleado=e.id_empleado
JOIN departamentos d ON e.id_departamento=d.id_departamento
JOIN cargos c ON e.id_cargo=c.id_cargo;

SELECT
e.nombre,
ct.salario
FROM contratos ct
JOIN empleados e ON ct.id_empleado=e.id_empleado
WHERE ct.tipo='INDEFINIDO'
ORDER BY ct.salario DESC
LIMIT 5;

SELECT
d.nombre AS departamento,
COUNT(e.id_empleado) AS empleados,
ROUND(AVG(ct.salario),2) AS salario_promedio
FROM departamentos d
LEFT JOIN empleados e ON d.id_departamento=e.id_departamento
LEFT JOIN contratos ct ON e.id_empleado=ct.id_empleado
GROUP BY d.id_departamento,d.nombre
ORDER BY salario_promedio DESC;

SELECT
c.nombre AS cargo,
COUNT(e.id_empleado) AS colaboradores,
ROUND(AVG(ct.salario),2) AS salario_promedio,
CASE
WHEN AVG(ct.salario)>=6500 THEN 'Prioridad alta'
WHEN AVG(ct.salario)>=5500 THEN 'Prioridad media'
ELSE 'Revisar escala'
END AS decision
FROM cargos c
LEFT JOIN empleados e ON c.id_cargo=e.id_cargo
LEFT JOIN contratos ct ON e.id_empleado=ct.id_empleado
GROUP BY c.id_cargo,c.nombre
ORDER BY salario_promedio DESC;