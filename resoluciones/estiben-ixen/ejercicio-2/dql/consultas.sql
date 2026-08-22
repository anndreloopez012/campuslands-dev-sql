-- 1. Listar todos los registros principales de la entidad central.

select * from ventas 
order by id_venta desc;

-- 2. Mostrar solo dos columnas relevantes de esa entidad.
select 
	p.nombre_producto,
    v.fecha_venta
    from productos p 
    inner join ventas v
    on v.id_producto = p.id_producto
    order by v.fecha_venta desc;
    
-- 3. Filtrar registros por una condicion numerica o de fecha.
select 
 v.id_venta,
 p.nombre_producto
 from productos p
 inner join ventas v
 on v.id_producto = p.id_producto
 where v.fecha_venta >= current_date() - interval 10 day
 order by v.fecha_venta desc;
 

-- 4. Ordenar resultados alfabeticamente o por fecha.

select * from ventas 
order by fecha_venta desc;

-- 5. Mostrar los 5 registros mas importantes segun una metrica.
select 
	p.nombre_producto,
    v.id_venta,
    v.fecha_venta
    from productos p 
    inner join ventas v
    on v.id_producto =p.id_producto
    order by v.fecha_venta desc
    limit 5;
    
-- 6. Contar registros totales.

select 
	count(id_producto) as total_productos
    from productos;
    
-- 7. Calcular promedio, minimo o maximo de una columna numerica.
select 
	avg(precio) as precio_promedio,
    min(precio) as precio_minimo,
    max(precio) as precio_mayor
from productos;

-- 8. Agrupar registros con `GROUP BY`.
-- ************************************ |
-- ventas agrupadas por productos.      |
-- ==================================== |

select 
v.id_venta,
c.categoria_producto,
p.nombre_producto
from productos p 
inner join ventas v
	on v.id_producto = p.id_producto
inner join categorias c 
	on v.id_categoria = c.id_categoria
group by id_venta;

-- ****************************************************
-- contar ventas. 
-- ****************************************************
select 
    p.nombre_producto,
    count(v.id_venta) as total_ventas
from ventas v
inner join productos p
    on v.id_producto = p.id_producto
group by p.nombre_producto
order by total_ventas desc;

-- 9. Relacionar minimo dos tablas con `JOIN`.
-- productos y su categoria
describe productos;
describe categorias;

select 
	p.nombre_producto,
    p.precio,
    p.cantidad_producto,
    c.categoria_producto
    
	from productos p
    inner join categorias c
		on c.id_producto = p.id_producto
	order by p.nombre_producto;
    
-- 10. Crear una consulta con `WHERE`, `ORDER BY` y `LIMIT`.
describe ventas;

select 
    v.id_venta,
    v.fecha_venta,
    v.id_cliente
from ventas v
where v.id_cliente = 1
order by v.fecha_venta desc
limit 5;
    
    
-- 11. Crear un reporte con alias legibles para las columnas.

select 
    v.id_venta as Numero_Venta,
    c.nombre_cliente as Cliente,
    p.nombre_producto as Producto,
    v.fecha_venta as Fecha
from ventas v
inner join clientes c on v.id_cliente = c.id_cliente
inner join productos p on v.id_producto = p.id_producto
order by v.fecha_venta desc;

-- 12. Crear una consulta que ayude a tomar una decision del negocio.

select 
    p.nombre_producto as Producto,
    count(v.id_venta) as Total_Ventas
from ventas v
inner join productos p on v.id_producto = p.id_producto
group by p.nombre_producto
order by Total_Ventas desc;
