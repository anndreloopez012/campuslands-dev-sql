# 🎬 Proyecto: Base de Datos CineMax
**Desarrollado por:** [Cleidy Priscila Pérez Casia]
**Grupo/Ruta:** [Team U1]  
**Fecha de entrega:** [8-06-2026]  

---

## 📝 1. Descripción del Problema (A mi manera)

### ¿Qué necesidad tiene la empresa CineMax?
CineMax es un cine que estaba creciendo y ya no podía controlar sus películas, sus salas y la venta de boletos usando cuadernos o papeles sueltos. Todo se les mezclaba: no sabían qué película iba en qué sala, se les podían duplicar los asientos o vender boletos para funciones que no existían. Necesitaban orden urgentemente.

### ¿Cómo ayuda mi base de datos a resolverlo?
Aunque al principio me costó un poco entender cómo conectar las cosas, logré armar una base de datos en SQLite que organiza todo de forma automática. Ahora el cine tiene una tabla para las películas, otra para las salas, otra para los horarios de las funciones y una última para controlar los boletos vendidos. El sistema es genial porque si intentas meter un dato mal (como un boleto para una función que no existe), la base de datos se defiende y te lanza un error para que no dañes la información.

---

## 📊 2. Modelo de Datos

### Diagrama Entidad-Relación (E-R)
*Aquí adjunto el diseño que utilicé para guiarme en la creación de las tablas:*

![Diagrama CineMax](./CineMax.png)

### Descripción de las Entidades (Las tablas que creé)
* **peliculas:** Es la lista de las películas que tiene el cine. Guarda el nombre, quién la dirigió, cuánto dura (en minutos) y el género.
* **sala:** Son los espacios físicos del cine. Tienen un nombre (como "La luna") y una capacidad máxima de personas.
* **funcion:** Es la magia del cine; aquí uní las películas con las salas, poniéndoles una fecha, una hora exacta y el precio que costará la entrada.
* **boleto:** Es el control de las ventas. Guarda qué función se compró, en qué fecha se adquirió y el asiento elegido (¡es muy importante que se compre antes de que empiece la función!).

### Explicación de las Relaciones (Cómo se conectan)
Esto fue lo que más me dio dolor de cabeza, pero logré entenderlo así:
* Una **Función** necesita obligatoriamente que exista una **Película** y una **Sala**. No puede haber una función "fantasma".
* Un **Boleto** se vende exclusivamente para una **Función** específica. Gracias a esto, el cine sabe exactamente qué asiento se ocupó y en qué sala.

---

## 🔒 3. Restricciones Implementadas (Los guardianes de los datos)

Para que el profesor vea que cuidé la seguridad de los datos (y después de pelear con varios mensajes en rojo), implementé estas reglas:

* **Llaves Primarias (`PRIMARY KEY`):** Son los códigos únicos (`id_pelicula`, `id_sala`, etc.). Sirven para que ninguna película o boleto se confunda con otro, son como el número de cédula de cada fila.
* **Llaves Foráneas (`FOREIGN KEY`):** Son los puentes de conexión. Usando `PRAGMA foreign_keys = ON;`, obligué a SQLite a revisar que nadie pueda inventarse un número de sala o película que no exista.
* **Restricciones NOT NULL:** Las puse en los nombres y fechas. Si una película no tiene nombre, el sistema no te deja guardarla porque no tendría sentido.
* **Restricciones CHECK (Mi mayor logro):** Usé estas restricciones para poner lógica al negocio. Por ejemplo, me aseguré de que los precios de las funciones o la capacidad de las salas sean siempre números positivos mayores a cero (`> 0`). ¡Nadie puede registrar una sala para -10 personas!

---

## 📸 4. Evidencias de que ¡SÍ FUNCIONA!

Aquí comparto las capturas de pantalla de mi Visual Studio Code donde se ve que, aunque el programa a veces me dejaba mensajes de errores viejos en la pantalla, abajo salían los ganchitos verdes (`✓`) con los milisegundos de éxito:

### Creación de tablas e Inserción de Datos
* **Creación exitosa:** Logré usar el comando `CREATE TABLE IF NOT EXISTS` para que no se me duplicara la estructura.
* **Inserción limpia:** Corregí el error de las comillas dobles `""` cambiándolas por comillas simples `''` y logré meter 5 películas, 5 salas, 8 funciones y 10 boletos ordenados cronológicamente.

### Ejecución de Consultas (DQL)
Logré responder de forma correcta las 10 preguntas del taller. Mis mayores retos fueron:
1.  **El Promedio:** Al principio fallaba porque tenía la palabra "minutos" escrita dentro de los datos. Al limpiar los campos y dejar solo números enteros, el comando `SELECT AVG(duracion)` funcionó de inmediato.
2.  **El Mayor Valor:** Aprendí a usar `SELECT MAX(duracion)` dentro de un `WHERE` para encontrar la película más larga sin tener que buscarla yo a ojo.

### Aprendizaje sobre errores
Durante el proceso guardé capturas de los famosos `Parse error`. Aprendí por las malas que si escribo mal un comando (como `SERT INTO` en vez de `INSERT INTO`), o si olvido una comilla de apertura, la base de datos se detiene por completo. Es estresante ver el color rojo, pero me ayudó a ser mucho más ordenada al escribir código.