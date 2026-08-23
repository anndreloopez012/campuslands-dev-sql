# Evidencias - Solicitudes SQL - Ejercicio 010 (Biblioteca Sci-Fi)

## Comandos ejecutados

```bash
sqlite3 ejercicio-010.db < ddl/schema.sql
sqlite3 ejercicio-010.db < dml/inserts.sql
sqlite3 ejercicio-010.db < dml/operaciones.sql
sqlite3 ejercicio-010.db < dql/consultas.sql
```

## Resultados

**1. Todos los prestamos (ya con la entrada de prueba eliminada y el prestamo de Karen Solis corregido):**

```text
id_prestamo | id_libro | nombre_lector   | fecha_prestamo | fecha_devolucion | estado
1           | 1        | Ana Gomez        | 2026-07-01      | None              | prestado
2           | 2        | Luis Marroquin   | 2026-07-02      | 2026-07-16        | devuelto
3           | 3        | Karen Solis      | 2026-07-05      | 2026-08-01        | devuelto
4           | 1        | Diego Paz        | 2026-07-10      | None              | prestado
5           | 4        | Rosa Chavez      | 2026-07-12      | 2026-07-20        | devuelto
6           | 5        | Julio Perez      | 2026-07-15      | None              | perdido
7           | 6        | Ana Gomez        | 2026-07-18      | None              | prestado
8           | 2        | Karen Solis      | 2026-07-20      | None              | prestado
9           | 3        | Ana Gomez        | 2026-07-22      | None              | prestado
```

Quedan 9 prestamos (empezaron 10, se elimino la entrada de prueba del `id_prestamo = 10`).

**2. Prestamos que no estan devueltos todavia:**

```text
id_prestamo | id_libro | nombre_lector | fecha_prestamo | estado
1           | 1        | Ana Gomez      | 2026-07-01      | prestado
4           | 1        | Diego Paz      | 2026-07-10      | prestado
6           | 5        | Julio Perez    | 2026-07-15      | perdido
7           | 6        | Ana Gomez      | 2026-07-18      | prestado
8           | 2        | Karen Solis    | 2026-07-20      | prestado
9           | 3        | Ana Gomez      | 2026-07-22      | prestado
```

El prestamo de Karen Solis (id 3) ya no aparece aqui porque `operaciones.sql` lo corrigio de `atrasado` a `devuelto`.

**3. Lector con mas prestamos:**

```text
nombre_lector    | total_prestamos
Ana Gomez          | 3
Karen Solis         | 2
Rosa Chavez         | 1
Luis Marroquin      | 1
Julio Perez         | 1
Diego Paz           | 1
```

**4. Prestamos ordenados por fecha:** ver tabla completa arriba, de 2026-07-01 a 2026-07-22.

**5. Libros mas prestados historicamente:**

```text
titulo         | autor            | veces_prestado
Dune             | Frank Herbert     | 2
Fundacion        | Isaac Asimov      | 2
Neuromante       | William Gibson    | 2
El Marciano      | Andy Weir         | 1
Un Mundo Feliz   | Aldous Huxley     | 1
Snow Crash       | Neal Stephenson   | 1
```

**Caso comentado verificado** (descomentado y ejecutado por separado para confirmar que falla):

- `INSERT INTO libros (titulo, autor, anio_publicacion) VALUES ('Futuro Imposible', 'Autor X', 3050);` → `CHECK constraint failed: anio_publicacion BETWEEN 1800 AND 2030`.

## Operaciones de mantenimiento verificadas

- `UPDATE prestamos SET estado = 'devuelto', fecha_devolucion = '2026-08-01' WHERE id_prestamo = 3 AND estado = 'atrasado';` → el prestamo de Karen Solis paso de `atrasado` a `devuelto`, con su fecha real de devolucion.
- `UPDATE libros SET copias_disponibles = copias_disponibles - 1 WHERE id_libro = 5;` → `Un Mundo Feliz` bajo de 1 a 0 copias disponibles (la copia perdida ya no cuenta como disponible).
- `DELETE FROM prestamos WHERE id_prestamo = 10;` → la entrada de prueba desaparecio; el conteo final de prestamos es 9, no 10.

## Aprendizaje

Las tres formas de "error" que preocupaban al cliente se cubren con herramientas distintas de SQL: `FOREIGN KEY` en `prestamos.id_libro` impide una **relacion invalida** (prestar un libro que no existe en el catalogo); `CHECK (anio_publicacion BETWEEN 1800 AND 2030)` detecta un **valor fuera de rango** (el caso comentado con año 3050 lo prueba); y `UNIQUE` en `libros.titulo` impide un **registro repetido** (cargar el mismo libro dos veces). Ninguna de estas tres reglas depende de que el usuario revise manualmente los datos: SQLite las hace cumplir automaticamente en cada `INSERT`, que es exactamente lo que el cliente pidio.
