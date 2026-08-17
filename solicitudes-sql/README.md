# Serie Solicitudes SQL: del texto del cliente al modelo relacional

Esta serie contiene 100 ejercicios progresivos para evaluar si el estudiante puede leer una solicitud escrita por un posible cliente y transformarla en SQL.

El objetivo no es memorizar comandos aislados. El objetivo es practicar analisis, modelado, relaciones, operaciones y consultas a partir de necesidades reales expresadas en lenguaje natural.

## Progresion

| Rango | Enfoque | Resultado esperado |
| --- | --- | --- |
| 001-020 | Comprension inicial | Identificar entidades, crear tablas simples e insertar datos. |
| 021-040 | Relaciones basicas | Separar catalogos, crear llaves foraneas y consultar con JOIN. |
| 041-060 | Operaciones controladas | Aplicar reglas, UPDATE, DELETE seguro y restricciones. |
| 061-080 | Reportes | Construir consultas con agrupaciones, rankings y metricas. |
| 081-100 | Solicitud profesional | Resolver casos mas abiertos, documentar supuestos y crear vistas. |

## Como entregar

Cada estudiante debe copiar la plantilla del ejercicio dentro de su carpeta personal:

```text
resoluciones/nombre-apellido/solicitudes-sql/ejercicio-001/
```

Ejemplo:

```bash
mkdir -p resoluciones/juan-perez/solicitudes-sql
cp -R solicitudes-sql/ejercicio-001-cafeteria-campus/plantilla resoluciones/juan-perez/solicitudes-sql/ejercicio-001
```

No modifique los enunciados dentro de `solicitudes-sql/`.

## Lista de ejercicios

| # | Ejercicio | Nivel |
| --- | --- | --- |
| 001 | [Solicitud cliente Cafeteria Campus](ejercicio-001-cafeteria-campus/README.md) | Nivel 1 - comprension inicial |
| 002 | [Solicitud cliente Taller de Motos](ejercicio-002-taller-motos/README.md) | Nivel 1 - comprension inicial |
| 003 | [Solicitud cliente Torneo Esports](ejercicio-003-torneo-esports/README.md) | Nivel 1 - comprension inicial |
| 004 | [Solicitud cliente Tienda Sneakers](ejercicio-004-tienda-sneakers/README.md) | Nivel 1 - comprension inicial |
| 005 | [Solicitud cliente Cine Horror Nights](ejercicio-005-cine-horror/README.md) | Nivel 1 - comprension inicial |
| 006 | [Solicitud cliente Renta Autos de Lujo](ejercicio-006-renta-autos-lujo/README.md) | Nivel 1 - comprension inicial |
| 007 | [Solicitud cliente Academia Kickboxing](ejercicio-007-academia-kickboxing/README.md) | Nivel 1 - comprension inicial |
| 008 | [Solicitud cliente Viajes y Paracaidismo](ejercicio-008-viajes-paracaidismo/README.md) | Nivel 1 - comprension inicial |
| 009 | [Solicitud cliente Estudio Animacion 3D](ejercicio-009-estudio-animacion-3d/README.md) | Nivel 1 - comprension inicial |
| 010 | [Solicitud cliente Biblioteca Sci-Fi](ejercicio-010-biblioteca-sci-fi/README.md) | Nivel 1 - comprension inicial |
| 011 | [Solicitud cliente Delivery de Comida](ejercicio-011-delivery-comida/README.md) | Nivel 1 - comprension inicial |
| 012 | [Solicitud cliente Club Futbol Sala](ejercicio-012-club-futbol-sala/README.md) | Nivel 1 - comprension inicial |
| 013 | [Solicitud cliente Clinica de Tatuajes](ejercicio-013-clinica-tatuajes/README.md) | Nivel 1 - comprension inicial |
| 014 | [Solicitud cliente Mecanica de Autos](ejercicio-014-mecanica-autos/README.md) | Nivel 1 - comprension inicial |
| 015 | [Solicitud cliente Laboratorio Quimico](ejercicio-015-laboratorio-quimico/README.md) | Nivel 1 - comprension inicial |
| 016 | [Solicitud cliente Hotel Gamers](ejercicio-016-hotel-gamers/README.md) | Nivel 1 - comprension inicial |
| 017 | [Solicitud cliente Streaming Musica](ejercicio-017-streaming-musica/README.md) | Nivel 1 - comprension inicial |
| 018 | [Solicitud cliente Escuela de Dibujo](ejercicio-018-escuela-dibujo/README.md) | Nivel 1 - comprension inicial |
| 019 | [Solicitud cliente Diseno 3D Arquitectura](ejercicio-019-arquitectura-3d/README.md) | Nivel 1 - comprension inicial |
| 020 | [Solicitud cliente Soldadura Industrial](ejercicio-020-soldadura-industrial/README.md) | Nivel 1 - comprension inicial |
| 021 | [Solicitud cliente Battle Royale Ranking](ejercicio-021-battle-royale-ranking/README.md) | Nivel 2 - relaciones basicas |
| 022 | [Solicitud cliente Liga MOBA](ejercicio-022-moba-liga/README.md) | Nivel 2 - relaciones basicas |
| 023 | [Solicitud cliente Clanes Shooter](ejercicio-023-shooter-clanes/README.md) | Nivel 2 - relaciones basicas |
| 024 | [Solicitud cliente Liga Videojuego Futbol](ejercicio-024-futbol-videojuego/README.md) | Nivel 2 - relaciones basicas |
| 025 | [Solicitud cliente Track Day Hiperdeportivos](ejercicio-025-hiperdeportivos-trackday/README.md) | Nivel 2 - relaciones basicas |
| 026 | [Solicitud cliente Cafeteria Campus](ejercicio-026-cafeteria-campus/README.md) | Nivel 2 - relaciones basicas |
| 027 | [Solicitud cliente Taller de Motos](ejercicio-027-taller-motos/README.md) | Nivel 2 - relaciones basicas |
| 028 | [Solicitud cliente Torneo Esports](ejercicio-028-torneo-esports/README.md) | Nivel 2 - relaciones basicas |
| 029 | [Solicitud cliente Tienda Sneakers](ejercicio-029-tienda-sneakers/README.md) | Nivel 2 - relaciones basicas |
| 030 | [Solicitud cliente Cine Horror Nights](ejercicio-030-cine-horror/README.md) | Nivel 2 - relaciones basicas |
| 031 | [Solicitud cliente Renta Autos de Lujo](ejercicio-031-renta-autos-lujo/README.md) | Nivel 2 - relaciones basicas |
| 032 | [Solicitud cliente Academia Kickboxing](ejercicio-032-academia-kickboxing/README.md) | Nivel 2 - relaciones basicas |
| 033 | [Solicitud cliente Viajes y Paracaidismo](ejercicio-033-viajes-paracaidismo/README.md) | Nivel 2 - relaciones basicas |
| 034 | [Solicitud cliente Estudio Animacion 3D](ejercicio-034-estudio-animacion-3d/README.md) | Nivel 2 - relaciones basicas |
| 035 | [Solicitud cliente Biblioteca Sci-Fi](ejercicio-035-biblioteca-sci-fi/README.md) | Nivel 2 - relaciones basicas |
| 036 | [Solicitud cliente Delivery de Comida](ejercicio-036-delivery-comida/README.md) | Nivel 2 - relaciones basicas |
| 037 | [Solicitud cliente Club Futbol Sala](ejercicio-037-club-futbol-sala/README.md) | Nivel 2 - relaciones basicas |
| 038 | [Solicitud cliente Clinica de Tatuajes](ejercicio-038-clinica-tatuajes/README.md) | Nivel 2 - relaciones basicas |
| 039 | [Solicitud cliente Mecanica de Autos](ejercicio-039-mecanica-autos/README.md) | Nivel 2 - relaciones basicas |
| 040 | [Solicitud cliente Laboratorio Quimico](ejercicio-040-laboratorio-quimico/README.md) | Nivel 2 - relaciones basicas |
| 041 | [Solicitud cliente Hotel Gamers](ejercicio-041-hotel-gamers/README.md) | Nivel 3 - operaciones controladas |
| 042 | [Solicitud cliente Streaming Musica](ejercicio-042-streaming-musica/README.md) | Nivel 3 - operaciones controladas |
| 043 | [Solicitud cliente Escuela de Dibujo](ejercicio-043-escuela-dibujo/README.md) | Nivel 3 - operaciones controladas |
| 044 | [Solicitud cliente Diseno 3D Arquitectura](ejercicio-044-arquitectura-3d/README.md) | Nivel 3 - operaciones controladas |
| 045 | [Solicitud cliente Soldadura Industrial](ejercicio-045-soldadura-industrial/README.md) | Nivel 3 - operaciones controladas |
| 046 | [Solicitud cliente Battle Royale Ranking](ejercicio-046-battle-royale-ranking/README.md) | Nivel 3 - operaciones controladas |
| 047 | [Solicitud cliente Liga MOBA](ejercicio-047-moba-liga/README.md) | Nivel 3 - operaciones controladas |
| 048 | [Solicitud cliente Clanes Shooter](ejercicio-048-shooter-clanes/README.md) | Nivel 3 - operaciones controladas |
| 049 | [Solicitud cliente Liga Videojuego Futbol](ejercicio-049-futbol-videojuego/README.md) | Nivel 3 - operaciones controladas |
| 050 | [Solicitud cliente Track Day Hiperdeportivos](ejercicio-050-hiperdeportivos-trackday/README.md) | Nivel 3 - operaciones controladas |
| 051 | [Solicitud cliente Cafeteria Campus](ejercicio-051-cafeteria-campus/README.md) | Nivel 3 - operaciones controladas |
| 052 | [Solicitud cliente Taller de Motos](ejercicio-052-taller-motos/README.md) | Nivel 3 - operaciones controladas |
| 053 | [Solicitud cliente Torneo Esports](ejercicio-053-torneo-esports/README.md) | Nivel 3 - operaciones controladas |
| 054 | [Solicitud cliente Tienda Sneakers](ejercicio-054-tienda-sneakers/README.md) | Nivel 3 - operaciones controladas |
| 055 | [Solicitud cliente Cine Horror Nights](ejercicio-055-cine-horror/README.md) | Nivel 3 - operaciones controladas |
| 056 | [Solicitud cliente Renta Autos de Lujo](ejercicio-056-renta-autos-lujo/README.md) | Nivel 3 - operaciones controladas |
| 057 | [Solicitud cliente Academia Kickboxing](ejercicio-057-academia-kickboxing/README.md) | Nivel 3 - operaciones controladas |
| 058 | [Solicitud cliente Viajes y Paracaidismo](ejercicio-058-viajes-paracaidismo/README.md) | Nivel 3 - operaciones controladas |
| 059 | [Solicitud cliente Estudio Animacion 3D](ejercicio-059-estudio-animacion-3d/README.md) | Nivel 3 - operaciones controladas |
| 060 | [Solicitud cliente Biblioteca Sci-Fi](ejercicio-060-biblioteca-sci-fi/README.md) | Nivel 3 - operaciones controladas |
| 061 | [Solicitud cliente Delivery de Comida](ejercicio-061-delivery-comida/README.md) | Nivel 4 - reportes y agrupaciones |
| 062 | [Solicitud cliente Club Futbol Sala](ejercicio-062-club-futbol-sala/README.md) | Nivel 4 - reportes y agrupaciones |
| 063 | [Solicitud cliente Clinica de Tatuajes](ejercicio-063-clinica-tatuajes/README.md) | Nivel 4 - reportes y agrupaciones |
| 064 | [Solicitud cliente Mecanica de Autos](ejercicio-064-mecanica-autos/README.md) | Nivel 4 - reportes y agrupaciones |
| 065 | [Solicitud cliente Laboratorio Quimico](ejercicio-065-laboratorio-quimico/README.md) | Nivel 4 - reportes y agrupaciones |
| 066 | [Solicitud cliente Hotel Gamers](ejercicio-066-hotel-gamers/README.md) | Nivel 4 - reportes y agrupaciones |
| 067 | [Solicitud cliente Streaming Musica](ejercicio-067-streaming-musica/README.md) | Nivel 4 - reportes y agrupaciones |
| 068 | [Solicitud cliente Escuela de Dibujo](ejercicio-068-escuela-dibujo/README.md) | Nivel 4 - reportes y agrupaciones |
| 069 | [Solicitud cliente Diseno 3D Arquitectura](ejercicio-069-arquitectura-3d/README.md) | Nivel 4 - reportes y agrupaciones |
| 070 | [Solicitud cliente Soldadura Industrial](ejercicio-070-soldadura-industrial/README.md) | Nivel 4 - reportes y agrupaciones |
| 071 | [Solicitud cliente Battle Royale Ranking](ejercicio-071-battle-royale-ranking/README.md) | Nivel 4 - reportes y agrupaciones |
| 072 | [Solicitud cliente Liga MOBA](ejercicio-072-moba-liga/README.md) | Nivel 4 - reportes y agrupaciones |
| 073 | [Solicitud cliente Clanes Shooter](ejercicio-073-shooter-clanes/README.md) | Nivel 4 - reportes y agrupaciones |
| 074 | [Solicitud cliente Liga Videojuego Futbol](ejercicio-074-futbol-videojuego/README.md) | Nivel 4 - reportes y agrupaciones |
| 075 | [Solicitud cliente Track Day Hiperdeportivos](ejercicio-075-hiperdeportivos-trackday/README.md) | Nivel 4 - reportes y agrupaciones |
| 076 | [Solicitud cliente Cafeteria Campus](ejercicio-076-cafeteria-campus/README.md) | Nivel 4 - reportes y agrupaciones |
| 077 | [Solicitud cliente Taller de Motos](ejercicio-077-taller-motos/README.md) | Nivel 4 - reportes y agrupaciones |
| 078 | [Solicitud cliente Torneo Esports](ejercicio-078-torneo-esports/README.md) | Nivel 4 - reportes y agrupaciones |
| 079 | [Solicitud cliente Tienda Sneakers](ejercicio-079-tienda-sneakers/README.md) | Nivel 4 - reportes y agrupaciones |
| 080 | [Solicitud cliente Cine Horror Nights](ejercicio-080-cine-horror/README.md) | Nivel 4 - reportes y agrupaciones |
| 081 | [Solicitud cliente Renta Autos de Lujo](ejercicio-081-renta-autos-lujo/README.md) | Nivel 5 - solicitud profesional |
| 082 | [Solicitud cliente Academia Kickboxing](ejercicio-082-academia-kickboxing/README.md) | Nivel 5 - solicitud profesional |
| 083 | [Solicitud cliente Viajes y Paracaidismo](ejercicio-083-viajes-paracaidismo/README.md) | Nivel 5 - solicitud profesional |
| 084 | [Solicitud cliente Estudio Animacion 3D](ejercicio-084-estudio-animacion-3d/README.md) | Nivel 5 - solicitud profesional |
| 085 | [Solicitud cliente Biblioteca Sci-Fi](ejercicio-085-biblioteca-sci-fi/README.md) | Nivel 5 - solicitud profesional |
| 086 | [Solicitud cliente Delivery de Comida](ejercicio-086-delivery-comida/README.md) | Nivel 5 - solicitud profesional |
| 087 | [Solicitud cliente Club Futbol Sala](ejercicio-087-club-futbol-sala/README.md) | Nivel 5 - solicitud profesional |
| 088 | [Solicitud cliente Clinica de Tatuajes](ejercicio-088-clinica-tatuajes/README.md) | Nivel 5 - solicitud profesional |
| 089 | [Solicitud cliente Mecanica de Autos](ejercicio-089-mecanica-autos/README.md) | Nivel 5 - solicitud profesional |
| 090 | [Solicitud cliente Laboratorio Quimico](ejercicio-090-laboratorio-quimico/README.md) | Nivel 5 - solicitud profesional |
| 091 | [Solicitud cliente Hotel Gamers](ejercicio-091-hotel-gamers/README.md) | Nivel 5 - solicitud profesional |
| 092 | [Solicitud cliente Streaming Musica](ejercicio-092-streaming-musica/README.md) | Nivel 5 - solicitud profesional |
| 093 | [Solicitud cliente Escuela de Dibujo](ejercicio-093-escuela-dibujo/README.md) | Nivel 5 - solicitud profesional |
| 094 | [Solicitud cliente Diseno 3D Arquitectura](ejercicio-094-arquitectura-3d/README.md) | Nivel 5 - solicitud profesional |
| 095 | [Solicitud cliente Soldadura Industrial](ejercicio-095-soldadura-industrial/README.md) | Nivel 5 - solicitud profesional |
| 096 | [Solicitud cliente Battle Royale Ranking](ejercicio-096-battle-royale-ranking/README.md) | Nivel 5 - solicitud profesional |
| 097 | [Solicitud cliente Liga MOBA](ejercicio-097-moba-liga/README.md) | Nivel 5 - solicitud profesional |
| 098 | [Solicitud cliente Clanes Shooter](ejercicio-098-shooter-clanes/README.md) | Nivel 5 - solicitud profesional |
| 099 | [Solicitud cliente Liga Videojuego Futbol](ejercicio-099-futbol-videojuego/README.md) | Nivel 5 - solicitud profesional |
| 100 | [Solicitud cliente Track Day Hiperdeportivos](ejercicio-100-hiperdeportivos-trackday/README.md) | Nivel 5 - solicitud profesional |
