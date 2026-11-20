-- =====================================================================
-- Curso Bases de datos · UNIAGRARIA
-- Anexo A2. Script base del caso AgroDatos · MySQL 8.0
-- Crea las siete tablas del modelo de la Unidad 1 con sus restricciones
-- y carga datos de ejemplo ficticios.
-- Ejecútelo en una base de datos vacía. Si la base ya existe, el script
-- la elimina y la vuelve a crear.
-- =====================================================================
DROP DATABASE IF EXISTS agrodatos;
CREATE DATABASE agrodatos CHARACTER SET utf8mb4;
USE agrodatos;

CREATE TABLE productor (
    id_productor  INT AUTO_INCREMENT PRIMARY KEY,
    documento     VARCHAR(20)  NOT NULL UNIQUE,
    nombre        VARCHAR(100) NOT NULL,
    telefono      VARCHAR(20),
    municipio     VARCHAR(60)  NOT NULL,
    fecha_ingreso DATE NOT NULL DEFAULT (CURRENT_DATE)
) ENGINE = InnoDB;

CREATE TABLE finca (
    id_finca     INT AUTO_INCREMENT PRIMARY KEY,
    id_productor INT NOT NULL,
    nombre       VARCHAR(100) NOT NULL,
    vereda       VARCHAR(80),
    area_ha      DECIMAL(8,2) NOT NULL CHECK (area_ha > 0),
    -- En MySQL la clave foránea se declara a nivel de tabla:
    -- si se escribe REFERENCES junto a la columna, el gestor la ignora.
    CONSTRAINT fk_finca_productor FOREIGN KEY (id_productor)
        REFERENCES productor (id_productor) ON DELETE RESTRICT
) ENGINE = InnoDB;

CREATE TABLE cultivo (
    id_cultivo   INT AUTO_INCREMENT PRIMARY KEY,
    nombre_comun VARCHAR(60) NOT NULL,
    variedad     VARCHAR(60),
    ciclo_dias   INT CHECK (ciclo_dias > 0)
) ENGINE = InnoDB;

CREATE TABLE siembra (
    id_siembra    INT AUTO_INCREMENT PRIMARY KEY,
    id_finca      INT NOT NULL,
    id_cultivo    INT NOT NULL,
    fecha_siembra DATE NOT NULL,
    area_ha       DECIMAL(8,2) NOT NULL CHECK (area_ha > 0),
    FOREIGN KEY (id_finca)   REFERENCES finca (id_finca),
    FOREIGN KEY (id_cultivo) REFERENCES cultivo (id_cultivo)
) ENGINE = InnoDB;

CREATE TABLE cosecha (
    id_cosecha    INT AUTO_INCREMENT PRIMARY KEY,
    id_siembra    INT NOT NULL,
    fecha         DATE NOT NULL,
    kg_cosechados DECIMAL(10,2) NOT NULL CHECK (kg_cosechados >= 0),
    FOREIGN KEY (id_siembra) REFERENCES siembra (id_siembra)
) ENGINE = InnoDB;

CREATE TABLE comprador (
    id_comprador INT AUTO_INCREMENT PRIMARY KEY,
    nit          VARCHAR(20)  NOT NULL UNIQUE,
    razon_social VARCHAR(120) NOT NULL,
    ciudad       VARCHAR(60)
) ENGINE = InnoDB;

CREATE TABLE venta (
    id_venta     INT AUTO_INCREMENT PRIMARY KEY,
    id_cosecha   INT NOT NULL,
    id_comprador INT NOT NULL,
    fecha        DATE NOT NULL,
    kg           DECIMAL(10,2) NOT NULL CHECK (kg > 0),
    precio_kg    DECIMAL(10,2) NOT NULL CHECK (precio_kg > 0),
    FOREIGN KEY (id_cosecha)   REFERENCES cosecha (id_cosecha),
    FOREIGN KEY (id_comprador) REFERENCES comprador (id_comprador)
) ENGINE = InnoDB;

-- Datos de ejemplo (ficticios)
INSERT INTO productor (documento, nombre, telefono, municipio) VALUES
  ('1072001', 'Ana Ruiz',   '3105550101', 'Zipaquirá'),
  ('2033045', 'Luis Mora',  '3205550102', 'Cogua'),
  ('1019087', 'Marta Gil',  NULL,         'Tabio'),
  ('8045112', 'Jorge Peña', '3005550104', 'Zipaquirá');

INSERT INTO finca (id_productor, nombre, vereda, area_ha) VALUES
  (1, 'La Esperanza', 'El Rosal',   4.50),
  (2, 'El Porvenir',  'El Mortiño', 2.00),
  (3, 'Santa Inés',   'Río Frío',   3.20),
  (1, 'Los Alpes',    'San Jorge',  1.80);

INSERT INTO cultivo (nombre_comun, variedad, ciclo_dias) VALUES
  ('papa',   'Pastusa suprema', 150),
  ('arveja', 'Santa Isabel',     90),
  ('fresa',  'Albión',          120);

INSERT INTO siembra (id_finca, id_cultivo, fecha_siembra, area_ha) VALUES
  (1, 1, '2025-01-10', 3.00),
  (1, 2, '2025-02-01', 1.50),
  (2, 3, '2024-12-15', 2.00),
  (3, 1, '2025-01-20', 3.20),
  (4, 1, '2025-02-05', 1.80);

INSERT INTO cosecha (id_siembra, fecha, kg_cosechados) VALUES
  (1, '2025-06-12', 54000),
  (2, '2025-05-05',  9000),
  (3, '2025-04-20', 30000),
  (4, '2025-06-25', 48000),
  (5, '2025-07-08', 27000);

INSERT INTO comprador (nit, razon_social, ciudad) VALUES
  ('900123456', 'AgroCentro S.A.S.',     'Bogotá'),
  ('901234567', 'Mercados Sabana Ltda.', 'Chía'),
  ('800765432', 'Frutas del Altiplano',  'Zipaquirá');

INSERT INTO venta (id_cosecha, id_comprador, fecha, kg, precio_kg) VALUES
  (1, 1, '2025-06-14', 30000, 1900),
  (1, 2, '2025-06-20', 20000, 2000),
  (2, 2, '2025-05-07',  8500, 3200),
  (3, 3, '2025-04-22', 15000, 6800),
  (3, 1, '2025-05-02', 14000, 7000),
  (4, 1, '2025-06-27', 25000, 1850),
  (4, 3, '2025-07-03', 20000, 1950),
  (5, 2, '2025-07-10', 26000, 2100);
