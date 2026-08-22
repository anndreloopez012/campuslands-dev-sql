# Ejercicio 38: Normalización Ecommerce Envios

## Información

- Ejercicio: 38
- Tema: Normalización de datos
- Nivel: Intermedio
- Estudiante: Jose Luis Herrera

## Descripción

El ejercicio parte de un archivo plano para administrar órdenes de comercio electrónico con compradores, productos, cupones, métodos de pago, direcciones de envío y transportadoras.

La estructura original mezcla información de diferentes entidades y permite almacenar múltiples productos dentro de una misma celda.

La solución transforma el diseño hasta tercera forma normal (3FN).

## Modelo implementado
Las relaciones principales son:

```text
COMPRADORES ─── ORDENES ─── DETALLE_ORDEN ─── PRODUCTOS
                    |
                    ├── PAGOS
                    |
                    ├── ENVIOS ─── TRANSPORTADORAS
                    |
                    └── CUPONES
```


## Normalización

El proceso aplicado es:

```text
Tabla sin normalizar
        |
        v
       1FN
Separación de valores multivaluados
        |
        v
       2FN
Separación de dependencias parciales
        |
        v
       3FN
Separación de dependencias transitivas
```

## Consultas

El archivo `dql/consultas.sql` contiene consultas para:

1. Reconstruir una vista similar al archivo original mediante `JOIN`.
2. Listar compradores, productos y órdenes sin duplicados.
3. Contar órdenes por estado.
4. Contar productos por categoría.
5. Calcular el total de cada orden.
6. Calcular promedios, mínimos y máximos.
7. Buscar compradores y productos mediante `LIKE`.
8. Filtrar órdenes por fecha.
9. Filtrar productos por rango de precio.
10. Obtener los cinco productos con mayor cantidad vendida.
11. Obtener las cinco órdenes con mayor monto.
12. Detectar productos sin órdenes.
13. Detectar órdenes sin pago.
14. Generar un reporte final de órdenes.

## Resultado esperado

El modelo permite administrar compradores, productos, órdenes, pagos, cupones y envíos sin almacenar múltiples valores dentro de una misma celda y evitando la duplicidad de información.