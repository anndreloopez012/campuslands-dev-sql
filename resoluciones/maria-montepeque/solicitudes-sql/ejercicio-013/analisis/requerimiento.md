# Analisis del requerimiento - Ejercicio 013

## Solicitud entendida

Un estudio de tatuajes agenda sesiones con sus artistas, cada uno con su estilo y con un pago asociado. El cliente pidio explicitamente evitar registros incompletos, porque despues no puede hacer reportes confiables (por ejemplo, si una sesion no tiene monto pagado, un reporte de ingresos por artista quedaria mal sin que nadie lo note).

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| artistas | Es el catalogo de tatuadores del estudio, cada uno con su estilo principal. | nombre_artista (unico), estilo_principal |
| sesiones | Es el registro transaccional de cada cita: que artista, que cliente, cuando, cuanto se pago y en que estado va. Aqui es donde el cliente sufre los registros incompletos si algun campo clave falta. | id_artista (FK), nombre_cliente, fecha_sesion, monto_pagado, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| artistas -> sesiones | 1:N | Un artista atiende muchas sesiones, pero cada sesion es de un unico artista. |

## Reglas de negocio

- Regla 1: Toda sesion debe apuntar a un artista real del catalogo (`FOREIGN KEY`).
- Regla 2: `nombre_cliente`, `fecha_sesion` y `monto_pagado` son `NOT NULL`: son exactamente los datos que, si faltaran, harian que un reporte de ingresos o de actividad no sea confiable.
- Regla 3: `monto_pagado` siempre debe ser mayor a cero (`CHECK`).
- Regla 4: Una sesion puede estar `agendada`, `completada` o `cancelada` (`CHECK`); el estudio necesita poder corregir este estado a medida que avanza la cita.
- Regla 5: El nombre del artista no se repite (`UNIQUE`).

## Supuestos

- No se creo una tabla `clientes` separada: el alcance de este nivel pide 1 a 2 tablas, asi que el nombre del cliente se guarda dentro de `sesiones`.
- Se asume que `monto_pagado` se registra al momento de agendar la sesion (aunque la sesion todavia este `agendada`), porque muchos estudios cobran un anticipo; el reporte de ingresos solo suma las sesiones `completada` para reflejar dinero realmente cobrado por trabajo terminado.

## Preguntas que responde la base de datos

1. Que sesiones existen y en que estado quedo cada una.
2. Que sesiones no estan completadas todavia.
3. Que artista tiene mas sesiones completadas.
4. Como se ordenan las sesiones por fecha.
5. Cuanto genera cada artista en ingresos (solo sesiones completadas), para decisiones de comision o de agenda.
