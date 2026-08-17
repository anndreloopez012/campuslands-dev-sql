# Ejercicio 13: Banco Cuentas

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-06

## Descripcion del problema

El banco necesita reemplazar el registro manual de clientes, cuentas, transacciones y tarjetas por una base de datos relacional que evite duplicidad y permita controlar los movimientos y saldos de cada cuenta.

## Tablas y relaciones

- `clientes`: catalogo de clientes (nombre, dpi, correo).
- `cuentas`: cuenta bancaria de un cliente (numero de cuenta, tipo, saldo). `clientes` 1—N `cuentas`.
- `transacciones`: movimiento realizado sobre una cuenta (deposito, retiro, transferencia). `cuentas` 1—N `transacciones`.
- `tarjetas`: tarjeta asociada a una cuenta. `cuentas` 1—N `tarjetas`.

## Restricciones aplicadas

- `PRIMARY KEY` autoincremental en las 4 tablas.
- `FOREIGN KEY`: `cuentas.id_cliente`, `transacciones.id_cuenta`, `tarjetas.id_cuenta`.
- `NOT NULL` en todos los campos obligatorios.
- `UNIQUE`: `clientes.dpi`, `clientes.correo`, `cuentas.numero_cuenta`, `tarjetas.numero_tarjeta`.
- `CHECK`: `cuentas.tipo IN (...)`, `cuentas.saldo >= 0`, `transacciones.tipo IN (...)`, `transacciones.monto > 0`, `tarjetas.tipo IN (...)`.

## Evidencias de ejecucion

Scripts validados en orden (`ddl` -> `inserts` -> `operaciones` -> `consultas`) con SQLite:

- 6 clientes, 5 cuentas, 4 tarjetas y 10 transacciones tras aplicar `operaciones.sql`.
- Las 2 operaciones comentadas en `dml/operaciones.sql` fallan al ejecutarlas: una por `UNIQUE (cuentas.numero_cuenta)` y otra por `CHECK (transacciones.monto > 0)`.
- Consulta de decision de negocio (cliente con mayor monto total transaccionado): `Cristina Barrios` con 2200.00.

## Como ejecutar

```bash
sqlite3 ejercicio-13.db < ddl/schema.sql
sqlite3 ejercicio-13.db < dml/inserts.sql
sqlite3 ejercicio-13.db < dml/operaciones.sql
sqlite3 ejercicio-13.db < dql/consultas.sql
```
