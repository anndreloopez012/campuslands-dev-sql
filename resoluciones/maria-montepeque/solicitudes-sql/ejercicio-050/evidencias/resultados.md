# Evidencias - Solicitudes SQL - Ejercicio 050 (Track Day Hiperdeportivos)

## Comandos ejecutados

```bash
sqlite3 ejercicio-050.db < ddl/schema.sql
sqlite3 ejercicio-050.db < dml/inserts.sql
sqlite3 ejercicio-050.db < dml/operaciones.sql
sqlite3 ejercicio-050.db < dql/consultas.sql
```

## Resultados

**1. Todos los tiempos, con JOIN triple a pilotos, vehiculos y sesiones (ya sin el duplicado, sin el registro vacio, con el tiempo 8 corregido y el tiempo 10 descalificado):**

```text
id_tiempo | nombre_piloto    | modelo          | numero_sesion | vuelta | tiempo_segundos | estado
1          | Andrea Solares   | GT-Fenix X1      | 1              | 1       | 88.452           | valido
2          | Diego Palma      | Velaria RS       | 1              | 1       | 85.12            | valido
3          | Renata Ixchel    | Nimbus GTR       | 1              | 1       | 90.334           | valido
4          | Andrea Solares   | GT-Fenix X1      | 1              | 2       | 87.998           | valido
5          | Carlos Mota      | Aureon Spyder    | 2              | 1       | 86.775           | valido
6          | Diego Palma      | Velaria RS       | 2              | 1       | 84.56            | valido
7          | Valentina Roca   | Kessler V12      | 2              | 1       | 83.91            | valido
8          | Andrea Solares   | GT-Fenix X1      | 2              | 2       | 86.05            | valido
10         | Carlos Mota      | Aureon Spyder    | 3              | 1       | 89.1             | descalificado
```

Quedan 9 tiempos (empezaron 11: se elimino el duplicado `id_tiempo = 11` y el registro vacio `id_tiempo = 9`).

**2. Tiempos que no estan validos todavia:**

```text
id_tiempo | id_piloto | id_sesion | vuelta | estado
10         | 4          | 3          | 1       | descalificado
```

**3. Piloto con mas vueltas registradas:**

```text
nombre_piloto    | total_vueltas
Andrea Solares   | 3
Carlos Mota      | 2
Diego Palma      | 2
Renata Ixchel    | 1
Valentina Roca   | 1
```

**4. Tiempos ordenados de menor a mayor (el mas rapido primero):** ver tabla completa arriba, de 83.91s a 90.334s.

**5. Mejor tiempo de cada piloto (solo vueltas validas), para armar el ranking del dia:**

```text
nombre_piloto    | mejor_tiempo
Valentina Roca   | 83.91
Diego Palma      | 84.56
Andrea Solares   | 86.05
Carlos Mota      | 86.775
Renata Ixchel    | 90.334
```

Valentina Roca tiene el mejor tiempo del dia. El tiempo descalificado de Carlos Mota (89.1) no cuenta para este ranking, pero su mejor vuelta valida (86.775) si.

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que cada uno falla, uno por cada tipo de error que pidio detectar el cliente):

- Registro repetido: `INSERT INTO pilotos (nombre_piloto, licencia) VALUES ('Otro Piloto', 'LIC-4471');` → `UNIQUE constraint failed: pilotos.licencia`.
- Relacion invalida: `INSERT INTO tiempos (id_piloto, ...) VALUES (99, ...);` → `FOREIGN KEY constraint failed`.
- Valor fuera de rango: `INSERT INTO tiempos (..., tiempo_segundos) VALUES (..., -5.0);` → `CHECK constraint failed: tiempo_segundos >= 0`.

## Operaciones de mantenimiento verificadas

- `UPDATE tiempos SET estado = 'descalificado' WHERE id_tiempo = 10 AND estado = 'valido';` → el tiempo de Carlos Mota se descalifico tras confirmar un corte de pista; el valor (89.1) se conservo como evidencia.
- `UPDATE tiempos SET tiempo_segundos = 86.050 WHERE id_tiempo = 8;` → se corrigio el cronometraje de Andrea Solares (de 86.200 a 86.050).
- `DELETE FROM tiempos WHERE id_tiempo = 9 AND estado = 'invalido' AND tiempo_segundos = 0;` → **DELETE controlado**: elimino unicamente el registro vacio de Renata Ixchel (vuelta no completada). Ningun tiempo invalido con un valor real hubiera cumplido esta condicion.
- `DELETE FROM tiempos WHERE id_tiempo = 11;` → el tiempo duplicado desaparecio. Conteo final verificado: 9 tiempos (empezaron 11).

## Aprendizaje

Los tres errores que preocupaban al cliente (repetidos, relaciones invalidas, valores fuera de rango) se bloquean en el momento del `INSERT`, no se descubren despues en un reporte. El `DELETE` controlado agrega una cuarta capa de seguridad: incluso un registro que "paso" todas las validaciones (como el tiempo vacio en 0) solo se puede borrar si cumple una condicion de negocio explicita, nunca por accidente.
