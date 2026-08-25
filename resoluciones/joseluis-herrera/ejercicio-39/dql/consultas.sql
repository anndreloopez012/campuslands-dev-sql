SELECT
    e.nombre_completo AS empleado,
    c.nombre_cargo AS cargo,
    d.nombre_departamento AS departamento,
    j.nombre_completo AS jefe,
    GROUP_CONCAT(b.nombre_beneficio, ', ') AS beneficios,
    ct.salario,
    ct.fecha_contrato
FROM empleados e
JOIN cargos c
    ON e.id_cargo = c.id_cargo
JOIN departamentos d
    ON e.id_departamento = d.id_departamento
LEFT JOIN empleados j
    ON e.id_jefe = j.id_empleado
LEFT JOIN contratos ct
    ON e.id_empleado = ct.id_empleado
    AND ct.estado = 'Activo'
LEFT JOIN asignaciones_beneficios ab
    ON e.id_empleado = ab.id_empleado
LEFT JOIN beneficios b
    ON ab.id_beneficio = b.id_beneficio
    AND ab.estado = 'Activo'
GROUP BY
    e.id_empleado,
    e.nombre_completo,
    c.nombre_cargo,
    d.nombre_departamento,
    j.nombre_completo,
    ct.salario,
    ct.fecha_contrato
ORDER BY e.nombre_completo;

SELECT DISTINCT
    nombre_completo
FROM empleados
ORDER BY nombre_completo;

SELECT DISTINCT
    d.nombre_departamento AS departamento
FROM departamentos d
JOIN empleados e
    ON d.id_departamento = e.id_departamento
ORDER BY d.nombre_departamento;

SELECT
    d.nombre_departamento AS departamento,
    COUNT(e.id_empleado) AS cantidad_empleados
FROM departamentos d
LEFT JOIN empleados e
    ON d.id_departamento = e.id_departamento
GROUP BY d.id_departamento, d.nombre_departamento
ORDER BY cantidad_empleados DESC;

SELECT
    c.nombre_cargo AS cargo,
    COUNT(e.id_empleado) AS cantidad_empleados
FROM cargos c
LEFT JOIN empleados e
    ON c.id_cargo = e.id_cargo
GROUP BY c.id_cargo, c.nombre_cargo
ORDER BY cantidad_empleados DESC;

SELECT
    ct.id_contrato,
    ct.id_empleado,
    ct.salario,
    ct.salario + COALESCE(SUM(b.valor_mensual), 0) AS costo_total_mensual
FROM contratos ct
LEFT JOIN asignaciones_beneficios ab
    ON ct.id_empleado = ab.id_empleado
    AND ab.estado = 'Activo'
LEFT JOIN beneficios b
    ON ab.id_beneficio = b.id_beneficio
GROUP BY
    ct.id_contrato,
    ct.id_empleado,
    ct.salario
ORDER BY costo_total_mensual DESC;

SELECT
    AVG(salario) AS salario_promedio,
    MIN(salario) AS salario_minimo,
    MAX(salario) AS salario_maximo
FROM contratos
WHERE estado = 'Activo';

SELECT
    e.nombre_completo AS empleado,
    c.nombre_cargo AS cargo
FROM empleados e
JOIN cargos c
    ON e.id_cargo = c.id_cargo
WHERE e.nombre_completo LIKE '%a%'
ORDER BY e.nombre_completo;

SELECT
    e.nombre_completo AS empleado,
    ct.fecha_contrato,
    ct.salario
FROM empleados e
JOIN contratos ct
    ON e.id_empleado = ct.id_empleado
WHERE ct.fecha_contrato BETWEEN '2024-01-01' AND '2024-12-31'
ORDER BY ct.fecha_contrato;

SELECT
    e.nombre_completo AS empleado,
    ct.salario
FROM empleados e
JOIN contratos ct
    ON e.id_empleado = ct.id_empleado
WHERE ct.salario BETWEEN 5000 AND 8000
ORDER BY ct.salario DESC;

SELECT
    e.nombre_completo AS empleado,
    ct.salario
FROM empleados e
JOIN contratos ct
    ON e.id_empleado = ct.id_empleado
WHERE ct.estado = 'Activo'
ORDER BY ct.salario DESC
LIMIT 5;

SELECT
    b.nombre_beneficio AS beneficio,
    COUNT(ab.id_empleado) AS empleados_asignados
FROM beneficios b
LEFT JOIN asignaciones_beneficios ab
    ON b.id_beneficio = ab.id_beneficio
    AND ab.estado = 'Activo'
GROUP BY b.id_beneficio, b.nombre_beneficio
ORDER BY empleados_asignados DESC;

SELECT
    e.nombre_completo AS empleado,
    d.nombre_departamento AS departamento,
    c.nombre_cargo AS cargo,
    j.nombre_completo AS jefe
FROM empleados e
JOIN departamentos d
    ON e.id_departamento = d.id_departamento
JOIN cargos c
    ON e.id_cargo = c.id_cargo
LEFT JOIN empleados j
    ON e.id_jefe = j.id_empleado
WHERE NOT EXISTS (
    SELECT 1
    FROM asignaciones_beneficios ab
    WHERE ab.id_empleado = e.id_empleado
)
ORDER BY e.nombre_completo;

SELECT
    e.nombre_completo AS empleado,
    d.nombre_departamento AS departamento,
    c.nombre_cargo AS cargo,
    COALESCE(j.nombre_completo, 'Sin jefe') AS jefe,
    ct.salario AS salario,
    ct.fecha_contrato AS fecha_contrato,
    COUNT(ab.id_beneficio) AS cantidad_beneficios,
    COALESCE(SUM(b.valor_mensual), 0) AS valor_beneficios
FROM empleados e
JOIN departamentos d
    ON e.id_departamento = d.id_departamento
JOIN cargos c
    ON e.id_cargo = c.id_cargo
LEFT JOIN empleados j
    ON e.id_jefe = j.id_empleado
LEFT JOIN contratos ct
    ON e.id_empleado = ct.id_empleado
    AND ct.estado = 'Activo'
LEFT JOIN asignaciones_beneficios ab
    ON e.id_empleado = ab.id_empleado
    AND ab.estado = 'Activo'
LEFT JOIN beneficios b
    ON ab.id_beneficio = b.id_beneficio
GROUP BY
    e.id_empleado,
    e.nombre_completo,
    d.nombre_departamento,
    c.nombre_cargo,
    j.nombre_completo,
    ct.salario,
    ct.fecha_contrato
ORDER BY ct.salario DESC;