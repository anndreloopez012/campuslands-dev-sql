# Analisis del requerimiento

## Solicitud recibida

El cliente requiere estructurar la informacion de su negocio en una base de datos relacional para optimizar la gestion, evitar duplicidad y generar reportes.

## Solicitud entendida

Se construira un modelo con tablas bien definidas para registrar las entidades clave de Soldadura Industrial, garantizando la integridad de los datos.

## Entidades principales

| Entidad | Atributos principales |
| --- | --- |
| clientes | id, nombre/codigo, atributos de negocio |
| materiales | id, nombre/codigo, atributos de negocio |
| ordenes | id, nombre/codigo, atributos de negocio |

## Relacion

Una orden asocia UN cliente con UN tipo de material de soldadura.

## Reglas y supuestos

- Todo ID es autoincremental y llave primaria.
- Llaves foraneas aseguran la integridad referencial.
- Campos numericos restrictivos mediante `CHECK`.

## Preguntas que responde

1. Estado general de los registros principales.
2. Detalle de transacciones u operaciones vinculadas.
3. Totales y reportes de rendimiento del negocio.
