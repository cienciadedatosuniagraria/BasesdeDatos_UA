-- =====================================================================
-- Curso Bases de datos · UNIAGRARIA
-- Anexo A2. Script base del caso AgroDatos · PostgreSQL 16
-- Crea las siete tablas del modelo de la Unidad 1 con sus restricciones
-- y carga datos de ejemplo ficticios.
-- Ejecútelo en una base de datos vacía. Si la base ya existe, el script
-- la elimina y la vuelve a crear.
-- =====================================================================
DROP SCHEMA IF EXISTS agro CASCADE;
CREATE SCHEMA agro;

CREATE TABLE agro.productor (
    id_productor  INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    documento     VARCHAR(20)  NOT NULL UNIQUE,
    nombre        VARCHAR(100) NOT NULL,
    telefono      VARCHAR(20),
    municipio     VARCHAR(60)  NOT NULL,
    fecha_ingreso DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE agro.finca (
    id_finca     INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_productor INTEGER NOT NULL
                 REFERENCES agro.productor (id_productor) ON DELETE RESTRICT,
    nombre       VARCHAR(100) NOT NULL,
    vereda       VARCHAR(80),
    area_ha      NUMERIC(8,2) NOT NULL CHECK (area_ha > 0)
);

CREATE TABLE agro.cultivo (
    id_cultivo   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_comun VARCHAR(60) NOT NULL,
    variedad     VARCHAR(60),
    ciclo_dias   INTEGER CHECK (ciclo_dias > 0)
);

CREATE TABLE agro.siembra (
    id_siembra    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_finca      INTEGER NOT NULL REFERENCES agro.finca (id_finca),
    id_cultivo    INTEGER NOT NULL REFERENCES agro.cultivo (id_cultivo),
    fecha_siembra DATE NOT NULL,
    area_ha       NUMERIC(8,2) NOT NULL CHECK (area_ha > 0)
);

CREATE TABLE agro.cosecha (
    id_cosecha    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_siembra    INTEGER NOT NULL REFERENCES agro.siembra (id_siembra),
    fecha         DATE NOT NULL,
    kg_cosechados NUMERIC(10,2) NOT NULL CHECK (kg_cosechados >= 0)
);

CREATE TABLE agro.comprador (
    id_comprador INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nit          VARCHAR(20)  NOT NULL UNIQUE,
    razon_social VARCHAR(120) NOT NULL,
    ciudad       VARCHAR(60)
);

CREATE TABLE agro.venta (
    id_venta     INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_cosecha   INTEGER NOT NULL REFERENCES agro.cosecha (id_cosecha),
    id_comprador INTEGER NOT NULL REFERENCES agro.comprador (id_comprador),
    fecha        DATE NOT NULL,
    kg           NUMERIC(10,2) NOT NULL CHECK (kg > 0),
    precio_kg    NUMERIC(10,2) NOT NULL CHECK (precio_kg > 0)
);

-- Datos de ejemplo (ficticios)
INSERT INTO agro.productor (documento, nombre, telefono, municipio) VALUES
  ('1072001', 'Ana Ruiz',   '3105550101', 'Zipaquirá'),
  ('2033045', 'Luis Mora',  '3205550102', 'Cogua'),
  ('1019087', 'Marta Gil',  NULL,         'Tabio'),
  ('8045112', 'Jorge Peña', '3005550104', 'Zipaquirá');

INSERT INTO agro.finca (id_productor, nombre, vereda, area_ha) VALUES
  (1, 'La Esperanza', 'El Rosal',    4.50),
  (2, 'El Porvenir',  'El Mortiño',  2.00),
  (3, 'Santa Inés',   'Río Frío',    3.20),
  (1, 'Los Alpes',    'San Jorge',   1.80);

INSERT INTO agro.cultivo (nombre_comun, variedad, ciclo_dias) VALUES
  ('papa',   'Pastusa suprema', 150),
  ('arveja', 'Santa Isabel',     90),
  ('fresa',  'Albión',          120);

INSERT INTO agro.siembra (id_finca, id_cultivo, fecha_siembra, area_ha) VALUES
  (1, 1, '2025-01-10', 3.00),
  (1, 2, '2025-02-01', 1.50),
  (2, 3, '2024-12-15', 2.00),
  (3, 1, '2025-01-20', 3.20),
  (4, 1, '2025-02-05', 1.80);

INSERT INTO agro.cosecha (id_siembra, fecha, kg_cosechados) VALUES
  (1, '2025-06-12', 54000),
  (2, '2025-05-05',  9000),
  (3, '2025-04-20', 30000),
  (4, '2025-06-25', 48000),
  (5, '2025-07-08', 27000);

INSERT INTO agro.comprador (nit, razon_social, ciudad) VALUES
  ('900123456', 'AgroCentro S.A.S.',     'Bogotá'),
  ('901234567', 'Mercados Sabana Ltda.', 'Chía'),
  ('800765432', 'Frutas del Altiplano',  'Zipaquirá');

INSERT INTO agro.venta (id_cosecha, id_comprador, fecha, kg, precio_kg) VALUES
  (1, 1, '2025-06-14', 30000, 1900),
  (1, 2, '2025-06-20', 20000, 2000),
  (2, 2, '2025-05-07',  8500, 3200),
  (3, 3, '2025-04-22', 15000, 6800),
  (3, 1, '2025-05-02', 14000, 7000),
  (4, 1, '2025-06-27', 25000, 1850),
  (4, 3, '2025-07-03', 20000, 1950),
  (5, 2, '2025-07-10', 26000, 2100);
