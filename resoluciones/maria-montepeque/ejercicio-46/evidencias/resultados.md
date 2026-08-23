# Evidencias - Ejercicio 46

## Tema

PRIMARY KEY

## Comandos ejecutados

```bash
sqlite3 ejercicio-46.db < ddl/schema.sql
sqlite3 ejercicio-46.db < dml/inserts.sql
sqlite3 ejercicio-46.db < dql/consultas.sql
```

## Resultados

**4. Resumen:**

```text
total_prestamos | prestamos_activos | libros_distintos_prestados
11              | 5                  | 5
```

**5.a Prestamos de "Clean Code" (`id_libro = 1`), distinguidos por su PRIMARY KEY `id_prestamo` aunque se repita el prestatario:**

```text
id_prestamo | prestatario    | fecha_prestamo | fecha_devolucion
1           | Diego Morales  | 2026-06-01      | 2026-06-10
2           | Valeria Cruz   | 2026-06-12      | 2026-06-20
3           | Diego Morales  | 2026-07-01      | (activo, sin devolver)
```

**5.b Combinaciones repetidas de libro + prestatario (confirmando que no generan conflicto de llave):**

```text
id_libro | prestatario    | veces
1        | Diego Morales  | 2
```

**Reporte final: libro mas prestado, por autor:**

```text
libro                                   | autor            | veces_prestado
Clean Code                              | Robert Martin    | 3
Design Patterns                         | Erich Gamma      | 2
Manual interno de Java (fotocopiado)    | Kathy Sierra     | 2
Refactoring                             | Martin Fowler    | 2
The Pragmatic Programmer                | Andrew Hunt      | 2
```

**Casos comentados verificados** (descomentados y ejecutados por separado para confirmar que fallan):

- `INSERT INTO autores (id_autor, nombre) VALUES (1, ...);` (ya existe) → `UNIQUE constraint failed: autores.id_autor`.
- `DELETE FROM autores WHERE id_autor = 1;` (referenciado por "Clean Code" en `libros`) → `FOREIGN KEY constraint failed`.

## Aprendizaje

Este ejercicio cierra la serie de PRIMARY KEY mostrando su doble funcion: por un lado, identificar cada fila de forma unica incluso cuando el resto de sus datos se repite (el mismo libro prestado dos veces a la misma persona); por otro, sostener la integridad de las relaciones ya creadas, al punto de impedir que se borre una fila mientras otra la siga referenciando. La `PRIMARY KEY` no es solo "un numero unico por fila": es el mecanismo que hace posible que el resto del modelo relacional (las `FOREIGN KEY`) funcione de forma confiable.
