use jardin;

-- ¿Cuántos empleados hay en la compañía?
select count(*) as total_de_empleados
from empleado e;

-- ¿Cuántos clientes tiene cada país?

select pais, count(*) as total_clientes
from cliente c 
group by pais;

-- ¿Cuál fue el pago medio en 2009?

select avg(total) as pago_medio_2009
from pago p 
where year(fecha_pago) = 2009;

-- ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.

select estado, count(*) as total_pedidos
from pedido p 
group by estado 
order by total_pedidos desc;

-- Calcula el precio de venta del producto más caro y más barato en una misma consulta.

select MAX(precio_venta) as precio_mas_caro, min(precio_venta) as precio_mas_barato
from producto;

-- Calcula el número de clientes que tiene la empresa.

select count(*) as total_clientes
from cliente;

-- ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?

select count(*) as cliente_madrid
from cliente c 
where ciudad = 'madrid';

-- ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?

select ciudad, count(*) as total_cliente
from cliente c 
where ciudad like 'M%'
group by ciudad;

-- Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.

select e.nombre, e.apellido1, count(c.codigo_cliente) as total_clientes
from empleado e
left join cliente c on e.codigo_empleado = c.codigo_empleado_rep_ventas
group by e.codigo_empleado;

-- Calcula el número de clientes que no tiene asignado representante de ventas.

select count(*) as clientes_sin_representante
from cliente
where codigo_empleado_rep_ventas is null;

-- Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.

select c.nombre_cliente, c.nombre_contacto, c.apellido_contacto, 
       min(p.fecha_pago) as primer_pago, max(p.fecha_pago) as ultimo_pago
from cliente c
left join pago p on c.codigo_cliente = p.codigo_cliente
group by c.codigo_cliente;

-- Calcula el número de productos diferentes que hay en cada uno de los pedidos.

select codigo_pedido, count(distinct codigo_producto) as productos_diferentes
from detalle_pedido
group by codigo_pedido;

-- Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.

select codigo_pedido, sum(cantidad) as cantidad_total_productos
from detalle_pedido
group by codigo_pedido;

-- Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. El listado deberá estar ordenado por el número total de unidades vendidas.

select codigo_producto, sum(cantidad) as total_unidades_vendidas
from detalle_pedido
group by codigo_producto
order by total_unidades_vendidas desc
limit 20;
-- La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total facturado. La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.
select 
    sum(p.precio_venta * dp.cantidad) as base_imponible,
    sum(p.precio_venta * dp.cantidad) * 0.21 as iva,
    sum(p.precio_venta * dp.cantidad) + (sum(p.precio_venta * dp.cantidad) * 0.21) as total_facturado
from detalle_pedido dp
inner join producto p on dp.codigo_producto = p.codigo_producto;

-- La misma información que en la pregunta anterior, pero agrupada por código de producto.
select 
    dp.codigo_producto,
    sum(p.precio_venta * dp.cantidad) as base_imponible,
    sum(p.precio_venta * dp.cantidad) * 0.21 as iva,
    sum(p.precio_venta * dp.cantidad) + (sum(p.precio_venta * dp.cantidad) * 0.21) as total_facturado
from detalle_pedido dp
inner join producto p on dp.codigo_producto = p.codigo_producto
group by dp.codigo_producto;

-- Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre, unidades vendidas, total facturado y total facturado con impuestos (21% IVA).
select 
    p.nombre,
    sum(dp.cantidad) as unidades_vendidas,
    sum(p.precio_venta * dp.cantidad) as total_facturado,
    sum(p.precio_venta * dp.cantidad * 0.21) as total_iva,
    sum(p.precio_venta * dp.cantidad) + (sum(p.precio_venta * dp.cantidad * 0.21)) as total_con_iva
from detalle_pedido dp
inner join producto p on dp.codigo_producto = p.codigo_producto
group by p.codigo_producto
having total_facturado > 3000;

-- Muestre la suma total de todos los pagos que se realizaron para cada uno de los años que aparecen en la tabla pagos.
select year(fecha_pago) as año, sum(total) as total_pagado
from pago
group by year(fecha_pago);