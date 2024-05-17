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