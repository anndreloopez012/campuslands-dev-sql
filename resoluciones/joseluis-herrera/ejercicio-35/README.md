# Ejercicio 35: Normalización Inventario Proveedores

## Información

- Ejercicio: 35
- Tema: Normalización de datos
- Nivel: Intermedio
- Estudiante: Jose Luis Herrera

## Descripción

El ejercicio parte de un archivo plano para administrar productos, categorías, proveedores, teléfonos, entradas, salidas y bodegas.

La estructura original contiene información repetida y grupos de movimientos dentro de una misma fila.

La solución transforma la estructura hasta tercera forma normal (3FN).

## Modelo implementado

El modelo final está compuesto por:

```text
CATEGORIAS
PROVEEDORES
BODEGAS
PRODUCTOS
MOVIMIENTOS
```

Las relaciones principales son:

```text
CATEGORIAS
    |
PRODUCTOS
    |
PROVEEDORES

PRODUCTOS
    |
MOVIMIENTOS
    |
BODEGAS
```

## Consultas

El archivo `dql/consultas.sql` contiene consultas para:

1. Reconstruir una vista similar al archivo original mediante `JOIN`.
2. Listar productos, categorías y proveedores sin duplicados.
3. Contar productos por categoría.
4. Contar movimientos por tipo.
5. Calcular el stock actual por producto.
6. Calcular el valor del inventario.
7. Obtener precio promedio, mínimo y máximo.
8. Buscar productos utilizando `LIKE`.
9. Filtrar movimientos por fecha.
10. Filtrar productos por rango de precio.
11. Obtener el top 5 de productos por cantidad movida.
12. Detectar bodegas y movimientos relacionados.
13. Detectar productos cuyo stock está por debajo del mínimo.
14. Generar un reporte final con alias legibles.

## Resultado esperado

La información queda separada en entidades independientes y relacionadas mediante claves primarias y foráneas.

El modelo permite registrar movimientos individuales, consultar existencias y generar reportes de inventario sin almacenar múltiples movimientos dentro de una misma celda.