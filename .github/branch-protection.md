# Proteccion de ramas en GitHub

Configure estas reglas en el repositorio publico:

```text
Settings -> Branches -> Branch protection rules
```

## Regla para main

Branch name pattern:

```text
main
```

Activar:

- Require a pull request before merging.
- Require approvals.
- Require review from Code Owners.
- Dismiss stale pull request approvals when new commits are pushed.
- Require conversation resolution before merging.
- Block force pushes.
- Block deletions.
- Do not allow bypassing the above settings, salvo owner/administrador autorizado.

## Regla para dev

Branch name pattern:

```text
dev
```

Activar:

- Require a pull request before merging.
- Require approvals.
- Require review from Code Owners.
- Dismiss stale pull request approvals when new commits are pushed.
- Require conversation resolution before merging.
- Block force pushes.
- Block deletions.
- Do not allow direct push from students.

## Flujo esperado

```text
fork del estudiante -> rama personal desde dev -> Pull Request hacia dev -> revision -> merge a dev
```

No se aceptan Pull Requests hacia `main` desde estudiantes.

## Proteccion local incluida

El repo incluye `.githooks/pre-commit` para bloquear commits directos en:

- `main`
- `master`
- `dev`

Activar despues de clonar:

```bash
git config core.hooksPath .githooks
```

