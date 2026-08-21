# Ejercicio 06: Torneo Esports

* **Nombre completo:** Irma Yaneht Arias Garcia
* **Fecha:** 2026-08-21

##  Descripción del Problema
Solución informática diseñada para gestionar de manera estructurada los equipos, jugadores, partidas y resultados de un torneo de videojuegos competitivo, eliminando registros manuales dispersos y facilitando la generación de reportes y marcadores.

##  Explicación de Tablas y Relaciones
El sistema está compuesto por 4 tablas principales:
1. **`equipos`**: Catálogo que almacena la información de las organizaciones de esports (nombre, región, año).
2. **`jugadores`**: Contiene los perfiles de los competidores, enlazados a su respectivo equipo mediante una llave foránea (`equipo_id`).
3. **`partidas`**: Registro de los encuentros programados (fase, fecha, mapa).
4. **`resultados`**: Tabla transaccional que relaciona las partidas con los equipos participantes (`partida_id` y `equipo_id`), registrando puntajes y estados del encuentro.

##  Restricciones Aplicadas
* **`PRIMARY KEY`**: Identificador único en cada tabla.
* **`FOREIGN KEY`**: Garantiza la integridad referencial entre equipos, jugadores, partidas y resultados.
* **`NOT NULL`**: Campos obligatorios protegidos.
* **`UNIQUE`**: Nombres de equipos y gamertags de jugadores sin duplicados.
* **`CHECK`**: Controla que los años de fundación sean lógicos (> 2000), edades mínimas de jugadores (>= 16), puntuaciones no negativas y estados de resultado válidos.

##  Cómo Ejecutar
```bash
sqlite3 ejercicio-06.db < resoluciones/arias-irma/ejercicio-06/ddl/schema.sql
sqlite3 ejercicio-06.db < resoluciones/arias-irma/ejercicio-06/dml/inserts.sql
sqlite3 ejercicio-06.db < resoluciones/arias-irma/ejercicio-06/dml/operaciones.sql
sqlite3 ejercicio-06.db < resoluciones/arias-irma/ejercicio-06/dql/consultas.sql
