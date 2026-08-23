PRAGMA foreign_keys = ON;

-- 1. REGISTROS PRINCIPALES DE LA ENTIDAD CENTRAL

SELECT
    id_empleado,
    id_departamento,
    id_cargo,
    nombre_completo,
    correo,
    fecha_ingreso,
    estado
FROM empleados;

-- 2. DOS COLUMNAS RELEVANTES

SELECT
    nombre_completo,
    correo
FROM empleados;

-- 3. FILTRO POR CONDICION DE FECHA

SELECT
    id_empleado,
    nombre_completo,
    fecha_ingreso
FROM empleados
WHERE fecha_ingreso >= '2023-01-01';

-- 4. ORDEN ALFABETICO

SELECT
    id_empleado,
    nombre_completo,
    fecha_ingreso
FROM empleados
ORDER BY nombre_completo ASC;

-- 5. CINCO REGISTROS CON MAYOR SALARIO

SELECT
    id_contrato,
    id_empleado,
    salario,
    tipo_contrato
FROM contratos
ORDER BY salario DESC
LIMIT 5;

-- 6. TOTAL DE EMPLEADOS

SELECT
    COUNT(*) AS total_empleados
FROM empleados;

-- 7. PROMEDIO, MINIMO Y MAXIMO SALARIAL

SELECT
    ROUND(AVG(salario), 2) AS salario_promedio,
    MIN(salario) AS salario_minimo,
    MAX(salario) AS salario_maximo
FROM contratos;

-- 8. EMPLEADOS POR DEPARTAMENTO

SELECT
    d.nombre AS departamento,
    COUNT(e.id_empleado) AS total_empleados
FROM departamentos d
LEFT JOIN empleados e
    ON e.id_departamento = d.id_departamento
GROUP BY d.id_departamento, d.nombre
ORDER BY total_empleados DESC;

-- 9. RELACION ENTRE EMPLEADOS, DEPARTAMENTOS, CARGOS Y CONTRATOS

SELECT
    e.nombre_completo,
    d.nombre AS departamento,
    c.nombre AS cargo,
    ct.tipo_contrato,
    ct.salario
FROM contratos ct
INNER JOIN empleados e
    ON e.id_empleado = ct.id_empleado
INNER JOIN departamentos d
    ON d.id_departamento = e.id_departamento
INNER JOIN cargos c
    ON c.id_cargo = e.id_cargo;

-- 10. WHERE, ORDER BY Y LIMIT

SELECT
    id_contrato,
    id_empleado,
    salario,
    tipo_contrato
FROM contratos
WHERE salario > 4000
ORDER BY salario DESC
LIMIT 5;

-- 11. REPORTE CON ALIAS LEGIBLES

SELECT
    e.nombre_completo AS empleado,
    d.nombre AS departamento,
    c.nombre AS cargo,
    ct.tipo_contrato AS tipo_de_contrato,
    ct.salario AS salario_mensual,
    ct.fecha_inicio AS inicio_contrato
FROM empleados e
INNER JOIN departamentos d
    ON d.id_departamento = e.id_departamento
INNER JOIN cargos c
    ON c.id_cargo = e.id_cargo
INNER JOIN contratos ct
    ON ct.id_empleado = e.id_empleado
ORDER BY e.nombre_completo;

-- 12. DECISION DEL NEGOCIO: DEPARTAMENTOS CON MAYOR SALARIO PROMEDIO

SELECT
    d.nombre AS departamento,
    ROUND(AVG(ct.salario), 2) AS salario_promedio,
    COUNT(e.id_empleado) AS empleados_contrato
FROM departamentos d
INNER JOIN empleados e
    ON e.id_departamento = d.id_departamento
INNER JOIN contratos ct
    ON ct.id_empleado = e.id_empleado
GROUP BY d.id_departamento, d.nombre
ORDER BY salario_promedio DESC;