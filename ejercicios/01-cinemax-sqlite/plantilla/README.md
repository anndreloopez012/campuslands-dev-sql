# Información General

  CineMax Database
  Wilder Fernando Elias Catù Colaj
  4 de junio de 2026

## Descripción del Problema

CineMax necesita una base de datos para gestionar su operación diaria, incluyendo la administración de películas, salas, funciones y boletos.  
La base de datos propuesta permite:

 Registrar y consultar películas disponibles.

 Asignar funciones a salas específicas con horarios definidos.

 Controlar la venta de boletos y garantizar la integridad de los datos.

## Modelo de Datos

### Diagrama UML E-R
Diagrama UML
![alt text](image.png)


### Descripción de las Entidades
 **Peliculas:** Contiene información sobre las películas (Nombre, Duración).

 **Salas:** Registra las salas disponibles (Nombre, Capacidad).

 **Funciones:** Relaciona películas con salas y horarios (PeliculaID, SalaID, Fecha, Hora).

 **Boletos:** Registra los boletos vendidos para cada función (FuncionID, Asiento, Precio).

### Explicación de las Relaciones
 Una película puede tener múltiples funciones.
 Una sala puede albergar múltiples funciones.
 Cada boleto está asociado a una función específica.

## Restricciones Implementadas

 **Llaves primarias:**  
   `Peliculas(PeliculaID)`
   `Salas(SalaID)`
   `Funciones(FuncionID)`
   `Boletos(BoletoID)`

 **Llaves foráneas:**  
   `Funciones(PeliculaID)` referencia a `Peliculas(PeliculaID)`.
   `Funciones(SalaID)` referencia a `Salas(SalaID)`.
   `Boletos(FuncionID)` referencia a `Funciones(FuncionID)`.

 **Restricciones NOT NULL:**  
   Ningún campo clave primaria puede ser nulo.
   Campos como `Nombre` en `Peliculas` y `Salas` son obligatorios.

 **Restricciones UNIQUE:**  
   El nombre de las películas debe ser único.
   El nombre de las salas debe ser único.

 **Restricciones CHECK:**  
   La capacidad de las salas debe ser mayor a 0.
   El precio de los boletos debe ser positivo.
