# Evidencias - Solicitudes SQL - Ejercicio 039 (Mecanica de Autos)

## Comandos ejecutados

```bash
sqlite3 ejercicio-039.db < ddl/schema.sql
sqlite3 ejercicio-039.db < dml/inserts.sql
sqlite3 ejercicio-039.db < dml/operaciones.sql
sqlite3 ejercicio-039.db < dql/consultas.sql
```

## Resultados

**1. Todos los diagnosticos, con JOIN triple a vehiculos y clientes (ya sin el duplicado, con la alineacion en reparacion y la revision de motor reparada):**

```text
id_diagnostico | nombre_cliente   | placa    | marca  | modelo  | fecha_diagnostico | descripcion                        | costo_reparacion | estado
1               | Walter Xitamul   | P123ABC  | Toyota | Corolla | 2026-08-01         | Cambio de frenos delanteros        | 450.0             | reparado
2               | Silvia Cabrera   | P456DEF  | Honda  | Civic   | 2026-08-03         | Falla en sistema electrico          | 900.0             | en_garantia
3               | Walter Xitamul   | P789GHI  | Toyota | Hilux   | 2026-08-04         | Revision de motor por ruido         | 1200.0            | reparado
4               | Oscar Ramos      | P321JKL  | Mazda  | 3       | 2026-08-06         | Cambio de bateria                   | 300.0             | reparado
5               | Walter Xitamul   | P123ABC  | Toyota | Corolla | 2026-08-08         | Alineacion y balanceo               | 250.0             | en_reparacion
6               | Ingrid Say       | P654MNO  | Nissan | Sentra  | 2026-08-10         | Fuga de aceite en carter            | 700.0             | en_garantia
7               | Silvia Cabrera   | P456DEF  | Honda  | Civic   | 2026-08-12         | Cambio de llanta por pinchazo       | 180.0             | reparado
8               | Manuel Estrada   | P987PQR  | Kia    | Rio     | 2026-08-14         | Diagnostico de aire acondicionado   | 500.0             | diagnosticado
9               | Walter Xitamul   | P789GHI  | Toyota | Hilux   | 2026-08-16         | Cambio de amortiguadores            | 1100.0            | en_garantia
```

Quedan 9 diagnosticos (empezaron 10, se elimino el duplicado del `id_diagnostico = 10`).

**2. Diagnosticos que no estan reparados todavia:**

```text
id_diagnostico | id_vehiculo | fecha_diagnostico | estado
2               | 2           | 2026-08-03         | en_garantia
5               | 1           | 2026-08-08         | en_reparacion
6               | 5           | 2026-08-10         | en_garantia
8               | 6           | 2026-08-14         | diagnosticado
9               | 3           | 2026-08-16         | en_garantia
```

**3. Cliente con mas diagnosticos registrados en el taller:**

```text
nombre_cliente   | total_diagnosticos
Walter Xitamul   | 4
Silvia Cabrera   | 2
Ingrid Say       | 1
Manuel Estrada   | 1
Oscar Ramos      | 1
```

Walter Xitamul lidera porque tiene dos vehiculos registrados (Corolla y Hilux), cada uno con su propio historial.

**4. Diagnosticos ordenados por fecha:** ver tabla completa arriba, de 2026-08-01 a 2026-08-16.

**5. Reparaciones actualmente en garantia, para saber cuales estan cubiertas si el cliente regresa:**

```text
nombre_cliente   | marca  | modelo | placa    | descripcion                  | garantia_meses | fecha_ultimo_cambio
Walter Xitamul   | Toyota | Hilux  | P789GHI  | Cambio de amortiguadores      | 12              | 2026-08-17
Ingrid Say       | Nissan | Sentra | P654MNO  | Fuga de aceite en carter      | 6               | 2026-08-11
Silvia Cabrera   | Honda  | Civic  | P456DEF  | Falla en sistema electrico    | 6               | 2026-08-05
```

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO diagnosticos (..., costo_reparacion, ...) VALUES (..., -50.00, ...);` → `CHECK constraint failed: costo_reparacion >= 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE diagnosticos SET estado = 'en_reparacion', fecha_ultimo_cambio = '2026-08-09' WHERE id_diagnostico = 5 AND estado = 'diagnosticado';` → la alineacion del Corolla de Walter Xitamul paso de `diagnosticado` a `en_reparacion`, con fecha registrada.
- `UPDATE diagnosticos SET estado = 'reparado', fecha_ultimo_cambio = '2026-08-18' WHERE id_diagnostico = 3 AND estado = 'en_reparacion';` → la revision de motor de la Hilux de Walter Xitamul quedo `reparado`, con fecha registrada.
- `DELETE FROM diagnosticos WHERE id_diagnostico = 10;` → el diagnostico duplicado desaparecio; el conteo final es 9, no 10. Este fue el unico `DELETE`, porque era un error de captura y no un dato real de auditoria.

## Aprendizaje

Guardar `fecha_ultimo_cambio` junto con `estado` es lo que le permite al taller responder la pregunta central de una auditoria ("que paso y cuando paso") sin reconstruir nada a mano: cada vez que un diagnostico avanza de estado, el `UPDATE` deja constancia de la fecha exacta. Reservar `DELETE` unicamente para errores de captura comprobados (como el duplicado) protege ese historico: ningun dato real de negocio se pierde.
