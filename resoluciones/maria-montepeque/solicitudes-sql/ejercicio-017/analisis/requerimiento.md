# Analisis del requerimiento - Ejercicio 017

## Solicitud entendida

Una plataforma musical necesita playlists, artistas, canciones y reproducciones. El cliente pidio explicitamente que el sistema permita corregir estados sin borrar informacion importante: por ejemplo, si una cancion se bloquea temporalmente por un conflicto de derechos, no se debe eliminar del catalogo, solo cambiar su estado.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| artistas | Es el catalogo de artistas de la plataforma, cada uno con su genero principal. | nombre_artista (unico), genero_principal |
| canciones | Es el registro central de cada cancion: de que artista, cuando se lanzo y en que estado esta. Aqui vive la peticion central del cliente: corregir estados sin borrar. | id_artista (FK), titulo, duracion_segundos, fecha_lanzamiento, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| artistas -> canciones | 1:N | Un artista tiene muchas canciones en el catalogo, pero cada cancion pertenece a un unico artista. |

## Reglas de negocio

- Regla 1: Toda cancion debe pertenecer a un artista real del catalogo (`FOREIGN KEY`).
- Regla 2: `duracion_segundos` siempre debe ser mayor a cero (`CHECK`).
- Regla 3: Una cancion puede estar `disponible`, `retirada_temporalmente` o `bloqueada_por_derechos` (`CHECK`); el cliente pidio explicitamente poder corregir este estado en vez de borrar la cancion (por ejemplo, de `retirada_temporalmente` de vuelta a `disponible` cuando se resuelve el problema).
- Regla 4: El nombre del artista no se repite (`UNIQUE`).

## Supuestos

- No se creo una tabla `playlists` ni `reproducciones` separadas: el alcance de este nivel pide 1 a 2 tablas, asi que el modelo se centra en `artistas` y `canciones`, que es donde vive directamente la peticion del cliente (corregir estados).
- El estado por defecto de una cancion nueva es `disponible`, porque asi entra normalmente una cancion recien publicada.
- Solo se elimina una cancion (`DELETE`) cuando nunca debio existir (por ejemplo, una entrada de prueba); una cancion real que se bloquea o retira SIEMPRE se corrige con `UPDATE` de estado, nunca se borra, siguiendo la peticion explicita del cliente.

## Preguntas que responde la base de datos

1. Que canciones existen y en que estado quedo cada una.
2. Que canciones no estan disponibles (retiradas o bloqueadas).
3. Que artista tiene mas canciones en el catalogo.
4. Como se ordenan las canciones por fecha de lanzamiento.
5. Cuanta duracion total de contenido tiene cada artista, para armar playlists o decisiones de programacion.
