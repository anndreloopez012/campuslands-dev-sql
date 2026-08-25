# Analisis del requerimiento - Ejercicio 085

## Solicitud entendida

Una biblioteca especializada presta libros de ciencia ficcion y
controla devoluciones. El cliente no sabe hablar en terminos de
tablas: solo describe su operacion diaria y espera que se traduzca a
SQL. Es un nivel 5 (solicitud profesional): ademas del modelo, se
pide interpretar ambiguedad, normalizar datos, documentar decisiones
y crear al menos una vista SQL.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| autores | Catalogo: cada autor de ciencia ficcion | nombre_autor (unico), nacionalidad |
| libros | Catalogo: cada libro, de un autor | titulo, genero |
| lectores | Catalogo: cada lector registrado | nombre_lector (unico), email (unico) |
| prestamos | Tabla transaccional: cada prestamo de un libro | fecha_prestamo, fecha_devolucion_esperada, estado |
| devoluciones | Resultado: el evento real de devolucion de un prestamo, uno por prestamo | fecha_devolucion_real, estado_libro |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| autores -> libros | 1:N | Un autor puede tener varios libros en el catalogo. |
| libros -> prestamos | 1:N | Un libro puede tener muchos prestamos a lo largo del tiempo. |
| lectores -> prestamos | 1:N | Un lector puede tener muchos prestamos. |
| prestamos -> devoluciones | 1:1 | Cada prestamo tiene, como mucho, una devolucion registrada. |

## Decisiones de modelado y ambiguedad interpretada

- **Separar `devoluciones` de `prestamos` (normalizacion):** en
  versiones mas simples de este mismo caso, la devolucion se
  registraba solo como un cambio de `estado` dentro de `prestamos`.
  Aqui, al ser nivel 5, se decidio separar el evento de devolucion en
  su propia tabla, con `UNIQUE (id_prestamo)`, porque el cliente
  quiere "registrar movimientos": la devolucion es un movimiento con
  su propio detalle (en que estado fisico volvio el libro), no solo un
  cambio de estado. Esto tambien evita registrar la misma devolucion
  dos veces por error.
- **"El cliente no sabe hablar en terminos de tablas":** su
  descripcion informal ("presta libros y controla devoluciones") se
  tradujo en el par `prestamos`/`devoluciones` como dos eventos de
  negocio distintos, en vez de una sola tabla con un campo de fecha de
  devolucion.
- **Vista SQL:** se crea `vista_resumen_prestamos`, que junta
  prestamo, libro, autor, lector y devolucion (si existe) con
  `LEFT JOIN`, dando una vista completa de cada prestamo sin importar
  si ya se devolvio o no.
- **Ambiguedad no resuelta por el cliente:** no se detallo si se cobra
  una multa por atraso. Se documenta como fuera del alcance de este
  nivel: el modelo solo marca el prestamo como `'atrasado'`, sin
  calcular un monto.

## Reglas de negocio

- Regla 1 (relaciones invalidas): todo libro debe apuntar a un autor
  real; todo prestamo debe apuntar a un libro y a un lector reales;
  toda devolucion debe apuntar a un prestamo real (`FOREIGN KEY` en
  cadena).
- Regla 2 (registros repetidos): `autores.nombre_autor`,
  `lectores.nombre_lector` y `lectores.email` no se repiten
  (`UNIQUE`); un mismo autor no repite el mismo titulo dos veces
  (`UNIQUE` compuesto); un prestamo no puede tener dos devoluciones
  (`UNIQUE (id_prestamo)`).
- Regla 3 (valores fuera de rango):
  `fecha_devolucion_esperada > fecha_prestamo` (`CHECK`).
- Regla 4: un prestamo nace `'prestado'` y avanza a `'devuelto'`,
  `'atrasado'` o `'perdido'` (`CHECK`); se corrige con `UPDATE` cuando
  pasa la fecha esperada sin devolucion.
- Regla 5: una devolucion se puede eliminar con `DELETE` solo cuando
  fue un error de captura confirmado (se registro sobre el prestamo
  equivocado). El historico real de devoluciones no se borra.

## Supuestos

- Se asume que el estado fisico del libro al devolverse
  (`estado_libro`) es informacion util para decidir si el libro sigue
  disponible para prestamo o necesita reemplazo.
- No se detallo un limite de prestamos simultaneos por lector; se
  asume que no hay limite en el alcance de este nivel.

## Preguntas que responde la base de datos

1. Que prestamos existen, con su libro, autor, lector y devolucion (si
   existe), via la vista `vista_resumen_prestamos`.
2. Que prestamos estan prestados, atrasados, devueltos o perdidos.
3. Que lector tiene mas prestamos (ranking de actividad).
4. Como se ordenan los prestamos por fecha.
5. Que autor tiene mas prestamos en total, para decidir de cual
   comprar mas ejemplares.
