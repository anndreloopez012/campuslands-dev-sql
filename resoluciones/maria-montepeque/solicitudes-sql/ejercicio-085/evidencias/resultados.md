# Evidencias - Solicitudes SQL - Ejercicio 085 (Biblioteca Sci-Fi)

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-085.db < ddl/schema.sql
sqlite3 ejercicio-085.db < dml/inserts.sql
sqlite3 ejercicio-085.db < dml/operaciones.sql
sqlite3 ejercicio-085.db < dql/consultas.sql
```

## Resultados

Datos base tras `dml/inserts.sql`: 4 autores, 5 libros, 5 lectores, 6
prestamos y 4 devoluciones (incluye la cargada por error en el
prestamo equivocado).

**Caso comentado verificado:**

- `INSERT INTO devoluciones (id_prestamo, ...) VALUES (1, ...);` (segunda devolucion para el prestamo 1) → `UNIQUE constraint failed: devoluciones.id_prestamo`.

**1. Resumen completo via `vista_resumen_prestamos` (ya con la
devolucion erronea eliminada y el prestamo 4 marcado atrasado):**

```text
id_prestamo | nombre_lector    | titulo       | nombre_autor    | fecha_prestamo | fecha_devolucion_esperada | estado    | fecha_devolucion_real | estado_libro
1            | Karla Rivas       | Dune           | Frank Herbert     | 2026-08-01        | 2026-08-15                   | devuelto     | 2026-08-14                | bueno
2            | Bryan Solis       | Fundacion      | Isaac Asimov      | 2026-08-02        | 2026-08-16                   | prestado     | (NULL)                     | (NULL)
3            | Fernanda Lopez    | Dune           | Frank Herbert     | 2026-08-03        | 2026-08-17                   | devuelto     | 2026-08-16                | bueno
4            | Jorge Cifuentes   | 1984           | George Orwell     | 2026-08-04        | 2026-08-18                   | atrasado     | (NULL)                     | (NULL)
5            | Karla Rivas       | Neuromante     | William Gibson    | 2026-08-05        | 2026-08-19                   | prestado     | (NULL)                     | (NULL)
6            | Priscila Ajanel   | Yo, Robot      | Isaac Asimov      | 2026-08-06        | 2026-08-20                   | devuelto     | 2026-08-19                | danado
```

**5. Autor con mas prestamos en total (para decidir de cual comprar
mas ejemplares):**

```text
nombre_autor       total_prestamos
Frank Herbert         2
Isaac Asimov           2
George Orwell           1
William Gibson          1
```

## Operaciones de mantenimiento verificadas

- **DELETE controlado**: se elimino la devolucion cargada por error en el prestamo 2. Total de devoluciones: 4 -> 3. El prestamo 2 sigue correctamente `prestado`.
- `UPDATE prestamos SET estado = 'atrasado' WHERE id_prestamo = 4 ...;` → el prestamo de Jorge Cifuentes paso su fecha esperada sin devolucion.

## Aprendizaje

Separar `devoluciones` de `prestamos` (decision documentada en el
analisis) permitio registrar el estado fisico real del libro al
devolverse, ademas de proteger con `UNIQUE (id_prestamo)` contra el
error de registrar la misma devolucion dos veces (como paso con el
prestamo 2, corregido con `DELETE`). La vista `vista_resumen_prestamos`,
con `LEFT JOIN` a devoluciones, muestra tanto los prestamos activos
como los ya devueltos en un solo reporte, sin necesitar dos consultas
separadas.
