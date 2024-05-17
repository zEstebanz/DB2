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
--  Utilizando la función YEAR de MySQL.

SELECT DISTINCT codigo_cliente
FROM pago
WHERE YEAR(fecha_pago) = 2008;

--  Utilizando la función DATE_FORMAT de MySQL.

SELECT DISTINCT codigo_cliente
FROM pago
WHERE DATE_FORMAT(fecha_pago, '%Y') = '2008';

--  Sin utilizar ninguna de las funciones anteriores.

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