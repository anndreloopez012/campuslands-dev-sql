# Guia de entrega para estudiantes

Esta guia explica como debes subir tus ejercicios para que el Pull Request no sea rechazado automaticamente por estructura.

## Regla principal

Cada estudiante trabaja en su propia rama y entrega sus archivos dentro de una carpeta personal llamada con este formato:

```text
resoluciones/nombre-apellido/
```

Ejemplos validos:

```text
resoluciones/juan-perez/
resoluciones/maria-lopez/
resoluciones/carlos-velasco/
```

No uses mayusculas, espacios, tildes ni nombres mezclados.

## Flujo correcto

1. Actualiza tu repositorio local.

```bash
git checkout dev
git pull origin dev
```

2. Crea tu rama personal desde `dev`.

```bash
git checkout -b alumno/nombre-apellido/ejercicio-01
```

3. Agrega tu solucion en la carpeta `resoluciones` del ejercicio correspondiente.

Ejemplo:

```text
resoluciones/juan-perez/ejercicio-01/
```

4. Guarda tus archivos dentro de tu carpeta personal.

Ejemplos:

```text
resoluciones/juan-perez/ejercicio-01/schema.sql
resoluciones/juan-perez/ejercicio-01/inserts.sql
resoluciones/juan-perez/ejercicio-01/consultas.sql
```

5. Haz commit con un mensaje claro.

```bash
git add .
git commit -m "feat(sql): resolver ejercicio 01"
```

6. Sube tu rama.

```bash
git push origin alumno/nombre-apellido/ejercicio-01
```

7. Abre un Pull Request hacia `dev`.

## No hagas esto

- No abras Pull Request hacia `main`.
- No trabajes directamente en `main` ni en `dev`.
- No modifiques archivos base del ejercicio.
- No borres archivos del repositorio.
- No subas archivos de otros estudiantes.
- No subas `.vscode/`, `.idea/`, `.DS_Store` ni `node_modules/`.
- No pongas tu solucion fuera de `resoluciones`.

## Por que se rechaza automaticamente un PR

El bot rechaza el Pull Request cuando la estructura no cumple las reglas del repositorio.

Ejemplo incorrecto:

```text
ejercicios/01/plantilla/resoluciones/juan-perez/schema.sql
```

Debe ser:

```text
resoluciones/juan-perez/ejercicio-01/schema.sql
```

Otro ejemplo incorrecto:

```text
resoluciones/Juan Perez/
```

Debe ser:

```text
resoluciones/juan-perez/
```

## Si tu PR fue rechazado

1. Lee el comentario del bot en el Pull Request.
2. Corrige la carpeta o los archivos indicados.
3. Haz un nuevo commit.
4. Vuelve a subir tu rama.
5. Abre un nuevo Pull Request hacia `dev` si el anterior fue cerrado.

El rechazo no significa que perdiste tu trabajo. Tu rama sigue existiendo; solo debes corregir la forma de entrega.
