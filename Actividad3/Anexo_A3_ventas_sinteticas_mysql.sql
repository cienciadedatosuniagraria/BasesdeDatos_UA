-- =====================================================================
-- Curso Bases de datos · UNIAGRARIA
-- Anexo A3. Carga de 100 000 ventas sintéticas · MySQL 8.0
-- Requisito: haber ejecutado antes el script base del Anexo A2 (o la base
-- de su Actividad 2 con, al menos, 5 cosechas y 3 compradores).
-- Use una base de práctica: el script agrega 100 000 filas a la tabla venta.
-- =====================================================================
USE agrodatos;

-- MySQL limita por defecto la recursión de una CTE a 1000 niveles
SET SESSION cte_max_recursion_depth = 100001;

INSERT INTO venta (id_cosecha, id_comprador, fecha, kg, precio_kg)
WITH RECURSIVE g (n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM g WHERE n < 100000
)
SELECT 1 + (n % 5),                                   -- cosecha entre 1 y 5
       1 + (n % 3),                                   -- comprador entre 1 y 3
       DATE_ADD('2023-01-01', INTERVAL (n % 900) DAY),
       100 + (n % 400),                               -- entre 100 y 499 kg
       1500 + (n % 900)                               -- entre 1500 y 2399 pesos por kilo
FROM g;

-- Actualiza las estadísticas que usa el optimizador
ANALYZE TABLE venta;

-- Comprobación
SELECT COUNT(*) AS total_ventas, MIN(fecha) AS desde, MAX(fecha) AS hasta FROM venta;

-- Plan de ejecución de partida (antes de crear cualquier índice; requiere MySQL 8.0.18 o superior)
EXPLAIN ANALYZE
SELECT * FROM venta WHERE fecha BETWEEN '2024-03-01' AND '2024-03-31';
