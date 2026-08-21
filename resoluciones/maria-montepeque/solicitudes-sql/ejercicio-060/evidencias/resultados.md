# Evidencias - Solicitudes SQL - Ejercicio 060 (Biblioteca Sci-Fi)

## Comandos ejecutados

```bash
sqlite3 ejercicio-060.db < ddl/schema.sql
sqlite3 ejercicio-060.db < dml/inserts.sql
sqlite3 ejercicio-060.db < dml/operaciones.sql
sqlite3 ejercicio-060.db < dql/consultas.sql
```

## Resultados

**1. Todos los prestamos, con JOIN triple a lectores, libros y autores (ya sin el duplicado, con el prestamo 5 devuelto y el prestamo 2 atrasado):**

```text
id_prestamo | nombre_lector    | titulo            | nombre_autor         | fecha_prestamo | fecha_devolucion_esperada | estado
1            | Karla Rivas      | Dune               | Frank Herbert         | 2026-08-01       | 2026-08-15                  | devuelto
2            | Bryan Solis      | Fundacion          | Isaac Asimov          | 2026-08-02       | 2026-08-16                  | atrasado
3            | Fernanda Lopez   | Dune               | Frank Herbert         | 2026-08-03       | 2026-08-17                  | devuelto
4            | Jorge Cifuentes  | 1984               | George Orwell         | 2026-08-04       | 2026-08-18                  | atrasado
5            | Karla Rivas      | Neuromante         | William Gibson        | 2026-08-05       | 2026-08-19                  | devuelto
6            | Priscila Ajanel  | Los Desposeidos    | Ursula K. Le Guin     | 2026-08-06       | 2026-08-20                  | devuelto
7            | Bryan Solis      | Yo, Robot          | Isaac Asimov          | 2026-08-07       | 2026-08-21                  | prestado
8            | Fernanda Lopez   | Fundacion          | Isaac Asimov          | 2026-08-08       | 2026-08-22                  | perdido
9            | Jorge Cifuentes  | Conde Cero         | William Gibson        | 2026-08-09       | 2026-08-23                  | prestado
10           | Karla Rivas      | Fundacion          | Isaac Asimov          | 2026-08-10       | 2026-08-24                  | prestado
```

Quedan 10 prestamos (empezaron 11, se elimino el duplicado exacto `id_prestamo = 11`).

**2. Prestamos que no estan devueltos todavia:**

```text
id_prestamo | id_libro | id_lector | fecha_devolucion_esperada | estado
2            | 2         | 2          | 2026-08-16                  | atrasado
4            | 4         | 4          | 2026-08-18                  | atrasado
7            | 6         | 2          | 2026-08-21                  | prestado
8            | 2         | 3          | 2026-08-22                  | perdido
9            | 7         | 4          | 2026-08-23                  | prestado
10           | 2         | 1          | 2026-08-24                  | prestado
```

**3. Lector con mas prestamos:**

```text
nombre_lector    | total_prestamos
Karla Rivas       | 3
Bryan Solis       | 2
Fernanda Lopez    | 2
Jorge Cifuentes   | 2
Priscila Ajanel   | 1
```

**4. Prestamos ordenados por fecha:** ver tabla completa arriba, de 2026-08-01 a 2026-08-10.

**5. Autor con mas prestamos en total, para decidir de cual comprar mas ejemplares:**

```text
nombre_autor         | total_prestamos
Isaac Asimov          | 4
Frank Herbert         | 2
William Gibson        | 2
George Orwell         | 1
Ursula K. Le Guin     | 1
```

Isaac Asimov es el autor mas prestado de la biblioteca (entre Fundacion y Yo, Robot): es el candidato claro para comprar mas ejemplares.

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que cada uno falla, uno por cada tipo de error que pidio detectar el cliente):

- Registro repetido: `INSERT INTO autores (nombre_autor, ...) VALUES ('Frank Herbert', ...);` → `UNIQUE constraint failed: autores.nombre_autor`.
- Relacion invalida: `INSERT INTO prestamos (id_libro, id_lector, ...) VALUES (2, 99, ...);` → `FOREIGN KEY constraint failed`.
- Valor fuera de rango: `INSERT INTO prestamos (..., fecha_prestamo, fecha_devolucion_esperada) VALUES (..., '2026-08-20', '2026-08-10');` → `CHECK constraint failed: fecha_devolucion_esperada > fecha_prestamo`.

## Operaciones de mantenimiento verificadas

- `UPDATE prestamos SET estado = 'devuelto' WHERE id_prestamo = 5 AND estado = 'prestado';` → Karla Rivas devolvio Neuromante.
- `UPDATE prestamos SET estado = 'atrasado' WHERE id_prestamo = 2 AND estado = 'prestado';` → el prestamo de Fundacion a Bryan Solis paso a `atrasado`.
- **DELETE controlado (deteccion general de duplicados)**: la condicion compara cada fila contra el `MIN(id_prestamo)` de cualquier otra fila con el mismo libro, lector y fecha de prestamo. Solo elimino el prestamo 11 (copia exacta del prestamo 1); todos los demas prestamos son unicos y no cumplian la condicion, asi que no se tocaron. Conteo final verificado: 10 prestamos (empezaron 11).

## Aprendizaje

Los tres errores que preocupaban al cliente (repetidos, relaciones invalidas, valores fuera de rango) se bloquean desde el `INSERT` gracias a `UNIQUE`, `FOREIGN KEY` y `CHECK`. El `DELETE` controlado de este ejercicio va un paso mas alla: en vez de borrar un id fijo, usa una subconsulta correlacionada que detecta *cualquier* duplicado exacto y conserva siempre el primer registro real, sin arriesgar ningun prestamo legitimo.
