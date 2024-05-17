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