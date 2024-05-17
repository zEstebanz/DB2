-- 1
use jardin;

-- Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

SELECT codigo_oficina, ciudad
FROM oficina;

-- Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

SELECT ciudad, telefono
FROM oficina
WHERE pais = 'España';

-- Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.

SELECT e.nombre, e.apellido1, e.apellido2, e.email
FROM empleado e
WHERE e.codigo_jefe = 7;

-- Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.

SELECT puesto, nombre, apellido1, apellido2, email
FROM empleado e
WHERE e.codigo_jefe IS NULL;

-- Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.

SELECT nombre, apellido1, apellido2, puesto
FROM empleado
WHERE puesto = 'Representante Ventas';

-- Devuelve un listado con el nombre de los todos los clientes españoles.

SELECT nombre_cliente
FROM cliente
WHERE pais = 'Spain';

-- Devuelve un listado con los distintos estados por los que puede pasar un pedido.

SELECT distinct estado
FROM pedido;

-- Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:

-- Utilizando la función YEAR de MySQL.

SELECT DISTINCT codigo_cliente
FROM pago
WHERE YEAR(fecha_pago) = 2008;

-- Utilizando la función DATE_FORMAT de MySQL.

SELECT DISTINCT codigo_cliente
FROM pago
WHERE DATE_FORMAT(fecha_pago, '%Y') = '2008';

-- Sin utilizar ninguna de las funciones anteriores.

SELECT DISTINCT codigo_cliente
FROM pago
WHERE fecha_pago >= '2008-01-01' AND fecha_pago < '2009-01-01';

-- Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega > fecha_esperada;

-- Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega < ADDDATE(fecha_esperada, -2);

-- Utilizando la función DATEDIFF de MySQL:

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE DATEDIFF(fecha_esperada, fecha_entrega) >= 2;

-- Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega > fecha_esperada;


-- Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

SELECT *
FROM pago
WHERE YEAR(fecha_pago) = 2008 AND forma_pago = 'Paypal'
ORDER BY total DESC;


-- Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.

SELECT DISTINCT forma_pago
FROM pago;

-- Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
SELECT *
FROM producto
WHERE gama = 'Ornamentales' AND cantidad_en_stock > 100
ORDER BY precio_venta DESC;

-- Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.

SELECT *
FROM cliente
WHERE ciudad = 'Madrid' AND (codigo_empleado_rep_ventas = 11 OR codigo_empleado_rep_ventas = 30);
-- 2

USE jardin;

-- Consultas multitabla (Composición interna)
-- Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con sintaxis
-- de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.

-- 1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.

SELECT c.nombre_cliente, e.nombre, e.apellido1
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;

-- 2 Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.

SELECT c.nombre_cliente, e.nombre, e.apellido1
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente;

-- 3 Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.

SELECT c.nombre_cliente, e.nombre, e.apellido1
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE NOT EXISTS (
    SELECT 1 FROM pago p WHERE p.codigo_cliente = c.codigo_cliente
);

-- 4Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes
-- junto con la ciudad de la oficina a la que pertenece el representante.
-- Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes
-- junto con la ciudad de la oficina a la que pertenece el representante.

SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante, o.ciudad AS ciudad_oficina
FROM cliente c
INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

-- 5 Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante, o.ciudad AS ciudad_oficina
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE p.codigo_cliente IS NULL;

-- 6 Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

SELECT DISTINCT ofi.linea_direccion1, ofi.linea_direccion2, ofi.ciudad, ofi.pais, ofi.region, ofi.codigo_postal, ofi.telefono
FROM oficina ofi
INNER JOIN empleado e ON ofi.codigo_oficina = e.codigo_oficina
INNER JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.ciudad = 'Fuenlabrada';

-- 7 Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad 
-- de la oficina a la que pertenece el representante.

SELECT c.nombre_cliente, e.nombre AS nombre_representante, e.apellido1 AS apellido_representante, o.ciudad AS ciudad_oficina
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

-- 8 Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.

SELECT e1.nombre AS nombre_empleado, e2.nombre AS nombre_jefe
FROM empleado e1
LEFT JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado;

-- 9 Devuelve un listado que muestre el nombre de cada empleado, el nombre de su jefe y el
-- nombre del jefe de sus jefes.

SELECT e1.nombre AS nombre_empleado, 
       e2.nombre AS nombre_jefe, 
       e3.nombre AS nombre_jefe_jefe
FROM empleado e1
LEFT JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado
LEFT JOIN empleado e3 ON e2.codigo_jefe = e3.codigo_empleado;

-- 10 Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.

SELECT DISTINCT c.nombre_cliente
FROM cliente c
INNER JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE p.fecha_entrega IS NULL OR p.fecha_entrega > p.fecha_esperada;

-- 11 Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.

SELECT c.nombre_cliente, GROUP_CONCAT(DISTINCT pr.gama ORDER BY pr.gama) AS gamas_compradas
FROM cliente c
INNER JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente
INNER JOIN detalle_pedido dp ON pe.codigo_pedido = dp.codigo_pedido
INNER JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
GROUP BY c.nombre_cliente;

--3 

use jardin;

-- Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.

SELECT c.*
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL;

-- Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.

SELECT c.*
FROM cliente c
LEFT JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente
WHERE pe.codigo_pedido IS NULL;

-- Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.

SELECT c.*
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
LEFT JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente
WHERE p.codigo_cliente IS NULL OR pe.codigo_pedido IS NULL;

-- Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.

SELECT e.*
FROM empleado e
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE o.codigo_oficina IS NULL;

-- Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.

SELECT e.*
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_cliente IS NULL;

-- Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.

SELECT e.*, o.*
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE c.codigo_cliente IS NULL;

-- Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.

SELECT e.*
FROM empleado e
LEFT JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE o.codigo_oficina IS NULL OR c.codigo_cliente IS NULL;

-- Devuelve un listado de los productos que nunca han aparecido en un pedido.

SELECT p.*
FROM producto p
LEFT JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
WHERE dp.codigo_producto IS NULL;

-- Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre, la descripción y la imagen del producto.

SELECT p.nombre, p.descripcion
FROM producto p
LEFT JOIN detalle_pedido dp ON p.codigo_producto = dp.codigo_producto
WHERE dp.codigo_producto IS NULL;

-- Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
SELECT DISTINCT o.*
FROM oficina o
LEFT JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
LEFT JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente
LEFT JOIN detalle_pedido dp ON pe.codigo_pedido = dp.codigo_pedido
LEFT JOIN producto p ON dp.codigo_producto = p.codigo_producto
WHERE p.gama = 'Frutales' AND e.codigo_empleado IS NULL;

-- Devuelve un listado con los clientes que han realizado algún pedido, pero no han realizado ningún pago.

SELECT DISTINCT c.*
FROM cliente c
LEFT JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE pe.codigo_pedido IS NOT NULL AND p.codigo_cliente IS NULL;

-- Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.

SELECT e.*, e2.nombre AS nombre_jefe, e2.apellido1 AS apellido_jefe
FROM empleado e
LEFT JOIN empleado e2 ON e.codigo_jefe = e2.codigo_empleado
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_cliente IS NULL;

-- 4

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

-- 6

use jardin;

-- Devuelve el nombre del cliente con mayor límite de crédito:

SELECT nombre_cliente
FROM cliente
WHERE limite_credito = (SELECT MAX(limite_credito) FROM cliente);

-- Devuelve el nombre del producto que tenga el precio de venta más caro:

SELECT nombre
FROM producto
WHERE precio_venta = (SELECT MAX(precio_venta) FROM producto);

-- Devuelve el nombre del producto del que se han vendido más unidades:

SELECT p.nombre
FROM producto p
INNER JOIN (
    SELECT codigo_producto, SUM(cantidad) AS total_unidades_vendidas
    FROM detalle_pedido
    GROUP BY codigo_producto
    ORDER BY total_unidades_vendidas DESC
    LIMIT 1
) dp ON p.codigo_producto = dp.codigo_producto;

-- Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado:

SELECT nombre_cliente
FROM cliente
WHERE limite_credito > (SELECT SUM(total) FROM pago WHERE codigo_cliente = cliente.codigo_cliente);

-- Devuelve el producto que más unidades tiene en stock:

SELECT nombre
FROM producto
WHERE cantidad_en_stock = (SELECT MAX(cantidad_en_stock) FROM producto);

-- Devuelve el producto que menos unidades tiene en stock:

SELECT nombre
FROM producto
WHERE cantidad_en_stock = (SELECT MIN(cantidad_en_stock) FROM producto);

-- Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria:

SELECT nombre, apellido1, apellido2, email
FROM empleado
WHERE codigo_jefe = (
    SELECT codigo_empleado
    FROM empleado
    WHERE nombre = 'Alberto' AND apellido1 = 'Soria'
);

-- 7

-- Devuelve el nombre del cliente con mayor límite de crédito.

SELECT nombre_cliente
FROM cliente
WHERE limite_credito >= ALL (
    SELECT MAX(limite_credito)
    FROM cliente
);

-- Devuelve el nombre del producto que tenga el precio de venta más caro.

SELECT nombre
FROM producto
WHERE precio_venta >= ANY (
    SELECT MAX(precio_venta)
    FROM producto
);

-- Devuelve el producto que menos unidades tiene en stock.

SELECT nombre
FROM producto
WHERE cantidad_en_stock <= ANY (
    SELECT MIN(cantidad_en_stock)
    FROM producto
);

-- 8 
-- Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.

SELECT nombre, apellido1 as apellido, puesto
FROM empleado
WHERE codigo_empleado NOT IN (
    SELECT codigo_empleado_rep_ventas
    FROM cliente
);

-- Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.

SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente NOT IN (
    SELECT codigo_cliente
    FROM pago
);

-- Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.

SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente IN (
    SELECT codigo_cliente
    FROM pago
);

-- Devuelve un listado de los productos que nunca han aparecido en un pedido.

SELECT distinct nombre
FROM producto
WHERE codigo_producto NOT IN (
    SELECT codigo_producto
    FROM detalle_pedido
);

-- Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.

SELECT e.nombre, e.apellido1, e.apellido2, e.puesto, o.telefono 
FROM empleado e
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE codigo_empleado NOT IN (
    SELECT codigo_empleado_rep_ventas
    FROM cliente
);


-- Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.

SELECT distinct o.*
FROM oficina o
INNER JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
WHERE codigo_empleado NOT IN (
    SELECT codigo_empleado_rep_ventas
    FROM cliente c
    INNER JOIN pedido pd ON c.codigo_cliente = pd.codigo_cliente
    INNER JOIN detalle_pedido dp ON pd.codigo_pedido =  dp.codigo_pedido
    INNER JOIN producto p ON dp.codigo_producto = p.codigo_producto
    INNER JOIN gama_producto gp ON p.gama = gp.gama
    WHERE gp.gama = 'Frutales'
);

-- Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.

SELECT distinct c.nombre_cliente, c.codigo_cliente as id
FROM cliente c
INNER JOIN pedido pd ON c.codigo_cliente = pd.codigo_cliente
INNER JOIN pago pg ON c.codigo_cliente = pg.codigo_cliente
WHERE c.codigo_cliente IN (
    SELECT codigo_cliente
    FROM pedido
) AND c.codigo_cliente NOT IN(
    SELECT codigo_cliente
    FROM pago
);

-- 9

-- Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.

SELECT distinct nombre_cliente, codigo_cliente as id
FROM cliente c
WHERE NOT EXISTS (
    SELECT 1
    FROM pago pg  
    WHERE pg.codigo_cliente = c.codigo_cliente
);

-- Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.

SELECT distinct nombre_cliente, codigo_cliente as id
FROM cliente c
WHERE EXISTS (
    SELECT 1
    FROM pago pg  
    WHERE pg.codigo_cliente = c.codigo_cliente
);

-- Devuelve un listado de los productos que nunca han aparecido en un pedido.

SELECT distinct nombre, codigo_producto as id
FROM producto p
WHERE NOT EXISTS (
    SELECT 1
    FROM detalle_pedido dp
    INNER JOIN pedido pd ON pd.codigo_pedido = dp.codigo_pedido
    WHERE dp.codigo_producto = p.codigo_producto
    AND pd.codigo_pedido = dp.codigo_pedido
);

-- Devuelve un listado de los productos que han aparecido en un pedido alguna vez.

SELECT distinct nombre, codigo_producto as id
FROM producto p
WHERE EXISTS (
    SELECT 1
    FROM detalle_pedido dp
    INNER JOIN pedido pd ON pd.codigo_pedido = dp.codigo_pedido
    WHERE dp.codigo_producto = p.codigo_producto
    AND pd.codigo_pedido = dp.codigo_pedido
);

-- 10

-- Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizar.Tenga en cuenta que pueden existir clientes que no han realizado ningún pedido.

SELECT c.nombre_cliente, count(pd.codigo_pedido) as cantidad_pedidos
FROM cliente c
LEFT JOIN pedido pd ON c.codigo_cliente = pd.codigo_cliente
GROUP BY c.nombre_cliente;

-- Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han realizado ningún pago.

SELECT c.nombre_cliente, SUM(pg.total) as total_pagado
FROM cliente c
LEFT JOIN pago pg ON c.codigo_cliente = pg.codigo_cliente
GROUP BY c.nombre_cliente;

-- Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.

SELECT distinct nombre_cliente
FROM cliente c
INNER JOIN pedido pd ON c.codigo_cliente = pd.codigo_cliente
WHERE YEAR(pd.fecha_pedido) = 2008
ORDER BY c.nombre_cliente asc;

-- Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y el número de teléfono de la oficina del representante de ventas, de aquellos clientes que no hayan realizado ningún pago.

SELECT DISTINCT c.nombre_cliente, e.nombre as nombre_empleado, e.apellido1 as apellido_empleado, o.telefono as contacto_oficina 
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
LEFT JOIN pago pg ON c.codigo_cliente = pg.codigo_cliente
WHERE pg.codigo_cliente IS NULL;

-- Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer apellido de su representante de ventas y la ciudad donde está su oficina.

SELECT c.nombre_cliente, e.nombre as nombre_empleado, e.apellido1 as apellido_empleado, o.ciudad as ciudad_oficina
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

-- Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.

SELECT e.nombre, e.apellido1, e.apellido2, e.puesto, o.telefono
FROM empleado e
INNER JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE e.codigo_empleado NOT IN (
    SELECT DISTINCT codigo_empleado_rep_ventas
    FROM cliente
    WHERE codigo_empleado_rep_ventas IS NOT NULL
);

-- Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene.

SELECT o.ciudad, COUNT(e.codigo_empleado) as num_empleados
FROM oficina o
LEFT JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
GROUP BY o.ciudad;