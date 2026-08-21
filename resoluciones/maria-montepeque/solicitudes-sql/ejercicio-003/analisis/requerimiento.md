# Analisis del requerimiento - Ejercicio 003

## Solicitud entendida

Una organizacion de esports registra equipos, jugadores, partidas y puntos, pero hoy los registros quedan incompletos y eso le impide sacar reportes confiables (por ejemplo, no puede saber con certeza cuantos puntos tiene cada jugador si algunos registros no tienen ese dato). El cliente pidio una base de datos que obligue a llenar lo minimo necesario, permita corregir estados (activo, inactivo, suspendido) y genere reportes utiles.

## Entidades detectadas

| Entidad | Por que existe | Atributos importantes |
| --- | --- | --- |
| equipos | Es el catalogo de los equipos que participan en la organizacion; varios jugadores pertenecen al mismo equipo. | nombre_equipo (unico), region |
| jugadores | Es el registro central del cliente: cada jugador pertenece a un equipo, tiene un rol y acumula puntos. Aqui es donde el cliente sufre los registros incompletos (nickname vacio, puntos sin definir, etc.). | id_equipo (FK), nickname (unico), nombre_real, rol, puntos_totales, estado |

## Relaciones detectadas

| Relacion | Tipo | Explicacion |
| --- | --- | --- |
| equipos -> jugadores | 1:N | Un equipo tiene varios jugadores, pero cada jugador pertenece a un unico equipo. |

## Reglas de negocio

- Regla 1: Todo jugador debe pertenecer a un equipo registrado (`FOREIGN KEY`); no puede existir un jugador "suelto" sin equipo, porque eso rompe los reportes por equipo.
- Regla 2: `nickname`, `nombre_real`, `rol` y `puntos_totales` son `NOT NULL`: son exactamente los datos que, si faltan, hacen que un reporte no sea confiable (la queja principal del cliente).
- Regla 3: `puntos_totales` nunca puede ser negativo (`CHECK`), un puntaje negativo no tiene sentido de negocio.
- Regla 4: `nickname` es `UNIQUE`, porque es el identificador publico del jugador en los torneos; dos jugadores no pueden competir con el mismo nickname.
- Regla 5: `estado` solo puede ser `activo`, `inactivo` o `suspendido` (`CHECK`); el cliente necesita poder corregir ese estado sin borrar el historial del jugador.

## Supuestos

- No se creo una tabla `partidas` separada en este nivel: el alcance tecnico pide 1 a 2 tablas, asi que `puntos_totales` se guarda como un acumulado directamente en `jugadores` en vez de calcularse a partir de una tabla de partidas. Si mas adelante se necesita el detalle partida por partida, se separaria en su propia tabla transaccional.
- El estado por defecto de un jugador nuevo es `activo`, porque asi entra normalmente un jugador recien registrado.

## Preguntas que responde la base de datos

1. Que jugadores existen y en que estado quedo cada uno.
2. Que jugadores estan suspendidos o inactivos (no disponibles para jugar).
3. Que equipo tiene mas jugadores activos.
4. Como se ordenan los jugadores por puntos, de mayor a menor.
5. Que reporte de ranking por equipo podria usar el cliente para tomar decisiones (por ejemplo, para asignar el proximo torneo).
