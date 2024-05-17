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