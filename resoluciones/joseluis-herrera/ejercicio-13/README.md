# Ejercicio 13: Banco Cuentas

## Información

- Nombre: Jose Luis Herrera
- Fecha: 2026-08-20
- Motor: SQLite
- Ejercicio: 13
- Contexto: Banco digital

## Descripción

La organización necesita reemplazar el manejo manual de clientes, cuentas, transacciones y tarjetas por una base de datos relacional que permita controlar saldos, registrar movimientos y generar reportes sobre la actividad financiera de las cuentas.

## Modelo implementado

La solución utiliza cuatro tablas:

- `clientes`: almacena la información de los clientes.
- `cuentas`: almacena las cuentas bancarias y sus saldos.
- `transacciones`: registra los movimientos realizados sobre las cuentas.
- `tarjetas`: almacena las tarjetas asociadas a las cuentas.

## Relaciones

```text
CLIENTES 1 ──────── N CUENTAS
CUENTAS  1 ──────── N TARJETAS
CUENTAS  1 ──────── N TRANSACCIONES
```

## Restricciones

- Todas las tablas utilizan `PRIMARY KEY`.
- Las relaciones utilizan `FOREIGN KEY`.
- Los campos obligatorios utilizan `NOT NULL`.
- Los correos de los clientes son únicos.
- Los números de cuenta son únicos.
- Los números de tarjeta son únicos.
- El tipo de cuenta solo permite `Ahorros` o `Corriente`.
- El saldo no puede ser negativo.
- El tipo de tarjeta solo permite `Debito` o `Credito`.
- El estado de una tarjeta solo permite `Activa`, `Bloqueada` o `Vencida`.
- El tipo de transacción solo permite `Deposito`, `Retiro` o `Transferencia`.
- Los montos de las transacciones deben ser mayores que cero.
- Las fechas utilizan formato ISO.
- Las claves foráneas están activadas mediante `PRAGMA foreign_keys = ON`.

## Datos registrados

```text
Clientes:        5
Cuentas:         5
Tarjetas:        5
Transacciones:  10
```

Las operaciones adicionales incluyen dos `INSERT`, dos `UPDATE` y dos `DELETE`. Las operaciones inválidas se mantienen comentadas para evitar que interrumpan la ejecución del script.

## Consultas implementadas

Se incluyen consultas para:

1. Listar las cuentas bancarias.
2. Mostrar número de cuenta y saldo.
3. Filtrar cuentas por saldo.
4. Ordenar cuentas por saldo.
5. Obtener las cinco cuentas con mayor actividad.
6. Contar transacciones.
7. Calcular promedio, mínimo y máximo de movimientos.
8. Agrupar transacciones por tipo.
9. Relacionar clientes y cuentas mediante `JOIN`.
10. Filtrar, ordenar y limitar transacciones.
11. Generar reportes con alias legibles.
12. Clasificar cuentas y generar una decisión basada en el flujo de movimientos.

## Ejecución

Desde la raíz de la solución:

```bash
sqlite3 ejercicio-13.db < ddl/schema.sql
sqlite3 ejercicio-13.db < dml/inserts.sql
sqlite3 ejercicio-13.db < dml/operaciones.sql
sqlite3 ejercicio-13.db < dql/consultas.sql
```

El archivo de base de datos generado durante la ejecución no debe incluirse en el repositorio.

## Estructura

```text
resoluciones/
└── joseluis-herrera/
    └── ejercicio-13/
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
```