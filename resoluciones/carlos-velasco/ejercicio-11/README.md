# Ejercicio 11: Transporte Rutas

## Información

| Campo | Valor |
| --- | --- |
| Nombre | Carlos Velasco |
| Ejercicio | 11 - Transporte Rutas |
| Motor | SQLite |
| Fecha | 2026-08-20 |
| Rama | `alumno/carlos-velasco/ejercicio-11` |

## Descripción

El ejercicio implementa una base de datos relacional para gestionar rutas, buses, conductores y viajes programados de una empresa de transporte.

El objetivo es sustituir el manejo manual de información por un modelo estructurado que permita organizar los viajes, controlar la capacidad de los buses, asignar conductores y generar reportes para apoyar la planificación operativa.

## Modelo implementado

La solución utiliza cuatro tablas:

| Tabla | Responsabilidad |
| --- | --- |
| `rutas` | Registrar los recorridos disponibles, sus puntos de origen y destino y la distancia. |
| `buses` | Registrar los vehículos y su capacidad operativa. |
| `conductores` | Registrar los conductores y sus datos de identificación profesional. |
| `viajes` | Gestionar los viajes programados y relacionar rutas, buses y conductores. |

La tabla `viajes` funciona como entidad central del modelo.

```text
rutas 1 ──────── N viajes N ──────── 1 buses
                   │
                   N
                   │
                   1
              conductores
```

## Relaciones

- Una ruta puede tener múltiples viajes.
- Un bus puede participar en múltiples viajes en diferentes horarios.
- Un conductor puede realizar múltiples viajes en diferentes horarios.
- Cada viaje pertenece obligatoriamente a una ruta.
- Cada viaje utiliza obligatoriamente un bus.
- Cada viaje tiene asignado obligatoriamente un conductor.

## Restricciones

El esquema utiliza:

- `PRIMARY KEY` para identificar cada registro.
- `FOREIGN KEY` para mantener la integridad referencial.
- `NOT NULL` para campos obligatorios.
- `UNIQUE` en códigos de ruta.
- `UNIQUE` en placas de buses.
- `UNIQUE` en documentos y licencias de conductores.
- `UNIQUE` en la combinación de bus y fecha-hora de viaje.
- `UNIQUE` en la combinación de conductor y fecha-hora de viaje.
- `CHECK` para validar distancias positivas.
- `CHECK` para validar capacidades de buses.
- `CHECK` para validar años de fabricación.
- `CHECK` para validar estados.
- `CHECK` para validar cantidades de pasajeros.
- `CHECK` para validar fechas en formato ISO.
- `DEFAULT` para establecer estados iniciales.
- `PRAGMA foreign_keys = ON` para activar la integridad referencial de SQLite.
- Índices para facilitar consultas sobre fechas, rutas, buses y conductores.

## Datos

Los datos base incluyen:

- 5 rutas.
- 5 buses.
- 5 conductores.
- 10 viajes.

Los viajes utilizan diferentes rutas, buses, conductores y cantidades de pasajeros para permitir el análisis de capacidad y demanda.

La cantidad de pasajeros registrada en cada viaje se mantiene dentro de la capacidad del bus asignado.

## Operaciones

El archivo `dml/operaciones.sql` contiene:

- 2 `INSERT` adicionales.
- 2 `UPDATE` válidos.
- 2 `DELETE` controlados mediante `WHERE`.
- 1 operación inválida por `UNIQUE`, comentada.
- 1 operación inválida por `FOREIGN KEY`, comentada.

Las operaciones inválidas permanecen comentadas para permitir la ejecución completa del script.

## Consultas

El archivo `dql/consultas.sql` contiene consultas para:

1. Listar todos los viajes.
2. Mostrar fecha y cantidad de pasajeros.
3. Filtrar viajes por fecha.
4. Ordenar viajes cronológicamente.
5. Obtener los cinco viajes con mayor cantidad de pasajeros.
6. Contar el total de viajes.
7. Calcular promedio, mínimo y máximo de pasajeros.
8. Agrupar viajes por estado.
9. Relacionar rutas con viajes.
10. Aplicar `WHERE`, `ORDER BY` y `LIMIT`.
11. Generar un reporte con rutas, buses, conductores, capacidad y porcentaje de ocupación.
12. Identificar las rutas con mayor demanda para apoyar decisiones operativas.

## Ejecución

Desde la raíz de la solución:

```bash
sqlite3 ejercicio-11.db < ddl/schema.sql
sqlite3 ejercicio-11.db < dml/inserts.sql
sqlite3 ejercicio-11.db < dml/operaciones.sql
sqlite3 ejercicio-11.db < dql/consultas.sql
```

Para validar las tablas:

```bash
sqlite3 ejercicio-11.db ".tables"
```

Para consultar el esquema:

```bash
sqlite3 ejercicio-11.db ".schema"
```

Para comprobar la integridad referencial:

```bash
sqlite3 ejercicio-11.db "PRAGMA foreign_keys = ON;"
sqlite3 ejercicio-11.db "PRAGMA foreign_key_check;"
```

Para comprobar la capacidad de los viajes:

```sql
SELECT
    v.id_viaje,
    b.placa,
    b.capacidad,
    v.pasajeros_registrados
FROM viajes AS v
INNER JOIN buses AS b
    ON b.id_bus = v.id_bus
WHERE v.pasajeros_registrados > b.capacidad;
```

La consulta de capacidad debe devolver cero registros.

El archivo de base de datos utilizado durante las pruebas debe eliminarse antes de realizar la entrega.

## Validaciones

La implementación permite comprobar:

- Integridad de las relaciones entre rutas, buses, conductores y viajes.
- Prevención de códigos de ruta duplicados.
- Prevención de placas de buses duplicadas.
- Prevención de documentos de conductores duplicados.
- Prevención de licencias duplicadas.
- Validación de distancias positivas.
- Validación de capacidades de los buses.
- Validación de años de fabricación.
- Validación de estados permitidos.
- Validación de cantidades de pasajeros no negativas.
- Validación de fechas en formato ISO.
- Prevención de asignaciones simultáneas del mismo bus.
- Prevención de asignaciones simultáneas del mismo conductor.
- Prevención de viajes asociados a rutas, buses o conductores inexistentes.

## Decisiones de diseño

Se utilizaron cuatro tablas para respetar el límite establecido por el ejercicio.

Las rutas, buses y conductores se mantienen separados de los viajes porque representan catálogos reutilizables. La tabla `viajes` registra la programación operativa y mantiene las relaciones con estos tres catálogos.

La fecha y hora del viaje se almacena en formato ISO `YYYY-MM-DD HH:MM`, permitiendo ordenar y filtrar los viajes cronológicamente.

La capacidad pertenece al bus porque representa una característica propia del vehículo. La cantidad de pasajeros pertenece al viaje porque cambia según cada servicio programado.

Las restricciones `UNIQUE` sobre bus-fecha y conductor-fecha permiten evitar conflictos básicos de programación.

Los índices se orientan a las consultas habituales relacionadas con agenda, rutas, buses y conductores.

## Archivos principales

```text
ddl/schema.sql
dml/inserts.sql
dml/operaciones.sql
dql/consultas.sql
diagramas/README.md
```