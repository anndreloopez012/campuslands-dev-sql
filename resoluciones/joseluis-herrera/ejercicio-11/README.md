### README.md

# Ejercicio 11: Transporte Rutas

## Información

**Nombre:** Jose Luis Tot Herrera  
**Fecha:** 2026-08-20  
**Motor:** SQLite  
**Tema:** Viajes programados y capacidad de transporte

## Descripción

La organización necesita administrar rutas, buses, conductores y viajes programados mediante una base de datos relacional. El modelo permite registrar la información de los recursos de transporte y consultar la programación de viajes, capacidad y cantidad de pasajeros.

## Modelo implementado

La solución utiliza cuatro tablas:

- `rutas`: almacena los recorridos disponibles, su origen, destino y distancia.
- `buses`: almacena los vehículos disponibles, placa, modelo y capacidad.
- `conductores`: almacena los conductores y sus licencias y experiencia.
- `viajes`: registra los viajes programados y relaciona rutas, buses y conductores.

## Relaciones

```text
rutas 1 ──────── N viajes
buses 1 ──────── N viajes
conductores 1 ─ N viajes
```

Cada viaje pertenece a una ruta, utiliza un bus y tiene asignado un conductor.


## Datos

Se registraron:

- 5 rutas.
- 5 buses.
- 5 conductores.
- 10 viajes iniciales.
- 2 viajes adicionales mediante operaciones DML.

Los datos permiten consultar programación, capacidad, pasajeros, rutas y conductores.

## Consultas

El archivo `dql/consultas.sql` contiene consultas para:

1. Listar los viajes registrados.
2. Seleccionar columnas específicas.
3. Filtrar viajes según cantidad de pasajeros.
4. Ordenar viajes por fecha y hora.
5. Obtener los cinco viajes con mayor cantidad de pasajeros.
6. Contar viajes.
7. Obtener promedio, mínimo y máximo de pasajeros.
8. Agrupar viajes por ruta.
9. Relacionar viajes con rutas, buses y conductores mediante `JOIN`.
10. Filtrar, ordenar y limitar resultados.
11. Generar un reporte con alias legibles.
12. Identificar rutas con mayor volumen de pasajeros para apoyar decisiones de programación.

## Decisiones de diseño

El modelo se mantiene en cuatro tablas para respetar el límite establecido. `viajes` funciona como entidad transaccional central porque concentra la programación y referencia los recursos utilizados en cada recorrido.

Las restricciones `CHECK` permiten evitar valores inválidos y las restricciones `UNIQUE` evitan duplicidad en datos identificadores importantes.