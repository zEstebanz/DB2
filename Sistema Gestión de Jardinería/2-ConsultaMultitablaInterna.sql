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