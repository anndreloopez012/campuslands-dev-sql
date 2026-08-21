# Ejercicio 46: PRIMARY KEY Nivel Aplicado

**Nombre:** Maria Jose Montepeque
**Fecha:** 2026-08-17

## Tema central

PRIMARY KEY

## Descripcion del problema

Sistema de prestamos de libros tecnicos de una biblioteca: `autores`, `libros` y `prestamos`. Nivel aplicado: cierra la serie de PRIMARY KEY (44 basico, 45 intermedio) con un caso de negocio completo — el mismo libro se presta varias veces en el tiempo, incluso al mismo prestatario — y un reporte final que se apoya en las llaves primarias para no perder ni confundir ningun registro.

## Tablas y relaciones

- `autores`: catalogo de autores (PRIMARY KEY subrogada).
- `libros`: catalogo de libros, con `isbn` como `UNIQUE` (no `PRIMARY KEY`, porque puede faltar en material interno sin ISBN). `autores` 1—N `libros`.
- `prestamos`: cada evento de prestamo, con su propia `PRIMARY KEY` (`id_prestamo`). `libros` 1—N `prestamos`.

## Que aprendi sobre PRIMARY KEY

- **La PRIMARY KEY identifica el EVENTO, no la combinacion de datos**: "Clean Code" (`id_libro = 1`) se presto 3 veces, dos de ellas a "Diego Morales". Sin una `PRIMARY KEY` propia en `prestamos`, esas dos filas identicas en `id_libro` y `prestatario` serian indistinguibles. Con `id_prestamo` como `PRIMARY KEY`, cada evento queda perfectamente identificado aunque el resto de los datos se repita (verificado en la consulta 5.a y con el `GROUP BY ... HAVING COUNT(*) > 1` de la consulta 5.b, que confirma la combinacion repetida sin que eso genere ningun conflicto de llave).
- **Una PRIMARY KEY referenciada no se puede eliminar mientras exista la referencia**: intentar `DELETE FROM autores WHERE id_autor = 1` falla con `FOREIGN KEY constraint failed`, porque el libro "Clean Code" todavia apunta a ese autor. Esto demuestra que la `PRIMARY KEY` no solo evita duplicados al insertar: tambien protege la integridad de los datos ya relacionados al intentar borrar.
- **Cuando un dato natural puede faltar, no puede ser PRIMARY KEY**: `isbn` se dejo como `UNIQUE` en vez de `PRIMARY KEY` porque un manual interno fotocopiado puede no tener ISBN (`NULL`), y una `PRIMARY KEY` nunca puede ser `NULL`.
- Confirme con el reporte final que las uniones entre `prestamos`, `libros` y `autores` (todas apoyadas en `PRIMARY KEY`/`FOREIGN KEY`) dan resultados correctos y sin duplicados: "Clean Code" es el libro mas prestado, con 3 prestamos.

## Como ejecutar

```bash
sqlite3 ejercicio-46.db < ddl/schema.sql
sqlite3 ejercicio-46.db < dml/inserts.sql
sqlite3 ejercicio-46.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.
