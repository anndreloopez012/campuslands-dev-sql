# Ejercicio 26: Normalizacion Tienda

## Información

- **Estudiante:** Carlos Velasco
- **Ejercicio:** 26
- **Tema:** Normalización hasta tercera forma normal
- **Motor:** SQLite
- **Fecha:** 2026-08-20

## Descripción

El ejercicio consiste en transformar información de una tienda que originalmente se manejaba de forma repetida en hojas sueltas hacia un modelo relacional normalizado.

La solución separa clientes, categorías, productos y compras en cuatro tablas con responsabilidades específicas, evitando repetir información descriptiva en los registros transaccionales.

## Modelo implementado

```text
categorias
    │
    └──< productos
             │
             └──< compras >── clientes
```

### Tablas

| Tabla | Responsabilidad |
| --- | --- |
| `categorias` | Catálogo de categorías disponibles |
| `clientes` | Información de los clientes |
| `productos` | Catálogo de productos y sus datos comerciales |
| `compras` | Registro de las operaciones de compra |

## Relaciones

- `productos.id_categoria` referencia `categorias.id_categoria`.
- `compras.id_cliente` referencia `clientes.id_cliente`.
- `compras.id_producto` referencia `productos.id_producto`.

## Normalización

### Primera forma normal

Los atributos contienen valores atómicos y cada registro se identifica mediante una clave primaria.

### Segunda forma normal

Cada tabla utiliza una clave primaria y los atributos dependen de la entidad correspondiente.

### Tercera forma normal

Los datos descriptivos se mantienen en sus respectivas entidades. La categoría se almacena en `categorias`, los datos del cliente en `clientes` y los datos del producto en `productos`, evitando dependencias transitivas innecesarias.

## Restricciones aplicadas

- `PRIMARY KEY` en las cuatro tablas.
- `FOREIGN KEY` para representar las relaciones.
- `NOT NULL` en los atributos obligatorios.
- `UNIQUE` en `categorias.nombre`.
- `UNIQUE` en `clientes.correo`.
- `UNIQUE` en `productos.sku`.
- `CHECK (precio > 0)` en `productos`.
- `CHECK (stock >= 0)` en `productos`.
- `CHECK (cantidad > 0)` en `compras`.
- `PRAGMA foreign_keys = ON`.
- Índices para las columnas utilizadas como relaciones y para la fecha de compra.

## Datos

Se cargaron:

- 5 categorías.
- 5 clientes iniciales.
- 5 productos.
- 10 compras iniciales.

Posteriormente se realizaron 2 `INSERT` adicionales mediante `operaciones.sql`, además de actualizaciones y eliminaciones controladas.

## Operaciones

El archivo `dml/operaciones.sql` contiene:

- 2 operaciones `INSERT`.
- 2 operaciones `UPDATE`.
- 2 operaciones `DELETE`.
- 2 operaciones inválidas comentadas.
- Una violación `UNIQUE` comentada.
- Una violación `FOREIGN KEY` comentada.

Las operaciones inválidas permanecen comentadas para evitar que interrumpan la ejecución completa del script.

## Consultas

El archivo `dql/consultas.sql` contiene las 12 consultas solicitadas:

1. Listado de compras.
2. Selección de dos columnas.
3. Filtrado por cantidad.
4. Ordenamiento por fecha.
5. Cinco compras principales.
6. Conteo total.
7. Estadísticas de precios.
8. Agrupación por producto.
9. `JOIN` entre clientes, productos y compras.
10. Consulta con `WHERE`, `ORDER BY` y `LIMIT`.
11. Reporte con alias legibles.
12. Reporte de productos según nivel de demanda.

## Ejecución

Desde la carpeta de la solución:

```bash
sqlite3 ejercicio-26.db < ddl/schema.sql
sqlite3 ejercicio-26.db < dml/inserts.sql
sqlite3 ejercicio-26.db < dml/operaciones.sql
sqlite3 ejercicio-26.db < dql/consultas.sql
```

Para comprobar las tablas creadas:

```bash
sqlite3 ejercicio-26.db ".tables"
```

Para comprobar las relaciones:

```bash
sqlite3 ejercicio-26.db "PRAGMA foreign_key_list(productos);"
sqlite3 ejercicio-26.db "PRAGMA foreign_key_list(compras);"
```

Para comprobar las restricciones principales:

```bash
sqlite3 ejercicio-26.db ".schema"
```

## Validaciones

La implementación permite comprobar:

- Integridad referencial mediante claves foráneas.
- Unicidad de correos, SKU y nombres de categorías.
- Validación de precios positivos.
- Validación de stock no negativo.
- Validación de cantidades de compra positivas.
- Integridad de las relaciones entre clientes, productos, categorías y compras.
- Generación de reportes mediante `JOIN`, agregaciones y agrupaciones.

## Evidencias de ejecución

Las consultas permiten obtener resultados verificables para:

- Total de compras.
- Estadísticas de precios.
- Unidades vendidas por producto.
- Información completa de cada compra.
- Reportes relacionados con clientes, productos y categorías.
- Identificación de productos con alta, media o baja demanda.

## Decisiones de diseño

Se utilizaron cuatro tablas, respetando el límite establecido por el ejercicio.

La tabla `compras` funciona como entidad transaccional y utiliza claves foráneas hacia `clientes` y `productos`. La información de categorías se mantiene separada de los productos para evitar repetir sus nombres.

Los identificadores son claves primarias independientes y las relaciones se implementan mediante claves foráneas. Las restricciones `UNIQUE`, `NOT NULL` y `CHECK` permiten proteger la calidad de los datos desde la propia base de datos.

Las fechas se almacenan utilizando el formato ISO `YYYY-MM-DD`.

No se incluye ningún archivo de base de datos generado (`.db`, `.sqlite` o `.sqlite3`) en la solución.