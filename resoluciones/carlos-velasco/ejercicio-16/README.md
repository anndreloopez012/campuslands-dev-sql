# Ejercicio 16: Aerolinea Vuelos

## Información

| Campo | Valor |
| --- | --- |
| Nombre | Carlos Velasco |
| Fecha | 2026-08-20 |
| Motor | SQLite |
| Ejercicio | 16 |
| Tema | Aerolinea y reservas de vuelos |

## Descripción

El ejercicio implementa una base de datos relacional para administrar vuelos y reservas de pasajeros de una aerolínea.

El modelo reemplaza el manejo de información dispersa por cuatro tablas relacionadas: `aeropuertos`, `aviones`, `vuelos` y `reservas`.

## Modelo implementado

```text
aeropuertos
    ├──< vuelos >── aviones
    │
    └──< vuelos >── aeropuertos

vuelos
    └──< reservas
```

La tabla `vuelos` funciona como entidad central. Cada vuelo tiene un aeropuerto de origen, un aeropuerto de destino y un avión asignado. La tabla `reservas` registra los pasajeros asociados a cada vuelo.

## Tablas

### `aeropuertos`

Contiene los aeropuertos utilizados como origen y destino de los vuelos.

Campos principales:

- `id_aeropuerto`
- `codigo_iata`
- `nombre`
- `ciudad`
- `pais`

### `aviones`

Contiene la información de las aeronaves disponibles.

Campos principales:

- `id_avion`
- `matricula`
- `modelo`
- `capacidad`
- `estado`

### `vuelos`

Representa los vuelos programados.

Campos principales:

- `id_vuelo`
- `codigo_vuelo`
- `aeropuerto_origen_id`
- `aeropuerto_destino_id`
- `avion_id`
- `fecha_salida`
- `fecha_llegada`
- `estado`

### `reservas`

Registra las reservas realizadas por pasajeros.

Campos principales:

- `id_reserva`
- `vuelo_id`
- `nombre_pasajero`
- `documento`
- `asiento`
- `fecha_reserva`
- `estado`

## Restricciones

Se activó la integridad referencial mediante:

```sql
PRAGMA foreign_keys = ON;
```

Se utilizaron claves primarias en todas las tablas y claves foráneas para mantener las relaciones.

Las restricciones `UNIQUE` evitan duplicidades en:

- códigos IATA;
- matrículas;
- códigos de vuelo;
- documentos de pasajeros;
- combinaciones de vuelo y asiento.

Las restricciones `CHECK` controlan:

- capacidad positiva de los aviones;
- estados válidos;
- aeropuertos de origen y destino diferentes;
- fecha de llegada posterior a la fecha de salida.

## Datos

La carga inicial contiene:

- 5 aeropuertos;
- 5 aviones;
- 12 vuelos;
- 14 reservas.

Las reservas contienen diferentes estados y vuelos para permitir la ejecución de las consultas de agregación, agrupación, relaciones y análisis de ocupación.

## Operaciones

`dml/operaciones.sql` contiene:

- 2 inserciones adicionales;
- 2 actualizaciones válidas;
- 2 eliminaciones controladas;
- 2 operaciones inválidas comentadas.

Las operaciones inválidas corresponden a una violación de `CHECK` y una violación de `FOREIGN KEY`.

## Consultas

`dql/consultas.sql` contiene las 12 consultas solicitadas:

1. Listado completo de vuelos.
2. Selección de dos columnas relevantes.
3. Filtrado por fecha.
4. Ordenamiento por fecha.
5. Cinco vuelos con mayor cantidad de reservas.
6. Conteo total de reservas.
7. Estadísticas de capacidad.
8. Agrupación de reservas por estado.
9. Relación de vuelos con aeropuertos.
10. Consulta con `WHERE`, `ORDER BY` y `LIMIT`.
11. Reporte con alias legibles.
12. Análisis de ocupación para apoyar decisiones operativas.

## Ejecución

Desde la raíz de la solución:

```bash
sqlite3 ejercicio-16.db < ddl/schema.sql
sqlite3 ejercicio-16.db < dml/inserts.sql
sqlite3 ejercicio-16.db < dml/operaciones.sql
sqlite3 ejercicio-16.db < dql/consultas.sql
```

El archivo de base de datos utilizado para las pruebas es temporal y no debe incluirse en el repositorio.

## Validaciones

La estructura puede comprobarse con:

```bash
sqlite3 ejercicio-16.db ".tables"
sqlite3 ejercicio-16.db ".schema"
sqlite3 ejercicio-16.db "PRAGMA foreign_keys;"
```

La última instrucción debe devolver:

```text
1
```

Las consultas permiten comprobar que las relaciones entre vuelos, aeropuertos, aviones y reservas funcionan correctamente.

## Evidencias de resultados esperados

Consulta de cantidad de reservas:

```sql
SELECT COUNT(*) AS total_reservas
FROM reservas;
```

Resultado esperado después de ejecutar `operaciones.sql`:

```text
total_reservas
--------------
14
```

Consulta de estados de reserva:

```sql
SELECT estado, COUNT(*) AS cantidad_reservas
FROM reservas
GROUP BY estado;
```

El resultado debe mostrar registros para los estados `CONFIRMADA` y `PENDIENTE`.

Consulta de vuelos con aeropuertos:

```sql
SELECT
    v.codigo_vuelo,
    origen.ciudad AS ciudad_origen,
    destino.ciudad AS ciudad_destino
FROM vuelos v
INNER JOIN aeropuertos origen
    ON origen.id_aeropuerto = v.aeropuerto_origen_id
INNER JOIN aeropuertos destino
    ON destino.id_aeropuerto = v.aeropuerto_destino_id;
```