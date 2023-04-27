-- CREAMOS BASE DE DATOS
CREATE DATABASE Sprint_telovendo;

-- EJECUTAMOS BASE DE DATOS
USE Sprint_telovendo;

-- CREAMOS TABLAS:
-- TABLA CLIENTE, SE AGREGA MAS PARA HACER MAS COMPLETA LA INFO
CREATE TABLE cliente (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  nombres VARCHAR(255) NOT NULL,
  apellidos VARCHAR(255) NOT NULL,
  telefono VARCHAR (12),
  direccion VARCHAR(255),
  comuna VARCHAR(100)
);
-- TABLA PRODUCTO
CREATE TABLE producto (
  SKU VARCHAR(255) NOT NULL UNIQUE,
  nombre VARCHAR(255) NOT NULL,
  categoria VARCHAR(255) NOT NULL,
  Proveedor VARCHAR(255) NOT NULL,
  Color ENUM ('ROJO', 'AMARILLO', 'AZUL', 'BLANCO', 'GRIS', 'NEGRO', 'VERDE', 'CYAN', 'MAGENTA', 'ROSADO', 'PURPURA', 'VIOLETA', 'FUCSIA', 'CAFE') NOT NULL,
  Stock INT NOT NULL
	foreign key  (Proveedor) references proveedor(id);
);
-- TABLA PROVEEDOR
CREATE TABLE proveedor (
  id INT AUTO_INCREMENT PRIMARY KEY,
  representante_legal VARCHAR(255) NOT NULL,
  nombre_corporativo VARCHAR(255) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  telefono2 VARCHAR(20) NOT NULL,
  nombre_contacto VARCHAR(255) NOT NULL,
  categoria VARCHAR(50) NOT NULL,
  correo_facturacion VARCHAR(255) NOT NULL
);
-- CREACIÓN DE USUARIO Y PERMISOS
CREATE USER 'admintienda'@'localhost' IDENTIFIED BY 'admintienda';
GRANT ALL PRIVILEGES ON Sprint_telovendo.* TO 'admintienda'@'localhost';

-- TABLA PRODUCTOS INFO: 
-- 10 CLIENTES
INSERT INTO cliente (nombres, apellidos, telefono, direccion, comuna) 
VALUES 	('Ignacio Simon', 'Perez Lastra', '+56912345678', 'San Pablo 123', 'Vitacura'),
	('Eduardo Ricardo', 'Rockefeler Soto', '+56943245678', 'San Pedro 321', 'Las Condes'),
        ('Harry Edgard', 'Potter Rodriguez', '+56912654678', 'Providencia 23', 'Providencia'),
        ('Hermione Sandra', 'Granger Sotomayor', '+56912345123', 'Alvarez 666', 'Viña del mar'),
        ('Ron Vodka', 'Weasly Ramirez', '+56965435678', 'Limache 65', 'Viña del mar'),
        ('Albus Peter', 'Dumbledore Lastra', '+56912765438', 'Londres 43', 'Peñablanca'),
        ('Sasha Ignacia', 'Grey Perez', '+56918765678', 'Liverpool 89', 'Temuco'),
        ('Severus Adolfo', 'Snape Pinochet', '+56917655678', 'Valparaiso 1314', 'Santiago'),
        ('Minerva Marcela', 'McGonagall Veas', '+56976895678', 'Blanco Encalada 154', 'Quilpue'),
        ('Homero Jay', 'Simpson Simpson', '+56979685678', 'Avenida Siempreviva 742', 'Springfield');

-- 20 PRODUCTOS

-- 05 PROVEEDORES
INSERT INTO proveedor (representante_legal, nombre_corporativo, telefono, telefono2, nombre_contacto, categoria, correo_facturacion) 
VALUES  ('Rodrigo Monckenberg', 'Importaciones y Exportaciones Tecnodata S.A.', '+56224456350','+56224456351', 'Tecnodata', 'Tecnología', 'sertec@tecnodatasa.cl'),
  ('Ricardo Eluchans', 'Computación e ingeniería S.A.', '+56224112472', '+56224112471','COINSA', 'Tecnología', 'facturacion@coinsa.cl'),
  ('Elena Risopatron', 'A&S Tecnologias Computacionales Ltda.', '+56226322930','+56226322932', 'A&S', 'e-commerce', 'pagofactura@aystecnologia.cl'),
        ('Ignacia Piñera', 'ESPEX Ingeniería LTDA', '+56225124305', '+56225124307','ESPEX', 'Servicios de Consultoría Técnica', 'facpag@espex.cl'),
        ('James Wu', 'Foxconn Technology Co Ltd', '+886222683466','+886222683469', 'Foxconn', 'Tecnología', 'ir@foxconn.com');

-- PREGUNTAS PARA EL CODIGO SPRINT
-- 1.-  Cuál es la categoría de productos que más se repite.
SELECT categoria, COUNT(*) as repeticiones
FROM producto
GROUP BY categoria
ORDER BY repeticiones DESC
LIMIT 1;

-- 2.- Cuáles son los productos con mayor stock
SELECT nombre, Stock
FROM producto
ORDER BY Stock DESC
LIMIT 10;

-- 3.- Qué color de producto es más común en nuestra tienda.
SELECT color, COUNT(*) as repeticiones
FROM producto
GROUP BY color
ORDER BY repeticiones DESC
LIMIT 1;

-- 4.-  Cual o cuales son los proveedores con menor stock de productos. (Se decidio mostrar 3)
SELECT Proveedor, SUM(Stock) AS total_stock
FROM producto
GROUP BY Proveedor
ORDER BY total_stock ASC
LIMIT 3;

-- 5.- Cambien la categoría de productos más popular por ‘Electrónica y computación’.
UPDATE producto
SET categoria = 'Electrónica y computación'
WHERE categoria = (
    SELECT categoria
    FROM producto
    GROUP BY categoria
    ORDER BY COUNT(*) DESC
    LIMIT 1
);
