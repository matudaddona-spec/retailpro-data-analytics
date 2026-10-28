-- Motor utilizado: Microsoft SQL Server
-- Martin D´addona - Pre-entrega N°5

USE Ventas_Tech_DB;
GO

-- Consulta 1: Vista base del proyecto (INNER JOIN)
-- Propósito: reunir las ventas con cliente, producto, categoría y ciudad.
SELECT
    v.id_venta,
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS cliente,
    c.ciudad,
    p.id_producto,
    p.nombre_producto AS producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM ventas v
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta, v.id_venta;
-- Hallazgo: aparecen las 10 ventas con sus datos descriptivos,
-- por un total de 6444.00.

-- Consulta 2: Clientes sin ventas (LEFT JOIN)
-- Propósito: buscar clientes sin primera compra para el área de CRM.
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL
ORDER BY c.nombre;
-- Hallazgo: aparecen 0 clientes sin ventas; los 5 ya compraron.
-- CRM no tiene clientes sin primera compra para contactar en esta base.

-- Consulta 3: Productos sin ventas (LEFT JOIN)
-- Propósito: detectar artículos sin movimiento para el área de producto.
SELECT
    p.nombre_producto AS producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos p
LEFT JOIN ventas v ON p.id_producto = v.id_producto
LEFT JOIN categorias cat ON p.id_categoria = cat.id_categoria
WHERE v.id_venta IS NULL
ORDER BY p.nombre_producto;
-- Hallazgo: aparecen 0 productos sin ventas; los 6 tuvieron movimiento.
-- El área de producto no detecta artículos sin ventas en estos datos.

-- Consulta 4: Consolidado por canal (UNION ALL)
-- Propósito: comparar dos períodos de marzo de 2024.
-- Canal es la etiqueta del período, no un canal de venta real.
SELECT canal, SUM(total) AS total_canal
FROM (
    SELECT fecha_venta, cantidad * precio_unitario AS total,
           'Del 1 al 10 de marzo' AS canal
    FROM ventas
    WHERE fecha_venta >= '20240301' AND fecha_venta < '20240311'

    UNION ALL

    SELECT fecha_venta, cantidad * precio_unitario AS total,
           'Del 11 al 31 de marzo' AS canal
    FROM ventas
    WHERE fecha_venta >= '20240311' AND fecha_venta < '20240401'
) AS consolidado
GROUP BY canal
ORDER BY total_canal DESC;
-- Hallazgo: el primer período suma 3620.00 y el segundo 2824.00.
-- El primero aporta 796.00 más de facturación.
