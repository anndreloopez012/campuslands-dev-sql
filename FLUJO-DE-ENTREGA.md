# Flujo de entrega de ejercicios SQL

Esta guia explica el proceso completo para entregar ejercicios en este repositorio.

El objetivo es evitar errores comunes como subir cambios a `main`, modificar enunciados base, subir bases de datos locales o dejar archivos fuera de la carpeta de resolucion.

## Idea principal

Cada alumno trabaja en su propia rama y entrega mediante un Pull Request hacia `dev`.

```text
dev -> rama del alumno -> Pull Request -> revision del profesor -> merge a dev
```

Nunca se trabaja directamente sobre `main`.

## 1. Actualizar `dev`

Antes de empezar:

```bash
git switch dev
git pull origin dev
```

## 2. Crear una rama propia

Formato recomendado:

```text
alumno/nombre-apellido/ejercicio-XX
```

Ejemplo:

```bash
git switch -c alumno/juan-perez/ejercicio-01
```

## 3. Crear la carpeta de resolucion

Cada alumno debe trabajar dentro de su propia carpeta en `resoluciones/`.

Formato recomendado:

```text
resoluciones/nombre-apellido/
```

Si el instructor pide separar por ejercicio, usa:

```text
resoluciones/nombre-apellido/ejercicio-XX/
```

Ejemplo:

```text
resoluciones/juan-perez/ejercicio-01/
```

Tambien puedes copiar la plantilla del ejercicio:

```bash
mkdir -p resoluciones/juan-perez
cp -R ejercicios/01-cinemax-sqlite/plantilla resoluciones/juan-perez/ejercicio-01
```

## 4. Completar los archivos SQL

Trabaja dentro de tu carpeta personal:

```text
resoluciones/juan-perez/ejercicio-01/
├── diagramas/
├── ddl/
│   └── schema.sql
├── dml/
│   └── inserts.sql
└── dql/
    └── consultas.sql
```

## 5. Validar la solucion

Antes de subir, ejecuta o revisa tus scripts.

Ejemplo con SQLite:

```bash
sqlite3 prueba.db < resoluciones/juan-perez/ejercicio-01/ddl/schema.sql
sqlite3 prueba.db < resoluciones/juan-perez/ejercicio-01/dml/inserts.sql
sqlite3 prueba.db < resoluciones/juan-perez/ejercicio-01/dql/consultas.sql
```

No subas la base de datos generada.

Archivos que no deben subirse:

```text
*.db
*.sqlite
*.sqlite3
```

## 6. Revisar cambios antes del commit

```bash
git status
```

Debes confirmar que solo aparecen archivos de tu carpeta en `resoluciones/`.

No modifiques:

- `main`
- `dev`
- Enunciados en `ejercicios/`, salvo autorizacion del instructor.
- Respuestas de otros estudiantes.
- Archivos base del repositorio.

## 7. Hacer commit con estandar

Formato:

```text
tipo(area): mensaje claro
```

Ejemplos:

```bash
git add resoluciones/juan-perez/
git commit -m "feat(sql): resolver ejercicio 01"
```

```bash
git commit -m "fix(sql): corregir relacion de funciones y salas"
git commit -m "docs(sql): agregar evidencia de consultas"
```

Tipos comunes:

| Tipo | Uso |
| --- | --- |
| `feat` | Agregar una solucion nueva. |
| `fix` | Corregir un error. |
| `docs` | Cambiar documentacion o evidencias. |
| `style` | Ajustar formato sin cambiar resultado. |
| `refactor` | Reorganizar sin cambiar resultado. |
| `test` | Agregar pruebas o validaciones. |
| `chore` | Tareas de mantenimiento. |

## 8. Subir la rama

```bash
git push -u origin alumno/juan-perez/ejercicio-01
```

Si la rama ya existe en GitHub:

```bash
git push
```

## 9. Crear Pull Request

En GitHub:

1. Entra al repositorio.
2. Haz clic en `Compare & pull request`.
3. Verifica la rama base.

Correcto:

```text
base: dev
compare: alumno/juan-perez/ejercicio-01
```

Incorrecto:

```text
base: main
```

Los Pull Requests hacia `main` seran rechazados.

## 10. Esperar revision

El profesor revisara:

- Que el PR apunte a `dev`.
- Que no toque `main`.
- Que la entrega este dentro de `resoluciones/nombre-apellido/`.
- Que no modifique enunciados base.
- Que no modifique respuestas de otros estudiantes.
- Que no suba bases de datos generadas.
- Que los scripts SQL se puedan ejecutar o revisar claramente.
- Que el commit tenga un mensaje claro.

## 11. Si hay correcciones

Corrige en la misma rama:

```bash
git status
git add resoluciones/juan-perez/
git commit -m "fix(sql): corregir consulta de cartelera"
git push
```

El Pull Request se actualiza automaticamente.

## Checklist final

- Estoy en mi rama personal.
- Mi rama salio desde `dev`.
- Mi PR apunta a `dev`.
- No abri PR hacia `main`.
- Mi solucion esta en `resoluciones/nombre-apellido/`.
- No modifique enunciados base.
- No modifique respuestas de otros estudiantes.
- No subi `.db`, `.sqlite` ni `.sqlite3`.
- Ejecute o revise mis scripts SQL.
- Use un mensaje de commit claro.
