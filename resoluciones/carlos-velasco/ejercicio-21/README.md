# Ejercicio 21: Logistica Envios

## Información

- **Nombre:** Carlos Velasco
- **Fecha:** 2026-08-20
- **Motor:** SQLite
- **Ejercicio:** 21
- **Tema:** Seguimiento de envíos

## Descripción

Una empresa de logística necesita organizar la información relacionada con clientes, paquetes, rutas y envíos. El objetivo es reemplazar registros dispersos por un modelo relacional que permita controlar los envíos y generar consultas para apoyar la operación.

## Solución implementada

La base de datos utiliza cuatro tablas:

| Tabla | Responsabilidad |
| --- | --- |
| `clientes` | Almacenar los datos de los clientes |
| `paquetes` | Registrar los paquetes enviados por los clientes |
| `rutas` | Definir los trayectos disponibles |
| `envios` | Registrar cada operación de envío |

La entidad central es `envios`, ya que relaciona un paquete con una ruta y permite controlar fechas, estado y costo.

## Relaciones

```text
CLIENTES 1 ─────── N PAQUETES
PAQUETES 1 ─────── N ENVIOS
RUTAS    1 ─────── N ENVIOS
```

## Restricciones

Se implementaron:

- `PRIMARY KEY` en las cuatro tablas.
- `FOREIGN KEY` entre clientes y paquetes.
- `FOREIGN KEY` entre paquetes y envíos.
- `FOREIGN KEY` entre rutas y envíos.
- `NOT NULL` para los campos obligatorios.
- `UNIQUE` para el correo de los clientes.
- `UNIQUE` compuesto para origen y destino de las rutas.
- `CHECK` para distancia, peso, tipo de paquete, estado y costo.
- `CHECK` para impedir que la fecha de entrega sea anterior a la fecha de envío.
- `PRAGMA foreign_keys = ON`.

## Datos cargados

Se registraron:

- 5 clientes.
- 5 rutas.
- 10 paquetes.
- 10 envíos.

Los datos fueron preparados para que las consultas de filtrado, ordenamiento, agrupación, agregación y relaciones produzcan resultados.

## Operaciones DML

El archivo `dml/operaciones.sql` contiene:

- 2 `INSERT` adicionales.
- 2 `UPDATE` válidos.
- 2 `DELETE` controlados mediante `WHERE`.
- 2 operaciones inválidas comentadas.

Las operaciones inválidas corresponden a:

```text
1. Violación de CHECK mediante un peso de paquete negativo.
2. Violación de FOREIGN KEY mediante una ruta inexistente.
```

Las operaciones inválidas permanecen comentadas para permitir la ejecución completa del script.

## Consultas implementadas

El archivo `dql/consultas.sql` contiene consultas para:

1. Listar los envíos.
2. Seleccionar columnas específicas.
3. Filtrar envíos por costo.
4. Ordenar envíos por fecha.
5. Obtener los cinco envíos de mayor costo.
6. Contar el total de envíos.
7. Calcular estadísticas del costo.
8. Agrupar envíos por estado.
9. Relacionar clientes, paquetes y envíos.
10. Filtrar, ordenar y limitar resultados.
11. Generar un reporte con alias legibles.
12. Identificar rutas con mayor demanda para apoyar decisiones operativas.

## Ejecución

Desde la raíz de la solución:

```bash
sqlite3 ejercicio-21.db < ddl/schema.sql
sqlite3 ejercicio-21.db < dml/inserts.sql
sqlite3 ejercicio-21.db < dml/operaciones.sql
sqlite3 ejercicio-21.db < dql/consultas.sql
```

## Validaciones

Para comprobar que las claves foráneas están activas:

```sql
PRAGMA foreign_keys;
```

Resultado esperado:

```text
1
```

Para comprobar las tablas creadas:

```sql
.tables
```

Resultado esperado:

```text
clientes  envios  paquetes  rutas
```

Para verificar las relaciones:

```sql
PRAGMA foreign_key_list(paquetes);
PRAGMA foreign_key_list(envios);
```

## Decisiones de diseño

Se mantuvieron cuatro tablas para cumplir el límite establecido por el ejercicio. `envios` concentra la información transaccional, mientras que `clientes`, `paquetes` y `rutas` representan las entidades relacionadas.

Los estados del envío se restringieron mediante `CHECK` para evitar valores inconsistentes. Las fechas se almacenan en formato ISO `YYYY-MM-DD`, lo que permite ordenarlas correctamente en SQLite.

Se agregaron índices sobre las claves foráneas y el estado de los envíos para facilitar las consultas frecuentes sobre relaciones y seguimiento operativo.

## Archivos

```text
ddl/schema.sql
dml/inserts.sql
dml/operaciones.sql
dql/consultas.sql
diagramas/README.md
```

## Evidencia

La solución queda preparada para ejecutarse mediante los cuatro scripts SQL indicados y permite demostrar la creación del modelo, carga de datos, operaciones de modificación y consultas requeridas.