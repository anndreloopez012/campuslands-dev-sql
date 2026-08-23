# Analisis de Normalizacion - Ejercicio 37

## Tabla original

Archivo `datos/datos-sin-normalizar.csv`:

```text
id_prestamo,libro,autores,generos,usuario,prestamos,fechas_devolucion
1,Bases de Datos I,A. Torres|M. Ruiz,SQL|Academico,Juan Perez,Prestamo 1,2026-06-12
2,Python Practico,L. Cano,Programacion|Backend,Maria Lopez,Prestamo 2,2026-06-15
3,Bases de Datos I,A. Torres|M. Ruiz,SQL|Academico,Ana Diaz,Prestamo 3,2026-06-20
```

Es una tabla plana donde cada fila es un prestamo, pero el libro tiene dos atributos con multiples valores en la misma celda: `autores` y `generos`, cada uno separado por `|`. A diferencia de otros ejercicios de esta serie, aqui hay **dos** grupos repetidos independientes sobre la misma entidad (un libro puede tener varios autores y, por separado, varios generos), lo que exige relaciones N:M con tablas puente en vez de una simple tabla de detalle.

## Problemas detectados

- **Grupos repetidos (dos, independientes)**: `autores` contiene una lista de autores por libro, y `generos` contiene una lista de generos por libro; ninguna de las dos depende de la otra.
- **Datos duplicados**: "Bases de Datos I" aparece en las filas 1 y 3 repitiendo exactamente los mismos autores (`A. Torres|M. Ruiz`) y los mismos generos (`SQL|Academico`) cada vez que se presta.
- **Dependencias parciales**: si se usara como clave compuesta `(id_prestamo, autor)` o `(id_prestamo, genero)`, el resto de columnas (`libro`, `usuario`, `fechas_devolucion`) dependerian solo de `id_prestamo`, no de la clave completa.
- **Dependencias transitivas / relacion N:M mal representada**: un autor puede escribir varios libros y un libro puede tener varios autores (lo mismo para genero); esa relacion muchos-a-muchos no se puede representar con una simple columna de texto sin duplicar datos.
- **Anomalias de insercion**: no se puede registrar un autor o un genero nuevo en el catalogo si todavia no aparece en ningun prestamo, ni un libro nuevo sin inventar un prestamo ficticio.
- **Anomalias de actualizacion**: si el nombre de "A. Torres" cambiara, habria que corregirlo en todas las filas donde aparece junto con "Bases de Datos I".
- **Anomalias de eliminacion**: si se elimina la fila 2 (el unico prestamo de "Python Practico"), se pierde tambien la referencia al autor "L. Cano" y a los generos "Programacion"/"Backend", aunque en realidad siguen existiendo.

## Dependencias funcionales

```text
id_prestamo -> libro, usuario, fecha_devolucion
libro ->> autor        (multivaluada: un libro tiene varios autores)
libro ->> genero       (multivaluada: un libro tiene varios generos)
```

## Primera Forma Normal (1FN)

Se eliminaron los dos grupos repetidos por separado: cada par `(libro, autor)` paso a ser una fila propia, y cada par `(libro, genero)` tambien paso a ser una fila propia, en vez de listas dentro de una celda. Cada celda quedo con un unico valor atomico.

## Segunda Forma Normal (2FN)

Como `libro`, `usuario` y `fecha_devolucion` dependian solo de `id_prestamo` (no de la combinacion libro-autor ni libro-genero), y `autor`/`genero` son atributos multivaluados del libro (no del prestamo), se separaron en:

- `prestamos` (libro, usuario, fecha de devolucion), con clave `id_prestamo`.
- `libro_autor` (relacion N:M entre libro y autor), con clave compuesta `(id_libro, id_autor)`.
- `libro_genero` (relacion N:M entre libro y genero), con clave compuesta `(id_libro, id_genero)`.

## Tercera Forma Normal (3FN)

`libro`, `autor`, `genero` y `usuario` seguian siendo texto libre repetido en cada fila. Se separaron en catalogos propios:

- `libros` (titulo), referenciado desde `prestamos` y desde `libro_autor`/`libro_genero` por `id_libro`.
- `autores` (nombre), referenciado desde `libro_autor` por `id_autor`.
- `generos` (nombre), referenciado desde `libro_genero` por `id_genero`.
- `usuarios` (nombre), referenciado desde `prestamos` por `id_usuario`.

Con esto, la lista de autores y generos de un libro se registra una sola vez en las tablas puente, sin importar cuantas veces se preste ese libro.

## Modelo final

| Tabla | Llave primaria | Llaves foraneas | Proposito |
| --- | --- | --- | --- |
| `autores` | `id_autor` | - | Catalogo de autores. |
| `generos` | `id_genero` | - | Catalogo de generos. |
| `libros` | `id_libro` | - | Catalogo de libros. |
| `usuarios` | `id_usuario` | - | Catalogo de usuarios que piden prestamos. |
| `libro_autor` | `(id_libro, id_autor)` | `id_libro` -> `libros`, `id_autor` -> `autores` | Tabla puente: relacion N:M entre libros y autores. |
| `libro_genero` | `(id_libro, id_genero)` | `id_libro` -> `libros`, `id_genero` -> `generos` | Tabla puente: relacion N:M entre libros y generos. |
| `prestamos` | `id_prestamo` | `id_libro` -> `libros`, `id_usuario` -> `usuarios` | Detalle de cada prestamo de un libro a un usuario. |

## Justificacion

El modelo final elimina los dos grupos repetidos (1FN) separando `autores` y `generos` en filas independientes. Elimina las dependencias parciales (2FN) al reconocer que la relacion libro-autor y libro-genero no depende del prestamo, sino del libro, y sacarlas a sus propias tablas puente. Elimina las dependencias transitivas y el texto repetido (3FN) al convertir `libro`, `autor`, `genero` y `usuario` en catalogos referenciados por llave.

Con esto: la lista de autores o generos de "Bases de Datos I" se guarda una unica vez (en `libro_autor`/`libro_genero`) sin importar cuantos prestamos tenga ese libro; actualizar el nombre de un autor requiere un solo `UPDATE`; se puede registrar un autor, genero o libro nuevo sin necesidad de un prestamo; y un autor puede tener varios libros (como "A. Torres", que en los datos de prueba escribe tanto "Bases de Datos I" como "Historia Contemporanea") sin duplicar su nombre en cada libro.
