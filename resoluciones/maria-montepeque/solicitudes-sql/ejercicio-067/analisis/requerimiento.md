# Analisis del requerimiento - Ejercicio 067

## Solicitud entendida

Una plataforma de streaming musical necesita manejar artistas,
canciones, usuarios, playlists y reproducciones. El cliente pide
explicitamente que el sistema permita corregir estados sin borrar
informacion importante: por ejemplo, una playlist que el usuario ya no
usa se debe poder archivar en vez de eliminarla, para no perder su
historial. Se necesita una base de datos que permita consultar datos,
corregir esos estados, registrar reproducciones y sacar reportes, como
saber que cancion se reproduce mas.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| artistas | Catalogo: interprete de una cancion | nombre (unico) |
| canciones | Catalogo: pertenece a un artista; se repite en muchas reproducciones | titulo, duracion_segundos, genero |
| usuarios | Catalogo: persona que usa la plataforma | nombre, email (unico), plan |
| playlists | Operacion: lista creada por un usuario; su estado se corrige en vez de borrarla | nombre, estado |
| reproducciones | Movimiento: registro de que usuario escucho que cancion y cuando | fecha_reproduccion |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| artistas -> canciones | 1:N | Un artista puede tener muchas canciones. |
| usuarios -> playlists | 1:N | Un usuario puede crear muchas playlists. |
| usuarios -> reproducciones | 1:N | Un usuario puede tener muchas reproducciones registradas. |
| canciones -> reproducciones | 1:N | Una cancion puede reproducirse muchas veces. |

## Reglas de negocio

- Regla 1: para no perder informacion, una playlist no se elimina
  cuando el usuario deja de usarla: se cambia su `estado` de
  `'activa'` a `'archivada'` (`CHECK (estado IN ('activa', 'archivada'))`).
  Solo se permite un `DELETE` real cuando el registro fue un error de
  captura (por ejemplo, una reproduccion duplicada).
- Regla 2: el plan de un usuario es `'gratuito'` o `'premium'`
  (`CHECK`), con `'gratuito'` como valor por `DEFAULT` para cuentas
  nuevas.
- Regla 3: el genero de una cancion debe ser uno de los reconocidos por
  la plataforma (`CHECK`), y su duracion debe ser mayor a cero
  (`CHECK`).
- Regla 4: el nombre de un artista y el correo de un usuario no se
  pueden repetir (`UNIQUE`).

## Supuestos

- El cliente no especifico si una playlist contiene canciones
  especificas; se asume, para mantener el alcance de 5 tablas, que el
  contenido de la playlist no se modela en detalle y el foco esta en su
  ciclo de vida (activa/archivada) y en las reproducciones individuales
  del usuario.
- No se detallo el precio de cada plan; se asume que `plan` solo
  distingue el nivel de servicio, sin modelar facturacion en este
  alcance.
- Se asume que una reproduccion duplicada (el mismo usuario, cancion y
  fecha/hora exacta) es un error de registro y puede eliminarse con
  `DELETE`, a diferencia de una playlist, que solo se archiva.

## Preguntas que responde la base de datos

1. Cuales son todas las reproducciones con su usuario y cancion.
2. Que playlists estan activas o archivadas.
3. Que cancion tiene mas reproducciones (ranking de popularidad).
4. Cuales son las reproducciones ordenadas por fecha, de la mas
   reciente a la mas antigua.
5. Que genero musical se reproduce mas entre usuarios premium (reporte
   para decision de negocio: en que genero enfocar las recomendaciones).
