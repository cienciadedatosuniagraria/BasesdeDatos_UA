-- =====================================================================
-- Curso Bases de datos · UNIAGRARIA
-- Anexo A3. Carga de 100 000 ventas sintéticas · PostgreSQL 16
-- Requisito: haber ejecutado antes el script base del Anexo A2 (o la base
-- de su Actividad 2 con, al menos, 5 cosechas y 3 compradores).
-- Use una base de práctica: el script agrega 100 000 filas a la tabla venta.
-- =====================================================================
SET search_path TO agro;

INSERT INTO venta (id_cosecha, id_comprador, fecha, kg, precio_kg)
SELECT 1 + (g % 5),                      -- cosecha entre 1 y 5
       1 + (g % 3),                      -- comprador entre 1 y 3
       DATE '2023-01-01' + (g % 900),    -- fechas entre 2023 y mediados de 2025
       100 + (g % 400),                  -- entre 100 y 499 kg
       1500 + (g % 900)                  -- entre 1500 y 2399 pesos por kilo
FROM   generate_series(1, 100000) AS g;

-- Actualiza las estadísticas que usa el optimizador
ANALYZE venta;

-- Comprobación
SELECT COUNT(*) AS total_ventas, MIN(fecha) AS desde, MAX(fecha) AS hasta FROM venta;

-- Plan de ejecución de partida (antes de crear cualquier índice)
EXPLAIN ANALYZE
SELECT * FROM venta WHERE fecha BETWEEN '2024-03-01' AND '2024-03-31';
