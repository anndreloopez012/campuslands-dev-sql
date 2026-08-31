# Evidencias - Ejercicio 80

## Tema

SELECT

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-80.db < ddl/schema.sql
sqlite3 ejercicio-80.db < dml/inserts.sql
sqlite3 ejercicio-80.db < dql/consultas.sql
```

## Resultados

**1. Todos los campers, con alias de columnas y edad calculada:**

```text
camper             nivel_experiencia   edad_aproximada
Karen Solis          avanzado              26
Mario Ixtabalan      intermedio            23
Ana Gomez            principiante          20
Luis Marroquin       avanzado              28
Rosa Chavez          intermedio            24
```

**2. Campers de nivel avanzado:**

```text
nombre           nivel
Karen Solis        avanzado
Luis Marroquin     avanzado
```

**3. Rutas ordenadas por costo de inscripcion:**

```text
nombre_ruta          costo_inscripcion
Sendero del Canon      120.00
Cumbre Extrema          250.00
Ruta del Volcan         300.00
```

**4. Resumen: campers por nivel:**

```text
nivel           total
avanzado          2
intermedio        2
principiante      1
```

**5. Reporte legible con JOIN, alias y expresion calculada (costo con
10% de descuento):**

```text
camper             ruta                costo_normal   costo_con_descuento
Ana Gomez            Sendero del Canon    120.0            108.0
Karen Solis          Cumbre Extrema       250.0            225.0
Luis Marroquin       Ruta del Volcan      300.0            270.0
Mario Ixtabalan      Cumbre Extrema       250.0            225.0
Rosa Chavez          Ruta del Volcan      300.0            270.0
```

**Caso comentado verificado:**

- `SELECT nombre, apellido FROM campers;` → `no such column: apellido` (la tabla `campers` no tiene esa columna).

## Aprendizaje

`SELECT` no solo trae datos, tambien los presenta de forma legible:
un alias (`AS`) le da a una columna un nombre mas claro que el nombre
tecnico de la tabla, y una expresion calculada (como la edad a partir
de `fecha_nacimiento`, o el costo con descuento) permite mostrar un
dato util que no esta guardado directamente en ninguna columna. Al
combinar columnas de varias tablas con `JOIN`, esos mismos alias y
expresiones ayudan a que el resultado final se lea como un reporte,
no como una tabla cruda. El caso comentado recuerda que `SELECT`
tambien puede fallar por errores simples, como escribir mal el nombre
de una columna.
