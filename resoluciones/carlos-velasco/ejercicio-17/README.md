# Ejercicio 17: Red Social Campus

## Información

| Campo | Valor |
| --- | --- |
| Ejercicio | 17 |
| Nombre | Red Social Campus |
| Estudiante | Carlos Velasco |
| Motor | SQLite |
| Fecha | 2026-08-20 |

## Descripción

El ejercicio implementa una base de datos relacional para una red social educativa. El modelo permite administrar usuarios, publicaciones, comentarios y reacciones, evitando duplicidad de información y facilitando la generación de reportes sobre las interacciones de la comunidad.

## Modelo implementado

La solución utiliza cuatro tablas:

- `usuarios`: almacena la información básica de los integrantes de la plataforma.
- `publicaciones`: registra el contenido creado por los usuarios.
- `comentarios`: almacena las respuestas realizadas sobre las publicaciones.
- `reacciones`: registra las interacciones de los usuarios sobre las publicaciones.

### Relaciones

```text
usuarios
    │
    ├──< publicaciones
    │       ├──< comentarios
    │       └──< reacciones
    │
    ├──< comentarios
    │
    └──< reacciones
```

Cada publicación pertenece a un usuario. Los comentarios y reacciones relacionan usuarios con publicaciones.

## Restricciones

El modelo implementa:

- `PRIMARY KEY` en las cuatro tablas.
- `FOREIGN KEY` para mantener la integridad referencial.
- `NOT NULL` en los campos obligatorios.
- `UNIQUE` para `nombre_usuario` y `correo`.
- `UNIQUE (publicacion_id, usuario_id)` para evitar reacciones duplicadas.
- `CHECK` para validar longitudes mínimas.
- `CHECK` para controlar los valores permitidos de `visibilidad`.
- `CHECK` para controlar los tipos de reacción.
- Fechas almacenadas en formato ISO `YYYY-MM-DD`.
- `PRAGMA foreign_keys = ON`.

## Datos

Se cargaron:

- 5 usuarios.
- 10 publicaciones.
- 10 comentarios.
- 10 reacciones.

Posteriormente se agregaron 2 registros mediante `operaciones.sql`.

## Operaciones

El archivo `dml/operaciones.sql` contiene:

- 2 `INSERT` adicionales.
- 2 `UPDATE` válidos.
- 2 `DELETE` controlados mediante `WHERE`.
- 2 operaciones inválidas comentadas para demostrar restricciones `UNIQUE` y `FOREIGN KEY`.

Las operaciones inválidas permanecen comentadas para evitar que interrumpan la ejecución completa del script.

## Consultas

El archivo `dql/consultas.sql` contiene las 12 consultas solicitadas:

1. Listado completo de publicaciones.
2. Selección de dos columnas relevantes.
3. Filtrado por fecha.
4. Ordenamiento por fecha.
5. Top 5 publicaciones por interacciones.
6. Conteo total de publicaciones.
7. Promedio de comentarios.
8. Agrupación por visibilidad.
9. `JOIN` entre usuarios y publicaciones.
10. Consulta con `WHERE`, `ORDER BY` y `LIMIT`.
11. Reporte con alias legibles.
12. Consulta para identificar publicaciones con mayor interacción.

## Ejecución

Desde la raíz de la solución:

```bash
sqlite3 ejercicio-17.db < ddl/schema.sql
sqlite3 ejercicio-17.db < dml/inserts.sql
sqlite3 ejercicio-17.db < dml/operaciones.sql
sqlite3 ejercicio-17.db < dql/consultas.sql
```

No se debe incluir en el repositorio ningún archivo `.db`, `.sqlite` ni `.sqlite3`.

## Validaciones

### Verificar tablas

```sql
.tables
```

Resultado esperado:

```text
comentarios  publicaciones  reacciones  usuarios
```

### Verificar cantidad de registros

```sql
SELECT 'usuarios' AS tabla, COUNT(*) AS total FROM usuarios
UNION ALL
SELECT 'publicaciones', COUNT(*) FROM publicaciones
UNION ALL
SELECT 'comentarios', COUNT(*) FROM comentarios
UNION ALL
SELECT 'reacciones', COUNT(*) FROM reacciones;
```

Después de ejecutar los inserts y las operaciones, los conteos esperados son:

```text
usuarios       | 5
publicaciones  | 11
comentarios    | 10
reacciones     | 9
```

### Verificar integridad referencial

```sql
PRAGMA foreign_key_check;
```

Resultado esperado:

```text
Sin filas devueltas.
```

### Verificar restricciones

Las operaciones inválidas incluidas en `dml/operaciones.sql` permiten comprobar que SQLite rechaza:

- un `nombre_usuario` duplicado mediante `UNIQUE`;
- una publicación asociada a un usuario inexistente mediante `FOREIGN KEY`.

## Decisiones de diseño

Se mantuvo un máximo de cuatro tablas y cada una representa una responsabilidad independiente.

Las publicaciones se relacionan directamente con los usuarios mediante `usuario_id`. Los comentarios y las reacciones conservan tanto el usuario que realiza la interacción como la publicación involucrada, evitando almacenar información repetida.

La restricción compuesta de `reacciones` evita que un usuario registre múltiples reacciones sobre la misma publicación.

Los valores controlados mediante `CHECK` permiten mantener estados y tipos de interacción válidos desde la propia base de datos.

## Estructura

```text
resoluciones/
└── carlos-velasco/
    └── ejercicio-17/
        ├── README.md
        ├── diagramas/
        │   └── README.md
        ├── ddl/
        │   └── schema.sql
        ├── dml/
        │   ├── inserts.sql
        │   └── operaciones.sql
        └── dql/
            └── consultas.sql
```