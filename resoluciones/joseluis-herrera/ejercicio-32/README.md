# Ejercicio 32: Normalización Pedidos Restaurante

## Información

- Ejercicio: 32
- Tema: Normalización de datos
- Nivel: Intermedio
- Estudiante: Jose Luis Herrera

## Descripción

El ejercicio parte de un archivo plano utilizado para registrar pedidos de restaurante.

La estructura original contiene información de mesa, mesero, platos, categorías, precios, cantidades y fecha del pedido en una misma fila.

La solución transforma la información hasta tercera forma normal (3FN), separando las entidades y relaciones principales.


## Consultas

El archivo `dql/consultas.sql` contiene consultas para:

1. Reconstruir una vista similar al archivo original.
2. Listar entidades principales sin duplicados.
3. Contar platos por categoría.
4. Calcular el total de cada pedido.
5. Obtener promedio, mínimo y máximo de precios.
6. Buscar platos mediante `LIKE`.
7. Filtrar pedidos por fecha y platos por rango de precio.
8. Obtener los cinco platos con mayor cantidad vendida.
9. Detectar pedidos sin detalle.
10. Generar un reporte final con alias legibles.

## Validación del modelo

La reconstrucción de la información original se realiza mediante `JOIN` entre:

```text
MESAS
   |
PEDIDOS
   |
DETALLE_PEDIDO
   |
PLATOS
   |
CATEGORIAS

PEDIDOS
   |
MESEROS
```

La normalización permite mantener cada dato en una única ubicación lógica y evita duplicidad de información sobre mesas, meseros, categorías y platos.
