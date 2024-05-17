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