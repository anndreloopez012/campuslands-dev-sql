# Evidencias - Ejercicio 82

## Tema

SELECT

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-82.db < ddl/schema.sql
sqlite3 ejercicio-82.db < dml/inserts.sql
sqlite3 ejercicio-82.db < dql/consultas.sql
```

## Resultados

**Caso comentado verificado:**

- `SELECT COUN(*) FROM libros;` → `no such function: COUN` (funcion mal escrita, la correcta es `COUNT`).

**5. Reporte final del caso de negocio (nivel aplicado): disponibilidad
real de cada libro:**

```text
titulo                                              ejemplares_totales   ejemplares_disponibles   estado_disponibilidad
Clean Architecture                                    1                     0                          agotado
Clean Code                                            2                     1                          disponible
Patterns of Enterprise Application Architecture       2                     1                          disponible
Refactoring                                           3                     2                          disponible
The Art of Computer Programming Vol. 1                1                     0                          agotado
```

Verificacion manual: Clean Architecture tiene 1 ejemplar total y 1
prestamo activo (Fernanda Lopez) => 0 disponibles => agotado. The Art
of Computer Programming tiene 1 ejemplar total y 1 prestamo activo
(Jorge Cifuentes) => 0 disponibles => agotado. Los otros tres libros
tienen al menos 1 ejemplar disponible.

## Aprendizaje

La subconsulta correlacionada (`SELECT COUNT(*) FROM prestamos p
WHERE p.id_libro = l.id_libro AND p.fecha_devolucion IS NULL`) se
vuelve a ejecutar una vez por cada fila de `libros`, usando el
`id_libro` de esa fila especifica: es distinta de la subconsulta del
nivel intermedio, que se calculaba una sola vez para toda la
consulta. Combinada con `CASE WHEN`, permite traducir un numero
(ejemplares disponibles) en una palabra legible
(`'disponible'`/`'agotado'`), que es justo el tipo de reporte final
que un negocio real necesita para tomar una decision (por ejemplo,
cuales libros comprar mas ejemplares). El caso comentado recuerda que
un typo en el nombre de una funcion (`COUN` en vez de `COUNT`) tambien
hace fallar un `SELECT`.
