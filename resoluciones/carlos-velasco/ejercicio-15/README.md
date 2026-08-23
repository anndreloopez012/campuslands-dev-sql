# Ejercicio 15: Taller de Motos

## Información

| Campo | Valor |
| --- | --- |
| Nombre | Carlos Velasco |
| Ejercicio | 15 |
| Tecnología | SQLite |
| Tema | Taller mecánico de motos |
| Fecha | 2026-08-20 |

## Descripción

El ejercicio implementa una base de datos relacional para administrar clientes, motos, servicios y órdenes de servicio de un taller mecánico.

El modelo permite registrar las motocicletas de cada cliente, definir el catálogo de servicios disponibles y almacenar las órdenes realizadas sobre cada moto.

El objetivo es reemplazar registros manuales dispersos por una estructura consistente que permita controlar servicios, fechas, kilometraje, estados y valores cobrados.

## Modelo implementado

La solución utiliza cuatro tablas:

| Tabla | Responsabilidad |
| --- | --- |
| `clientes` | Almacenar la información de los propietarios de las motos. |
| `motos` | Registrar las motocicletas y asociarlas con sus clientes. |
| `servicios` | Mantener el catálogo de servicios ofrecidos por el taller. |
| `ordenes_servicio` | Registrar los servicios realizados o programados para cada moto. |

## Relaciones

```text
clientes 1 ─────── N motos
motos 1 ─────── N ordenes_servicio
servicios 1 ─────── N ordenes_servicio
```

Una orden de servicio pertenece a una moto y utiliza un servicio del catálogo.

## Restricciones aplicadas

- Todas las tablas tienen `PRIMARY KEY`.
- Las relaciones se implementan mediante `FOREIGN KEY`.
- Los campos obligatorios utilizan `NOT NULL`.
- `clientes.correo` utiliza `UNIQUE`.
- `motos.placa` utiliza `UNIQUE`.
- `servicios.nombre` utiliza `UNIQUE`.
- El año de fabricación de una moto utiliza `CHECK`.
- El kilometraje utiliza `CHECK` para impedir valores negativos.
- El precio base de los servicios debe ser mayor que cero.
- La duración de un servicio debe ser mayor que cero.
- El precio final de una orden no puede ser negativo.
- El estado de una orden se limita mediante `CHECK`.
- Las fechas se almacenan en formato ISO.
- `PRAGMA foreign_keys = ON` activa la integridad referencial en SQLite.

## Datos

El archivo `dml/inserts.sql` contiene:

- 5 clientes.
- 10 motos.
- 10 servicios.
- 10 órdenes de servicio.

La distribución permite realizar consultas sobre clientes, motos, servicios y órdenes desde el inicio.

## Operaciones

El archivo `dml/operaciones.sql` contiene:

- 2 operaciones `INSERT` adicionales.
- 2 operaciones `UPDATE` válidas.
- 2 operaciones `DELETE` controladas mediante `WHERE`.
- 2 operaciones inválidas comentadas.

Las operaciones inválidas representan:

1. Un `CHECK` incumplido mediante un kilometraje negativo.
2. Un `UNIQUE` incumplido mediante un correo electrónico duplicado.

Las operaciones inválidas permanecen comentadas para evitar que interrumpan la ejecución normal del script.

## Consultas

El archivo `dql/consultas.sql` contiene 12 consultas que cubren:

- Listado completo de órdenes.
- Selección de columnas específicas.
- Filtrado por kilometraje.
- Ordenamiento por fecha.
- Top 5 de órdenes según precio.
- Conteo de órdenes.
- Promedio, mínimo y máximo de precios.
- Agrupación por estado.
- Relaciones mediante `JOIN`.
- Uso combinado de `WHERE`, `ORDER BY` y `LIMIT`.
- Reportes con alias legibles.
- Consulta orientada a decisiones del negocio.

## Ejecución

Desde la raíz de `ejercicio-15`:

```bash
sqlite3 ejercicio-15.db < ddl/schema.sql
sqlite3 ejercicio-15.db < dml/inserts.sql
sqlite3 ejercicio-15.db < dml/operaciones.sql
sqlite3 ejercicio-15.db < dql/consultas.sql
```

El archivo de base de datos utilizado durante la ejecución es local y no debe incluirse en el repositorio.

## Validaciones

Para comprobar que las tablas fueron creadas correctamente:

```bash
sqlite3 ejercicio-15.db ".tables"
```

Resultado esperado:

```text
clientes  motos  ordenes_servicio  servicios
```

Para comprobar la estructura:

```bash
sqlite3 ejercicio-15.db ".schema"
```

Para comprobar las cantidades de datos:

```sql
SELECT 'clientes' AS tabla, COUNT(*) AS registros FROM clientes
UNION ALL
SELECT 'motos', COUNT(*) FROM motos
UNION ALL
SELECT 'servicios', COUNT(*) FROM servicios
UNION ALL
SELECT 'ordenes_servicio', COUNT(*) FROM ordenes_servicio;
```

Después de ejecutar `operaciones.sql`, se espera:

```text
clientes           6
motos              10
servicios          10
ordenes_servicio   9
```

Las cantidades reflejan las operaciones adicionales y eliminaciones realizadas en el script.

## Evidencias relevantes

La consulta de relaciones permite verificar que una orden puede obtener simultáneamente el cliente, la moto y el servicio asociado:

```sql
SELECT
    o.id_orden,
    c.nombre_completo AS cliente,
    m.placa,
    s.nombre AS servicio,
    o.fecha_servicio,
    o.estado,
    o.precio_final
FROM ordenes_servicio AS o
INNER JOIN motos AS m
    ON o.id_moto = m.id_moto
INNER JOIN clientes AS c
    ON m.id_cliente = c.id_cliente
INNER JOIN servicios AS s
    ON o.id_servicio = s.id_servicio;
```

La consulta de agrupación permite identificar la cantidad de órdenes según su estado:

```sql
SELECT
    estado,
    COUNT(*) AS cantidad_ordenes
FROM ordenes_servicio
GROUP BY estado;
```

La consulta de negocio permite identificar los servicios con mayor frecuencia y sus ingresos generados:

```sql
SELECT
    s.nombre AS servicio,
    COUNT(o.id_orden) AS cantidad_realizada,
    ROUND(SUM(o.precio_final), 2) AS ingresos_generados
FROM servicios AS s
LEFT JOIN ordenes_servicio AS o
    ON s.id_servicio = o.id_servicio
GROUP BY s.id_servicio, s.nombre
ORDER BY cantidad_realizada DESC, ingresos_generados DESC;
```

## Decisiones de diseño

Se mantuvieron cuatro tablas para respetar el límite establecido por el ejercicio.

`clientes` y `motos` representan la relación entre propietarios y vehículos. `servicios` funciona como catálogo independiente y `ordenes_servicio` actúa como entidad transaccional que conecta las motos con los servicios realizados.

Las restricciones de integridad evitan datos inconsistentes y los índices facilitan búsquedas frecuentes por cliente, moto, servicio y fecha.

La solución utiliza únicamente características compatibles con SQLite.