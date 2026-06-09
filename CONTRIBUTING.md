# Guia de Contribucion

## Ramas

Use `dev` como rama base de trabajo. No trabaje directamente sobre `dev`; cree siempre una rama personal desde `dev`.

No haga commits directos sobre:

- `main`
- `master`
- `dev`

Para verificar la rama actual:

```bash
git branch --show-current
```

Para cambiar a `dev`:

```bash
git switch dev
```

Para crear una rama de trabajo desde `dev`:

```bash
git switch -c alumno/apellido-nombre/ejercicio-01
```

## Agregar nuevos ejercicios

Cada nuevo ejercicio debe agregarse con esta estructura:

```text
ejercicios/
└── 02-nombre-del-ejercicio/
    ├── README.md
    └── plantilla/
        ├── diagramas/
        │   └── .gitkeep
        ├── ddl/
        │   └── schema.sql
        ├── dml/
        │   ├── inserts.sql
        │   └── operaciones.sql
        └── dql/
            └── consultas.sql
```

El `README.md` del ejercicio debe incluir:

- Contexto del problema.
- Requerimientos.
- Entregables.
- Criterios de evaluacion.
- Comandos basicos de ejecucion cuando aplique.
- Instrucciones de Pull Request hacia `dev`.

## Agregar resoluciones

Las resoluciones deben ir en:

```text
resoluciones/
└── apellido-nombre/
    └── ejercicio-XX/
```

Ejemplo:

```text
resoluciones/
└── perez-ana/
    └── ejercicio-01/
```

No deje archivos sueltos directamente dentro de `resoluciones/`.
No modifique resoluciones de otros estudiantes.

## Commits

Use mensajes claros:

```text
docs: agrega enunciado de cinemax
feat: agrega plantilla del ejercicio 01
fix: corrige consulta de funciones por sala
```

## Antes de entregar

Verifique:

- Los scripts SQL se ejecutan sin errores inesperados.
- Las rutas solicitadas existen.
- Las evidencias estan documentadas.
- No hay archivos temporales o bases de datos locales versionadas.
- El Pull Request apunta a `dev`.
- No modifico archivos dentro de `ejercicios/`.
