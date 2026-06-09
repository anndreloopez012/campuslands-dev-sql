# CineMax - Sistema de Gestión de Cine en SQLite

**Autor:** Jakelin Quino

---

## 1. Descripción del Problema
La empresa **CineMax** requería una solución digital estructurada. La gestión manual impedía un control ágil sobre la disponibilidad de funciones, películas, la cantidad de boletos vendidos y el nivel de ocupación de las salas. 

---

## 2. Modelo de Datos
* **Diagrama E-R:** El diagrama conceptual se encuentra ubicado en `diagramas/Diagrama-CineMax.png`.
* **Entidades Identificadas:**
    * `peliculas`: Almacena el catálogo disponible.
    * `salas`: Espacios físicos con capacidades controladas.
    * `funciones`: El puente que une películas y salas en un tiempo específico.
    * `boletos`: Detalle de transacciones y asignación de asientos por función.

---

## 3. Restricciones Implementadas
* **PRIMARY KEY:** Es el número único de identificación para cada película, sala, función y boleto.
* **FOREIGN KEY:** Conecta las tablas entre sí; por ejemplo, une cada boleto con su función y cada función con su película y sala.
* **NOT NULL:** Obliga a que los datos importantes (como nombres, precios y fechas) nunca se queden vacíos.
* **UNIQUE:** Evita que se repitan nombres de salas y, lo más importante, evita que se crucen horarios en una sala o que se venda el mismo asiento dos veces.
* **CHECK:** Asegura que los datos tengan sentido; las duraciones y capacidades deben ser mayores a 0, los precios no pueden ser negativos, y solo se permiten las clasificaciones oficiales (`AA`, `A`, `B`, `B15`, `C`).

---