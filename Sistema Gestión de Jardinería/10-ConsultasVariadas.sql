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