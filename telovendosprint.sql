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
);
-- TABLA PROVEEDOR
CREATE TABLE proveedor (
  id INT AUTO_INCREMENT PRIMARY KEY,
  representante_legal VARCHAR(255) NOT NULL,
  nombre_corporativo VARCHAR(255) NOT NULL,
  telefono VARCHAR(20) NOT NULL,
  nombre_contacto VARCHAR(255) NOT NULL,
  categoria VARCHAR(50) NOT NULL,
  correo_facturacion VARCHAR(255) NOT NULL
);
-- CREACIÓN DE USUARIO Y PERMISOS
CREATE USER 'admintienda'@'localhost' IDENTIFIED BY 'admintienda';
GRANT ALL PRIVILEGES ON Telovendo.* TO 'admintienda'@'localhost';

-- TABLA PRODUCTOS INFO: 
-- 10 CLIENTES
-- 20 PRODUCTOS
-- 05 PROVEEDORES


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
