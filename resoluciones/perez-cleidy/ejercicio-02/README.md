## Nombre: Cleidy Priscila Pérez Casia

## Fecha
- 23/06/2026

# 1. Descripción corta del problema
El objetivo es gestionar el ciclo de venta de una tienda tecnológica. Se identificó la necesidad de estructurar el almacenamiento de datos para evitar la redundancia y garantizar la integridad al registrar productos, sus categorías, los clientes compradores y el detalle de las ventas realizadas. El reto principal consistió en aplicar operaciones CRUD (Crear, Leer, Actualizar, Borrar) y asegurar que las reglas de negocio se respeten estrictamente mediante restricciones del motor SQL.

# 2. Explicación de tablas y relaciones
El modelo relacional se compone de 4 entidades principales:

categoria: Tabla maestra que clasifica los productos (ej. Teléfonos, Audífonos). Su llave primaria es id_categoria.

productos: Almacena el inventario con su precio. Su llave primaria es id_producto.

clientes: Registra la información de contacto y el documento de identificación único (dpi) de los compradores.

ventas: Tabla transaccional que unifica el modelo.

Se relaciona con categoria mediante la llave foránea (id_categoria).

Se relaciona con productos mediante la llave foránea (id_producto).

# 3. Restricciones aplicadas
Para garantizar que la base de datos no admita información corrupta o inconsistente, se aplican las siguientes reglas:PRIMARY KEY (Llave Primaria): Aplicada en los IDs de todas las tablas para garantizar que cada registro sea único e irrepetible.FOREIGN KEY (Llave Foránea): Aplicada en la tabla ventas. Impide que se registre una venta con un producto o una categoría que no existan previamente en las tablas maestras.UNIQUE (Único): Aplicada en el campo dpi y email de la tabla clientes. Dos personas no pueden tener el mismo documento de identificación ni el mismo correo electrónico.CHECK (Validación): Generalmente aplicada en precio y cantidad para asegurar que solo se ingresen valores mayores a cero ($> 0$).