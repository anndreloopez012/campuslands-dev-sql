# Ejercicio 29: Transacciones Reservas

## Información

- Nombre: Jose Luis Herrera
- Ejercicio: 29
- Tema: Transacciones y consistencia


## Descripción

La organización necesita reemplazar el manejo manual de usuarios, recursos, reservas y pagos por una base de datos relacional que mantenga la integridad de la información y permita ejecutar operaciones de forma controlada mediante transacciones.

La solución utiliza cuatro tablas y relaciones mediante llaves foráneas.

## Modelo implementado

Las tablas utilizadas son:

- `usuarios`: almacena los datos de las personas que realizan reservas.
- `recursos`: almacena los espacios disponibles para reservar.
- `reservas`: registra las reservas realizadas por los usuarios.
- `pagos`: registra los pagos asociados a las reservas.

Las relaciones principales son:

- `usuarios` 1:N `reservas`.
- `recursos` 1:N `reservas`.
- `reservas` 1:N `pagos`.


## Transacciones

El archivo `dml/operaciones.sql` utiliza:

```sql
BEGIN TRANSACTION;
```

para iniciar operaciones agrupadas y:

```sql
COMMIT;
```

para confirmar los cambios.

Las operaciones válidas incluyen:

- 2 `INSERT`.
- 2 `UPDATE`.
- 2 `DELETE`.

Las operaciones sobre los registros adicionales se ejecutan dentro de una transacción para mantener los cambios agrupados.

También se incluye una segunda transacción para registrar y actualizar una reserva adicional.



## Consultas

El archivo `dql/consultas.sql` contiene consultas para:

- Listar todas las reservas.
- Mostrar columnas específicas.
- Filtrar reservas por valor.
- Ordenar reservas por fecha.
- Obtener las cinco reservas de mayor valor.
- Contar reservas.
- Calcular promedio, mínimo y máximo.
- Agrupar reservas por estado.
- Relacionar usuarios, recursos y reservas.
- Utilizar `WHERE`, `ORDER BY` y `LIMIT`.
- Crear reportes mediante alias.
- Analizar la demanda de recursos.
- Identificar usuarios con mayor gasto.
- Analizar el estado financiero de las reservas.

## Estructura
resoluciones/
└── joseluis-herrera/
    └── ejercicio-29/
        ├── README.md
        ├── diagramas/
        │   └── README.md
        ├── ddl/
        │   └── schema.sql
        ├── dml/
        │   ├── inserts.sql
        │   └── operaciones.sql
        └── dql/
            └── consultas.sql