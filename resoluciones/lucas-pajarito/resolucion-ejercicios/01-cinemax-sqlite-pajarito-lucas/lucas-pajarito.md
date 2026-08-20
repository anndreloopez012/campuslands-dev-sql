# Taller: Diseño e Implementación de una Base de Datos para un Cine utilizando SQLite

Este repositorio contiene la solución completa al taller práctico para el diseño, modelado e implementación de un sistema de gestión relacional para la empresa **CineMax**, desarrollado bajo el entorno de bases de datos relacionales SQLite.

---

## 1. Información General

* **Nombre del Proyecto:** Sistema de Gestión Cinematográfica (CineMax)
* **Nombre del Camper:** lucas samuel pajarito surek

---

## 2. Descripción del Problema

### ¿Qué necesidad tiene la empresa CineMax?
Actualmente, **CineMax** registra de forma manual toda la información operativa relacionada con sus carteleras, el control de las salas de proyección, la asignación de horarios (funciones) y la venta de boletos. Este método obsoleto genera las siguientes problemáticas:
* Dificultad extrema para consultar la disponibilidad y programación de funciones en tiempo real.
* Falta de control centralizado sobre las películas que se están proyectando y los boletos vendidos.
* Imposibilidad de identificar métricas críticas, como cuáles son las salas más utilizadas o los niveles de ocupación.

### ¿Cómo ayuda la base de datos propuesta a resolverla?
La base de datos propuesta en este proyecto centraliza y estructura la información en un modelo relacional de **máximo 4 tablas**. Su implementación en SQLite permite:
1. **Automatizar el flujo de información:** Desde el registro de una película hasta la programación de su función.
2. **Garantizar la integridad de los datos:** Evitando registros duplicados en salas o películas y validando valores coherentes (como precios de boletos y duraciones mayores a cero).
3. **Agilizar la toma de decisiones:** Permitiendo la ejecución de consultas estructuradas (DQL) instantáneas para conocer la cantidad de películas, promedios de duración y la ocupación/frecuencia de uso por sala.

---

## 3. Modelo de Datos

### Diagrama Entidad - Relación (UML E-R)

A continuación, se detalla el modelo visual que resuelve los requerimientos del cine respetando la restricción de un máximo de 4 tablas (*Películas, Cines/Sucursales, Salas y Funciones/Screenings*):

### Descripción de las Entidades Identificadas

1. **`movies` (Películas):** Almacena el catálogo de largometrajes disponibles en la cadena de cines.
2. **`cinemas` (Cines / Sucursales):** Representa los diferentes complejos o sucursales físicas que posee la empresa CineMax.
3. **`rooms` (Salas):** Representa las salas de proyección físicas que pertenecen a un cine específico.
4. **`screenings` (Funciones):** Entidad central que intersecta una película con una sala en un horario y precio determinados, mapeando la disponibilidad real de la cartelera.

### Explicación de las Relaciones

* **Cines a Salas (`cinemas` -> `rooms`):** Relación **1 a Muchos (1:N)**. Un cine o complejo puede albergar múltiples salas de proyección, pero una sala en específico pertenece de manera obligatoria y única a un solo cine.
* **Películas a Funciones (`movies` -> `screenings`):** Relación **1 a Muchos (1:N)**. Una película puede ser proyectada en múltiples funciones y horarios a lo largo de la semana, pero una función en particular corresponde exclusivamente a una única película.
* **Salas a Funciones (`rooms` -> `screenings`):** Relación **1 a Muchos (1:N)**. Una sala puede albergar diversas funciones en diferentes horarios durante el día, pero una función específica se ejecuta en una única sala.

---

## 4. Restricciones Implementadas

Para asegurar que la base de datos no admita datos corruptos, erróneos o inconsistentes, se implementaron rigurosamente las siguientes reglas de integridad dentro del script DDL:

* **Llaves Primarias (`PRIMARY KEY`):** Identifican unívocamente cada fila de las tablas. Se configuraron como campos enteros autonuméricos (`INTEGER PRIMARY KEY AUTOINCREMENT`) en `movie_id`, `cinema_id`, `room_id` y `screening_id`.
* **Llaves Foráneas (`FOREIGN KEY`):** Mantienen la integridad referencial de los datos. Se añadieron restricciones `ON DELETE CASCADE` de modo que si un cine o una película se elimina del sistema, sus salas y funciones asociadas se borren automáticamente, evitando registros huérfanos.
* **Restricciones `NOT NULL`:** Campos críticos como títulos, nombres de salas, capacidades, horarios y precios se marcaron obligatorios para impedir celdas vacías en la operación del negocio.
* **Restricciones `UNIQUE`:**
  * El título de la película (`title`) y el nombre del complejo cinematográfico (`name`) deben ser únicos en el sistema.
  * Se aplicó una **llave única compuesta** `UNIQUE(cinema_id, room_name)` en la tabla `rooms`. Esto asegura que un mismo cine no pueda tener dos salas con el mismo nombre (ej. "Sala 1"), pero permite que diferentes cines sí compartan esa misma nomenclatura de sala.
* **Restricciones `CHECK`:**
  * Se valida que la duración de las películas y la capacidad de las salas de proyección sean estrictamente superiores a cero (`> 0`).
  * Se restringe la clasificación de las películas (`rating`) únicamente a un conjunto de valores válidos de la industria: `'G', 'PG', 'PG-13', 'R', 'NC-17'`.
  * Se restringe el costo de la función (`price`) para impedir valores negativos (`>= 0`).

---
