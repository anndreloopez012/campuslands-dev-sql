# Evidencias - Ejercicio 64

## Tema

AUTO_INCREMENT

## Comandos ejecutados

No se conto con el binario `sqlite3` en el entorno de trabajo, por lo que
la ejecucion se valido con Python (`sqlite3`), aplicando los mismos
scripts en el mismo orden:

```bash
sqlite3 ejercicio-64.db < ddl/schema.sql
sqlite3 ejercicio-64.db < dml/inserts.sql
sqlite3 ejercicio-64.db < dql/consultas.sql
```

## Resultados

Conteo final de datos:

```text
autores -> 3
libros -> 6
prestamos -> 6
```

Caso que debe fallar (comentado en `dml/inserts.sql`):

```text
INSERT INTO prestamos (id_libro, prestatario) VALUES (999, 'Ingrid Say');
Fallo como se esperaba: FOREIGN KEY constraint failed
```

Consulta 5 (validacion especifica de AUTO_INCREMENT):

```text
5a. prestamos finales en orden
(1, 'Manuel Estrada')
(2, 'Alejandra Chinchilla')
(4, 'Cristina Barrios')
(5, 'Douglas Pineda')
(6, 'Manuel Estrada')
(7, 'Byron Xicay')          -- ultimo prestamo, recibio comprobante 7

5b. buscar id_prestamo = 3 (anulado antes)
(sin filas)                 -- confirma que AUTOINCREMENT no reutilizo el comprobante 3
```

Consulta 6 (decision de negocio: libro con mas prestamos historicos):

```text
libro          total_prestamos
Clean Code      2
```

## Aprendizaje

`INTEGER PRIMARY KEY AUTOINCREMENT` es especialmente util cuando el id
funciona como un numero de comprobante o referencia externa, como el
`id_prestamo` de esta biblioteca: garantiza que un comprobante anulado
nunca se reasigne a un prestamo distinto, evitando confusion en el
historial. Ademas, combinar `AUTO_INCREMENT` con `JOIN` y `GROUP BY`
permite generar reportes de negocio confiables, como identificar el
libro con mas demanda para decidir si conviene comprar mas ejemplares.
