-- Motor utilizado: Microsoft SQL Server
-- Martin D´addona - Pre-entrega N°4

USE Ventas_Tech_DB;
GO

-- Consulta 1: Resumen mensual
SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- Consulta 2: Ranking de productos
SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

-- Consulta 3: Clientes recurrentes
SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

-- Consulta 4: Comparacion con el promedio mensual
-- M3 solo tiene marzo; por eso ese mes queda igual al promedio.
SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE
        WHEN SUM(cantidad * precio_unitario) > (
            SELECT SUM(cantidad * precio_unitario)
                   / COUNT(DISTINCT MONTH(fecha_venta))
            FROM ventas
        ) THEN 'Por encima'
        WHEN SUM(cantidad * precio_unitario) < (
            SELECT SUM(cantidad * precio_unitario)
                   / COUNT(DISTINCT MONTH(fecha_venta))
            FROM ventas
        ) THEN 'Por debajo'
        ELSE 'Igual al promedio'
    END AS comparacion_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- Hallazgos
-- 1. En marzo se facturaron 6444.00 en 10 pedidos, con un ticket
--    promedio de 644.40.
-- 2. El producto 1 fue el que mas facturo: 3600.00 y 3 unidades.
--    Conviene cuidar su disponibilidad.
-- 3. Los 5 clientes hicieron 2 pedidos cada uno. El cliente 1 gasto
--    mas, con 2640.00; conviene mantener su recompra.
