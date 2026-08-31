# Evidencias - Ejercicio 78

## Tema

DELETE

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-78.db < ddl/schema.sql
sqlite3 ejercicio-78.db < dml/inserts.sql
sqlite3 ejercicio-78.db < dql/consultas.sql
```

## Resultados

Estado final tras `dml/inserts.sql` (7 inscripciones iniciales, 1
duplicado y 3 canceladas eliminadas):

```text
id_inscripcion | id_camper | id_ruta | estado
1                | 1           | 1          | activa
2                | 2           | 1          | activa
6                | 5           | 3          | activa
```

```text
rutas:
id_ruta | nombre_ruta        | cupo_maximo | activa
1        | Cumbre Extrema       | 10             | 0
2        | Sendero del Canon    | 10             | 1
3        | Ruta del Volcan      | 10             | 1
```

**Caso comentado verificado:**

- `DELETE FROM rutas WHERE id_ruta = 1;` → `FOREIGN KEY constraint failed` (Cumbre Extrema todavia tiene 2 inscripciones activas).

**5. Validacion especifica de DELETE:**

```text
5a. canceladas_restantes: 0 -- el DELETE multiple elimino las 3 de un solo golpe.
5b. total_restante: 3 -- empezaron 7, se borro 1 duplicado y 3 canceladas.
```

## Aprendizaje

`DELETE` con `WHERE` por id especifico elimina exactamente una fila
(la copia duplicada de Mario Ixtabalan), mientras que `DELETE` con
`WHERE estado = 'cancelada'` elimina todas las filas que cumplen esa
condicion en una sola sentencia, sin importar cuantas sean ni en que
ruta esten: eso es lo que diferencia el nivel intermedio del basico.
Igual que con los productos del ejercicio anterior, `DELETE` no
siempre es la herramienta correcta para una tabla que todavia tiene
dependientes: cuando una ruta sigue teniendo inscripciones activas,
SQLite rechaza el `DELETE` fisico por `FOREIGN KEY`, y ahi es donde
conviene la baja logica (`UPDATE activa = 0`) para dar de baja la
ruta sin perder el historial de quien esta inscrito en ella.
