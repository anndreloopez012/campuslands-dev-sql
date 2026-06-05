# Cinemax

Este proyecto contiene la solución para el sistema de gestión de una base de datos de **Cinemax** utilizando **SQLite**. Estructura el diseño relacional para el control de películas, salas, funciones disponibles y la venta de boletos.

## Estructura del Proyecto

El ejercicio se organiza bajo una arquitectura limpia dividida en tres secciones esenciales:

ddl/schema.sql: Contiene la definición de datos (DDL). Define las tablas, tipos de datos (`INTEGER`, `TEXT`, `DECIMAL`), llaves primarias, llaves foráneas y restricciones de validación (`CHECK`).
* **dml/inserts.sql**: Contiene la manipulación de datos (DML). Se encarga de poblar las tablas con datos de prueba coherentes y realizar modificaciones de actualización (`UPDATE`).
* **dql/consultas.sql**: Contiene el lenguaje de consulta de datos (DQL). Almacena las consultas de verificación, filtros (`WHERE`, `BETWEEN`), ordenamiento (`ORDER BY`), agregación (`COUNT`) y combinación de tablas (`INNER JOIN`).

---

## Uso de los id
1.  **`peliculas`**: Almacena la información de los filmes (título, duración, clasificación y género).
2.  **`salas`**: Registra los espacios físicos de proyección (nombre, capacidad y tipo de tecnología).
3.  **`funciones`**: Conecta una película con una sala en un horario específico fijando un precio base.
4.  **`boletos`**: Registra las ventas individuales de asientos para una función determinada.

---
