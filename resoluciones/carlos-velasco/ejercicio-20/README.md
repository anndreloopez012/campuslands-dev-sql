# Ejercicio 20: Eventos Boletos

## Información

- **Nombre:** Carlos Velasco
- **Ejercicio:** 20
- **Fecha:** 2026-08-20
- **Motor:** SQLite
- **Contexto:** Plataforma de eventos
- **Entidad central:** `boletos`

## Descripción

El ejercicio implementa una base de datos relacional para administrar eventos, lugares, asistentes y boletos. El modelo permite registrar los eventos disponibles, asociarlos con un lugar, registrar asistentes y controlar la venta de boletos.

La solución utiliza cuatro tablas y mantiene separadas las responsabilidades de cada entidad.

## Modelo implementado

```text
LUGARES
   │
   │ 1:N
   ▼
EVENTOS
   │
   │ 1:N
   ▼
BOLETOS
   ▲
   │ N:1
   │
ASISTENTES
```

### Tablas

| Tabla | Responsabilidad |
| --- | --- |
| `lugares` | Registrar los espacios donde se realizan los eventos. |
| `eventos` | Registrar los eventos programados y su lugar. |
| `asistentes` | Registrar las personas que adquieren boletos. |
| `boletos` | Registrar la relación entre asistentes y eventos junto con la información de compra. |

## Relaciones

- Un lugar puede albergar múltiples eventos.
- Cada evento pertenece a un lugar.
- Un evento puede tener múltiples boletos.
- Cada boleto pertenece a un evento.
- Un asistente puede adquirir boletos para diferentes eventos.
- Cada boleto pertenece a un asistente.
- Un asistente no puede tener dos boletos para el mismo evento debido a `UNIQUE(id_evento, id_asistente)`.

## Restricciones

La implementación utiliza:

- `PRIMARY KEY` en las cuatro tablas.
- `FOREIGN KEY` para relacionar eventos con lugares y boletos con eventos y asistentes.
- `NOT NULL` en los campos obligatorios.
- Restricciones `UNIQUE` en nombres, correos y combinación evento-asistente.
- Restricciones `CHECK` para capacidad, fechas, estados, tipos, precios y datos básicos.
- `DEFAULT` para estados de eventos y boletos.
- `PRAGMA foreign_keys = ON` para mantener la integridad referencial.

## Datos registrados

La carga inicial contiene:

- 5 lugares.
- 5 eventos.
- 5 asistentes.
- 10 boletos.

Los boletos contienen diferentes tipos y precios para permitir consultas de agregación, ordenamiento, agrupación y análisis de ocupación.

## Operaciones realizadas

El archivo `operaciones.sql` contiene:

- 2 `INSERT` adicionales.
- 2 `UPDATE` válidos.
- 2 `DELETE` controlados mediante `WHERE`.
- 2 operaciones inválidas comentadas para demostrar restricciones.

Las operaciones inválidas corresponden a:

1. Un boleto con precio igual a cero, rechazado por `CHECK`.
2. Un asistente con un correo existente, rechazado por `UNIQUE`.

## Consultas implementadas

El archivo `consultas.sql` contiene consultas para:

1. Listar todos los boletos.
2. Seleccionar dos columnas relevantes.
3. Filtrar boletos por precio.
4. Ordenar boletos por fecha.
5. Obtener los cinco boletos de mayor valor.
6. Contar boletos.
7. Calcular promedio, mínimo y máximo del precio.
8. Agrupar boletos por tipo.
9. Relacionar boletos con eventos y asistentes mediante `JOIN`.
10. Utilizar `WHERE`, `ORDER BY` y `LIMIT`.
11. Generar un reporte con alias legibles.
12. Identificar eventos con mayor nivel de ocupación para apoyar decisiones comerciales.

## Ejecución

Desde la raíz de `ejercicio-20`:

```bash
sqlite3 ejercicio-20.db < ddl/schema.sql
sqlite3 ejercicio-20.db < dml/inserts.sql
sqlite3 ejercicio-20.db < dml/operaciones.sql
sqlite3 ejercicio-20.db < dql/consultas.sql
```

Para ejecutar todos los archivos en una sola sesión:

```bash
sqlite3 ejercicio-20.db <<'SQL'
.read ddl/schema.sql
.read dml/inserts.sql
.read dml/operaciones.sql
.read dql/consultas.sql
SQL
```

## Validaciones

Verificar las tablas creadas:

```sql
.tables
```

Verificar la estructura:

```sql
.schema
```

Verificar las claves foráneas:

```sql
PRAGMA foreign_keys;
PRAGMA foreign_key_check;
```

Verificar la cantidad de registros:

```sql
SELECT 'lugares' AS tabla, COUNT(*) AS registros FROM lugares
UNION ALL
SELECT 'eventos', COUNT(*) FROM eventos
UNION ALL
SELECT 'asistentes', COUNT(*) FROM asistentes
UNION ALL
SELECT 'boletos', COUNT(*) FROM boletos;
```

## Resultados relevantes

La consulta de conteo permite comprobar la carga de datos base:

```text
lugares     5
eventos     5
asistentes  5
boletos     10
```

Las operaciones adicionales agregan temporalmente un evento y un asistente, y posteriormente ambos son eliminados mediante operaciones controladas.

Las consultas de análisis permiten identificar los eventos con mayor cantidad de boletos vendidos y calcular su porcentaje de ocupación respecto a la capacidad del lugar.

## Decisiones de diseño

Se utilizó `boletos` como entidad central porque representa la transacción principal del sistema y conecta eventos con asistentes.

La información de los lugares se mantiene separada de los eventos para evitar repetir datos de capacidad y ubicación.

Los tipos y estados se restringen mediante `CHECK` para evitar valores inconsistentes.

La combinación `id_evento` e `id_asistente` se definió como única para evitar que un mismo asistente tenga más de un boleto para el mismo evento.

Los índices sobre fechas de eventos y claves foráneas de boletos facilitan las consultas frecuentes del sistema.
