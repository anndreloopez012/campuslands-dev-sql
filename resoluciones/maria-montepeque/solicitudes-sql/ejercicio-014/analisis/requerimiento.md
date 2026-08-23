# Analisis del requerimiento - Ejercicio 014

## Solicitud entendida

Un taller automotriz controla diagnosticos, reparaciones, repuestos y garantias, y necesita un reporte rapido al final de cada semana para tomar decisiones. Tambien quiere consultar datos, corregir estados y registrar movimientos.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| vehiculos | Es el catalogo de vehiculos atendidos por el taller, identificados por placa. | placa (unica), marca, modelo, nombre_dueno |
| reparaciones | Es el registro transaccional de cada trabajo realizado: diagnostico, costo, fecha, dias de garantia y estado. Aqui vive el reporte semanal que pide el cliente. | id_vehiculo (FK), diagnostico, costo, fecha_reparacion, garantia_dias, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| vehiculos -> reparaciones | 1:N | Un vehiculo puede tener muchas reparaciones a lo largo del tiempo, pero cada reparacion es de un unico vehiculo. |

## Reglas de negocio

- Regla 1: Toda reparacion debe apuntar a un vehiculo real del catalogo (`FOREIGN KEY`).
- Regla 2: `costo` siempre debe ser mayor a cero (`CHECK`), y `garantia_dias` nunca puede ser negativo.
- Regla 3: Una reparacion puede estar `en_proceso`, `completada` o `cancelada` (`CHECK`); el taller necesita poder corregir este estado a medida que avanza el trabajo.
- Regla 4: La placa de cada vehiculo no se repite (`UNIQUE`).

## Supuestos

- No se creo una tabla `clientes` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el nombre del dueno se guarda dentro de `vehiculos`.
- El reporte semanal se arma agrupando `reparaciones` por dia dentro del rango de fechas de la semana de prueba (2026-08-10 a 2026-08-16), usando `date(fecha_reparacion)`, solo con reparaciones `completada` (dinero realmente cobrado).
- `garantia_dias` tiene un valor por defecto de 30 dias, la garantia estandar del taller cuando no se especifica otra.

## Preguntas que responde la base de datos

1. Que reparaciones existen y en que estado quedo cada una.
2. Que reparaciones no estan completadas todavia.
3. Que vehiculo tiene mas reparaciones.
4. Como se ordenan las reparaciones por fecha, para revisar la semana dia a dia.
5. Que reporte semanal (ingresos por dia, solo reparaciones completadas) puede usar el taller para decidir compras de repuestos.
