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