# Analisis del requerimiento - Ejercicio 034

## Solicitud entendida

Un estudio de animacion 3D maneja proyectos, artistas, entregas y estados. El cliente necesita un reporte rapido al final de cada semana para tomar decisiones (por ejemplo, a que artista asignar el siguiente proyecto). Pide explicitamente no guardar solo texto: quiere poder consultar datos, corregir estados y registrar movimientos.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| clientes | Es el catalogo de clientes que contratan proyectos al estudio. | nombre_cliente (unico), email |
| artistas | Es el catalogo de artistas 3D del estudio. | nombre_artista (unico), especialidad |
| proyectos | Es el registro transaccional de cada trabajo: que cliente lo pidio, que artista lo hace, cuando se entrega, cuanto vale y en que estado va. Aqui es donde el estudio necesita corregir estados semana a semana. | id_cliente (FK), id_artista (FK), nombre_proyecto, fecha_entrega, presupuesto, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| clientes -> proyectos | 1:N | Un cliente puede tener muchos proyectos. |
| artistas -> proyectos | 1:N | Un artista puede tener asignados muchos proyectos. |

## Reglas de negocio

- Regla 1: Todo proyecto debe apuntar a un cliente real y a un artista real (`FOREIGN KEY` doble).
- Regla 2: `email` y `especialidad` son `NOT NULL`: son datos que, si faltaran, romperian el contacto con el cliente o la asignacion de trabajo por especialidad.
- Regla 3: `presupuesto` siempre debe ser mayor a cero (`CHECK`).
- Regla 4: Un proyecto puede estar `pendiente`, `en_progreso`, `en_revision`, `finalizado` o `cancelado` (`CHECK`); el estudio necesita poder corregir este estado cada semana.
- Regla 5: `nombre_cliente` y `nombre_artista` no se repiten (`UNIQUE`).

## Supuestos

- Se asume un artista principal por proyecto (relacion 1:N, no un equipo completo), porque el alcance de este nivel es "relaciones basicas". Una version mas avanzada necesitaria una tabla puente `proyecto_artistas` para equipos de varios artistas por proyecto.
- `especialidad` se limito a un catalogo cerrado (`modelado`, `animacion`, `texturizado`, `iluminacion`) porque son los roles que menciona el contexto del estudio.

## Preguntas que responde la base de datos

1. Que proyectos existen, con que cliente y que artista.
2. Que proyectos no estan finalizados todavia.
3. Que artista tiene mas proyectos asignados en total.
4. Como se ordenan los proyectos por fecha de entrega.
5. Cuanta carga de trabajo activa tiene cada artista esta semana (para decidir a quien asignar el siguiente proyecto).
