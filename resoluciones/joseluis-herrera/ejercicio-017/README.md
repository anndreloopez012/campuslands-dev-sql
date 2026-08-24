# Ejercicio 17: Red Social Campus

## Información

- Nombre completo: Jose Luis Tot Herrera
- Ejercicio: 17
- Fecha: 2026-08-20
- Motor de base de datos: SQLite
- Contexto: Red social educativa

## Descripción

La base de datos permite administrar usuarios, publicaciones, comentarios y reacciones dentro de una red social educativa.

El modelo permite registrar contenido publicado por los usuarios y analizar las interacciones generadas mediante comentarios, reacciones y visualizaciones.

## Modelo implementado

La solución utiliza cuatro tablas:

- `usuarios`: almacena la información de los usuarios.
- `publicaciones`: registra el contenido creado por los usuarios.
- `comentarios`: registra comentarios asociados a publicaciones y usuarios.
- `reacciones`: registra las reacciones realizadas por usuarios sobre publicaciones.

## Relaciones

- Un usuario puede crear varias publicaciones.
- Una publicación pertenece a un usuario.
- Un usuario puede escribir varios comentarios.
- Un comentario pertenece a un usuario y a una publicación.
- Un usuario puede realizar varias reacciones.
- Una reacción pertenece a un usuario y a una publicación.
- Una publicación puede recibir múltiples comentarios y reacciones.

## Restricciones

- Todas las tablas tienen `PRIMARY KEY`.
- Las relaciones utilizan `FOREIGN KEY`.
- Los campos obligatorios utilizan `NOT NULL`.
- El nombre de usuario es `UNIQUE`.
- El correo electrónico es `UNIQUE`.
- La combinación de publicación y usuario en reacciones es `UNIQUE`.
- Las vistas no pueden ser negativas.
- Las fechas deben utilizar formatos ISO válidos.
- Los estados de las publicaciones están limitados mediante `CHECK`.
- Los tipos de reacción están limitados mediante `CHECK`.
- Se activa `PRAGMA foreign_keys = ON`.

## Datos

Se registran:

- 5 usuarios.
- 5 publicaciones.
- 10 comentarios.
- 10 reacciones.

Los datos permiten obtener resultados en consultas de publicaciones, visualizaciones, comentarios, reacciones e interacciones de usuarios.

## Operaciones

`dml/operaciones.sql` contiene:

- 2 inserciones adicionales.
- 2 actualizaciones.
- 2 eliminaciones controladas mediante `WHERE`.
- 2 operaciones inválidas comentadas.

Las operaciones inválidas prueban las restricciones `UNIQUE` y `FOREIGN KEY`.

## Consultas

`dql/consultas.sql` contiene consultas para:

1. Listar todas las publicaciones.
2. Mostrar dos columnas relevantes.
3. Filtrar publicaciones por cantidad de vistas.
4. Ordenar publicaciones por fecha.
5. Obtener las cinco publicaciones con mayor cantidad de vistas.
6. Contar publicaciones totales.
7. Calcular promedio, mínimo y máximo de vistas.
8. Agrupar publicaciones por estado.
9. Relacionar publicaciones con sus autores.
10. Obtener las publicaciones con mayor cantidad de vistas utilizando `WHERE`, `ORDER BY` y `LIMIT`.
11. Generar reportes de comentarios y reacciones.
12. Agrupar reacciones por tipo.
13. Comparar la actividad de los usuarios.
14. Clasificar publicaciones según su impacto para apoyar decisiones sobre contenido.

## Evidencias y resultados relevantes

Con los datos base:

- Total de usuarios: 5.
- Total de publicaciones: 5.
- Total de comentarios: 10.
- Total de reacciones: 10.
- Las consultas permiten identificar las publicaciones con mayor alcance.
- Las consultas permiten determinar los tipos de reacción más utilizados.
- El reporte de actividad permite comparar la participación de los usuarios.
- La consulta de decisión permite clasificar publicaciones según vistas e interacciones.
- Las operaciones adicionales se ejecutan correctamente.
- Las operaciones inválidas permanecen comentadas para evitar interrumpir el script.

## Ejecución

Desde la raíz de la solución:

```bash
sqlite3 ejercicio-17.db < ddl/schema.sql
sqlite3 ejercicio-17.db < dml/inserts.sql
sqlite3 ejercicio-17.db < dml/operaciones.sql
sqlite3 ejercicio-17.db < dql/consultas.sql
```

No se incluye ningún archivo `.db`, `.sqlite` ni `.sqlite3`.

## Estructura

```text
resoluciones/
└── joseluis-herrera/
    └── ejercicio-017/
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