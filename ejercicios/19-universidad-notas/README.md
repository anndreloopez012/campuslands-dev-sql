# Ejercicio 19: Universidad Notas

## Objetivo

Disenar e implementar una base de datos relacional en SQLite para un contexto de universidad. El ejercicio se enfoca en registro academico y promedios.

## Contexto

Una organizacion necesita dejar de manejar informacion en hojas sueltas y pasar a una base de datos relacional. Actualmente registra manualmente estudiantes, materias, profesores y notas, lo que provoca duplicidad, errores de captura y dificultad para generar reportes.

Su trabajo es analizar el caso, proponer el modelo, implementarlo en SQLite y demostrar que puede insertar, actualizar, eliminar y consultar informacion correctamente.

## Entidades sugeridas

Puede usar estas entidades como punto de partida. Puede ajustar nombres y atributos si mantiene la coherencia del caso:

- `estudiantes`
- `materias`
- `profesores`
- `notas`

La solucion debe tener maximo 4 tablas. Cada tabla debe tener una responsabilidad clara.

## Requerimientos del modelo

- Definir llaves primarias con `PRIMARY KEY`.
- Definir relaciones con `FOREIGN KEY`.
- Usar `NOT NULL` en campos obligatorios.
- Usar minimo una restriccion `UNIQUE`.
- Usar minimo dos restricciones `CHECK`.
- Incluir fechas en formato ISO `YYYY-MM-DD` o `YYYY-MM-DD HH:MM` cuando aplique.
- Activar `PRAGMA foreign_keys = ON;`.

## Datos minimos

En `dml/inserts.sql` registre al menos:

- 5 registros en cada catalogo principal.
- 10 registros en la tabla transaccional o de relacion principal.
- Datos suficientes para que todas las consultas tengan resultados.

## Operaciones obligatorias

Incluya en `dml/operaciones.sql`:

- 2 operaciones `INSERT` adicionales a los datos base.
- 2 operaciones `UPDATE` que cambien datos validos.
- 2 operaciones `DELETE` controladas con `WHERE`.
- 2 operaciones comentadas que fallen por restricciones (`CHECK`, `UNIQUE` o `FOREIGN KEY`).

Las operaciones que deben fallar deben quedar comentadas para que el script principal pueda ejecutarse completo.

## Consultas obligatorias

Incluya en `dql/consultas.sql` consultas para resolver estos puntos:

1. Listar todos los registros principales de la entidad central.
2. Mostrar solo dos columnas relevantes de esa entidad.
3. Filtrar registros por una condicion numerica o de fecha.
4. Ordenar resultados alfabeticamente o por fecha.
5. Mostrar los 5 registros mas importantes segun una metrica.
6. Contar registros totales.
7. Calcular promedio, minimo o maximo de una columna numerica.
8. Agrupar registros con `GROUP BY`.
9. Relacionar minimo dos tablas con `JOIN`.
10. Crear una consulta con `WHERE`, `ORDER BY` y `LIMIT`.
11. Crear un reporte con alias legibles para las columnas.
12. Crear una consulta que ayude a tomar una decision del negocio.

## Entregables

Su carpeta de solucion debe quedar asi:

```text
resoluciones/apellido-nombre/ejercicio-19/
├── README.md
├── diagramas/
│   └── diagrama-er.png
├── ddl/
│   └── schema.sql
├── dml/
│   ├── inserts.sql
│   └── operaciones.sql
└── dql/
    └── consultas.sql
```

## README de la solucion

Incluya:

- Nombre completo.
- Fecha.
- Descripcion corta del problema.
- Explicacion de tablas y relaciones.
- Restricciones aplicadas.
- Evidencias de ejecucion o resultados relevantes.

## Como ejecutar

Desde la raiz de su solucion:

```bash
sqlite3 ejercicio-19.db < ddl/schema.sql
sqlite3 ejercicio-19.db < dml/inserts.sql
sqlite3 ejercicio-19.db < dml/operaciones.sql
sqlite3 ejercicio-19.db < dql/consultas.sql
```

No suba archivos `.db`, `.sqlite` ni `.sqlite3`.

## Como entregar este ejercicio

1. Haga fork del repositorio publico.
2. Clone su fork en su computador.
3. Cambiese a la rama `dev`.
4. Cree una rama personal desde `dev`.
5. Copie la carpeta `plantilla/` dentro de `resoluciones/apellido-nombre/ejercicio-19/`.
6. Complete los archivos SQL y la documentacion pedida.
7. Valide la solucion con SQLite.
8. Haga commit y push a su rama.
9. Abra Pull Request hacia `dev` del repositorio original.

```bash
git switch dev
git pull origin dev
git switch -c alumno/apellido-nombre/ejercicio-19
mkdir -p resoluciones/apellido-nombre
cp -R ejercicios/19-universidad-notas/plantilla resoluciones/apellido-nombre/ejercicio-19
```

El Pull Request debe tener:

- Base: `dev`
- Compare: su rama personal
- Titulo claro, por ejemplo: `feat(sql): resolver ejercicio 19`

No abra Pull Request hacia `main`.

## Criterios de evaluacion

| Criterio | Peso |
| --- | --- |
| Modelo relacional coherente | 25% |
| DDL con restricciones correctas | 25% |
| Inserts, updates y deletes validos | 20% |
| Consultas SQL correctas | 20% |
| Documentacion y evidencias | 10% |
