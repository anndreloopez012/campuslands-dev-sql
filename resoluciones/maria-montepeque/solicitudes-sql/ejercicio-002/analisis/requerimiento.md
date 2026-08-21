# Analisis del requerimiento - Ejercicio 002

## Solicitud entendida

Un taller de motos recibe servicios (mantenimiento, reparaciones) por orden de trabajo, y en cada orden interviene un mecanico y puede haber costo de repuestos y mano de obra. El cliente quiere saber, para cada movimiento del taller: quien trajo la moto, que se le hizo, cuando ocurrio y cuanto dinero representa. Tambien quiere poder consultar datos, corregir estados y sacar reportes.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| motos | Es el catalogo de las motos que atiende el taller, identificadas por placa; una moto puede volver muchas veces por distintos servicios. | placa (unica), marca, modelo, nombre_dueno |
| ordenes_trabajo | Es el registro transaccional de cada servicio realizado: que se hizo, quien lo hizo, cuando y cuanto costo. Aqui vive la pregunta central del cliente (quien, que, cuando, cuanto). | id_moto (FK), descripcion_servicio, mecanico_asignado, costo, fecha_orden, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| motos -> ordenes_trabajo | 1:N | Una misma moto puede tener muchas ordenes de trabajo a lo largo del tiempo, pero cada orden es de una unica moto. |

## Reglas de negocio

- Regla 1: Toda orden de trabajo debe estar ligada a una moto registrada (`FOREIGN KEY`); no se puede facturar un servicio sin saber a que moto pertenece.
- Regla 2: El costo de una orden siempre debe ser mayor a cero (`CHECK`); un servicio de costo cero o negativo no representa un movimiento real de dinero.
- Regla 3: Una orden puede estar `en_proceso`, `completada` o `cancelada`; el taller necesita poder corregir ese estado (por ejemplo, cuando termina un trabajo que estaba en proceso).
- Regla 4: La placa de la moto no se repite (`UNIQUE`), porque identifica de forma unica el vehiculo dentro del taller.

## Supuestos

- No se creo una tabla `clientes` separada: el nombre del dueno se guarda dentro de `motos` (una moto normalmente tiene un dueno principal), respetando el alcance de 1 a 2 tablas de este nivel.
- No se separaron `repuestos` ni `mecanicos` en tablas propias en este nivel; `mecanico_asignado` se guarda como texto dentro de la orden y el costo de la orden se asume que ya incluye repuestos y mano de obra. Si el taller necesitara despues detallar cada repuesto usado, se separaria en una tabla `detalle_repuestos`.
- El estado por defecto de una orden nueva es `en_proceso`, porque asi entra un trabajo recien recibido.

## Preguntas que responde la base de datos

1. Que ordenes de trabajo existen y en que estado quedo cada una.
2. Que ordenes siguen en proceso (no finalizadas).
3. Que moto (y por lo tanto que cliente) genera mas ordenes de trabajo.
4. Como se ordenan las ordenes por fecha, para revisar el trabajo del taller dia a dia.
5. Que mecanico genero mas ingresos por servicios completados, para decisiones de carga de trabajo.
