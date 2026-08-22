# Ejercicio 26: Normalizacion Tienda

## Información

- **Nombre:** Jose Luis Tot Herrera
- **Ejercicio:** 26
- **Nombre:** Normalizacion Tienda
- **Fecha:** 2026-08-21

## Descripción

La organización registraba manualmente información de clientes, productos, categorias y compras, generando duplicidad de datos, errores de captura y dificultad para generar reportes.

La solución divide la información en cuatro tablas relacionadas, asignando una responsabilidad específica a cada entidad y evitando la repetición innecesaria de datos.

## Modelo implementado

El modelo contiene cuatro tablas:

- `clientes`: almacena la información de los clientes.
- `categorias`: almacena las categorias de productos.
- `productos`: almacena los productos y su categoria.
- `compras`: registra las operaciones de compra realizadas por los clientes.

## Relaciones

- `clientes` se relaciona con `compras` mediante `id_cliente`.
- `categorias` se relaciona con `productos` mediante `id_categoria`.
- `productos` se relaciona con `compras` mediante `id_producto`.


## Operaciones

Las operaciones adicionales permiten comprobar:

- inserciones validas;
- actualizaciones validas;
- eliminaciones mediante `WHERE`;
- rechazo de valores que incumplen restricciones.

Las operaciones invalidas permanecen comentadas para no interrumpir la ejecución completa del archivo.

## Consultas

El archivo `dql/consultas.sql` contiene consultas para:

1. Listar las compras.
2. Seleccionar columnas especificas.
3. Filtrar por fecha.
4. Ordenar compras.
5. Obtener las cinco compras con mayor cantidad.
6. Contar compras.
7. Calcular promedio, minimo y maximo.
8. Agrupar unidades vendidas por producto.
9. Relacionar clientes, productos y compras.
10. Aplicar `WHERE`, `ORDER BY` y `LIMIT`.
11. Generar un reporte con alias.
12. Identificar productos que requieren reabastecimiento o monitoreo.

