# Evidencias - Solicitudes SQL - Ejercicio 035 (Biblioteca Sci-Fi)

## Comandos ejecutados

```bash
sqlite3 ejercicio-035.db < ddl/schema.sql
sqlite3 ejercicio-035.db < dml/inserts.sql
sqlite3 ejercicio-035.db < dml/operaciones.sql
sqlite3 ejercicio-035.db < dql/consultas.sql
```

## Resultados

**1. Todos los prestamos, con JOIN doble a lectores y libros (ya sin el duplicado y con Neuromante marcado como atrasado):**

```text
id_prestamo | nombre_lector    | titulo         | fecha_prestamo | fecha_devolucion_esperada | estado
1           | Karla Rivas      | Dune           | 2026-08-01     | 2026-08-15                 | devuelto
2           | Bryan Solis      | Neuromante     | 2026-08-03     | 2026-08-17                 | atrasado
3           | Fernanda Lopez   | 1984           | 2026-07-20     | 2026-08-03                 | atrasado
4           | Karla Rivas      | El Marciano    | 2026-08-05     | 2026-08-19                 | prestado
5           | Jorge Cifuentes  | Fundacion      | 2026-08-10     | 2026-08-31                 | prestado
6           | Melissa Ortiz    | Un Mundo Feliz | 2026-07-15     | 2026-07-29                 | perdido
7           | Bryan Solis      | Snow Crash     | 2026-08-08     | 2026-08-22                 | prestado
8           | Karla Rivas      | Hyperion       | 2026-08-12     | 2026-08-26                 | prestado
9           | Fernanda Lopez   | Dune           | 2026-08-14     | 2026-08-28                 | prestado
```

Quedan 9 prestamos (empezaron 10, se elimino el duplicado del `id_prestamo = 10`).

**2. Prestamos que no estan devueltos todavia:**

```text
id_prestamo | id_libro | id_lector | fecha_devolucion_esperada | estado
2           | 3        | 2         | 2026-08-17                 | atrasado
3           | 5        | 3         | 2026-08-03                 | atrasado
4           | 7        | 1         | 2026-08-19                 | prestado
5           | 2        | 4         | 2026-08-31                 | prestado
6           | 6        | 5         | 2026-07-29                 | perdido
7           | 4        | 2         | 2026-08-22                 | prestado
8           | 8        | 1         | 2026-08-26                 | prestado
9           | 1        | 3         | 2026-08-28                 | prestado
```

**3. Lector con mas prestamos en total:**

```text
nombre_lector    | total_prestamos
Karla Rivas      | 3
Bryan Solis      | 2
Fernanda Lopez   | 2
Jorge Cifuentes  | 1
Melissa Ortiz    | 1
```

**4. Prestamos ordenados por fecha de prestamo:** ver tabla completa arriba, de 2026-07-15 a 2026-08-14.

**5. Lectores con libros atrasados o perdidos, para decidir a quien contactar esta semana (ordenado por que tan viejo es el atraso):**

```text
nombre_lector    | titulo         | fecha_devolucion_esperada | estado
Melissa Ortiz    | Un Mundo Feliz | 2026-07-29                 | perdido
Fernanda Lopez   | 1984           | 2026-08-03                 | atrasado
Bryan Solis      | Neuromante     | 2026-08-17                 | atrasado
```

Con este reporte la biblioteca sabe que a Melissa Ortiz hay que contactarla primero (su libro esta reportado como `perdido` desde el 2026-07-29), seguida de Fernanda Lopez y Bryan Solis por sus atrasos.

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO prestamos (..., fecha_prestamo, fecha_devolucion_esperada) VALUES (..., '2026-08-20', '2026-08-10');` → `CHECK constraint failed: fecha_devolucion_esperada > fecha_prestamo`.

## Operaciones de mantenimiento verificadas

- `UPDATE prestamos SET estado = 'atrasado' WHERE id_prestamo = 2 AND estado = 'prestado';` → el prestamo de Neuromante a Bryan Solis paso de `prestado` a `atrasado`.
- `UPDATE prestamos SET fecha_devolucion_esperada = '2026-08-31' WHERE id_prestamo = 5;` → la fecha de devolucion de Fundacion (Jorge Cifuentes) se extendio de 2026-08-24 a 2026-08-31 por renovacion.
- `DELETE FROM prestamos WHERE id_prestamo = 10;` → el prestamo duplicado desaparecio; el conteo final es 9, no 10.

## Aprendizaje

Con `lectores` como tabla real (no como texto dentro del prestamo), el conteo de "lector con mas prestamos" (consulta 3) y el reporte de atrasos (consulta 5) quedan protegidos contra el problema que le importa a la biblioteca: si "Karla Rivas" se escribiera con una variacion minima en un prestamo, el reporte la contaria como una persona distinta y su historial de atrasos quedaria incompleto. La `FOREIGN KEY` obliga a que cada prestamo apunte siempre al mismo `id_lector`, garantizando que el reporte semanal de devoluciones sea confiable.
