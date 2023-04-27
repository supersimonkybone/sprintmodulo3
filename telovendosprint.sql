-- CREAMOS BASE DE DATOS
CREATE DATABASE Sprint_telovendo;

-- EJECUTAMOS BASE DE DATOS
USE Sprint_telovendo;

-- CREACION DE TABLAS:
-- TABLA CLIENTE, SE AGREGA MAS PARA HACER MAS COMPLETA LA INFO

CREATE TABLE cliente (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  nombres VARCHAR(255) NOT NULL,
  apellidos VARCHAR(255) NOT NULL,
  telefono VARCHAR (12),
  direccion VARCHAR(255),
  comuna VARCHAR(100)
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

-- TABLA PRODUCTO

CREATE TABLE producto (
  SKU VARCHAR(255) NOT NULL UNIQUE,
  nombre VARCHAR(255) NOT NULL,
  categoria VARCHAR(255) NOT NULL,
  Proveedor INT NOT NULL,
  FOREIGN KEY  (Proveedor) REFERENCES proveedor(id),
  Color ENUM ('ROJO', 'AMARILLO', 'AZUL', 'BLANCO', 'GRIS', 'NEGRO', 'VERDE', 'CYAN', 'MAGENTA', 'ROSADO', 'PURPURA', 'VIOLETA', 'FUCSIA', 'CAFE') NOT NULL,
  Stock INT NOT NULL
);

-- TABLA PEDIDOS
CREATE TABLE Pedidos (
  numero_pedido INT AUTO_INCREMENT PRIMARY KEY,
  codigo_cliente INT NOT NULL,
  FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo),
  SKU_producto VARCHAR(255) NOT NULL,
  FOREIGN KEY (SKU_producto) REFERENCES producto(SKU),
  cantidad INT NOT NULL,
  boleta INT NOT NULL,
  total_pagado INT NOT NULL
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
-- carcasas
INSERT INTO Producto (SKU, nombre, categoria, proveedor, color, stock)
VALUES ('28346', 'Carcasa Samsung S9','Celulares', '1','ROSADO', 10)
;
INSERT INTO Producto (SKU, nombre, categoria, proveedor, color, stock)
VALUES ('27449' , 'Carcasa Samsung J5 Prime', 'Celulares', '1', 'AZUL', 8)
;
INSERT INTO Producto (SKU, nombre, categoria, proveedor, color, stock)
VALUES ('21921', 'Carcasa para Motorola G3', 'Celulares', '1', 'ROJO', 5)
;
INSERT INTO Producto (SKU, nombre, categoria, proveedor, color, stock)
VALUES ('28338', 'Carcasa Apple Iphone 8', 'Celulares', '1', 'NEGRO', 5)
;
INSERT INTO Producto (SKU, nombre, categoria, proveedor, color, stock)
VALUES ('33719', 'Carcasa Samsung A70', 'Celulares', '2', 'NEGRO', 10)
;
-- Webcams
INSERT INTO Producto (SKU, nombre, categoria, proveedor, color, stock)
VALUES ('18858', 'Webcam FaceCam 100X HD', 'Computacion', '2', 'NEGRO', 5)
;
INSERT INTO Producto (SKU, nombre, categoria, proveedor, color, stock)
VALUES ('40509', 'Webcam FullHD 1080p/60 fps StreamCam Plus', 'computacion', '2', 'AZUL', 10)
;
INSERT INTO Producto (SKU, nombre, categoria, proveedor, color, stock)
VALUES ('44085', 'Kit Webcam y Capturadora de Video BO311D', 'Computacion', '2', 'NEGRO', 10)
;
INSERT INTO Producto (SKU, nombre, categoria, proveedor, color, stock)
VALUES ('38185', 'Webcam BCC950 ConferenceCam', 'Computacion', '3', 'AZUL', 15)
;
INSERT INTO Producto (SKU, nombre, categoria, proveedor, color, stock)
VALUES ('38211', 'Webcam PW310O HD', 'computacion', '3','NEGRO', 8)
;
-- Consolas y accesorios
INSERT INTO Producto (SKU, nombre, categoria, proveedor, color, stock)
VALUES ('30270', 'Adaptador Ethernet para consola Nintendo Switch', 'Consolas_accesorios', '3', 'BLANCO', 15)
;
INSERT INTO Producto (SKU, nombre, categoria, proveedor, color, stock)
VALUES ('40596', 'Cargador doble controles PS5', 'Consolas_accesorios', '3', 'BLANCO', 30)
;
INSERT INTO Producto (SKU, nombre, categoria, proveedor, color, stock)
VALUES  ('34603', 'Cargador Joy con 4 en 1 Nintendo Switch', 'Consolas_accesorios', '4', 'NEGRO', 3)
;
INSERT INTO Producto (SKU, nombre, categoria, proveedor, color, stock)
VALUES ('31510', 'HYPERKIN Amplificador de audifonos para PS4 Controller', 'Consolas_accesorios', '4', 'NEGRO',3)
;
INSERT INTO Producto (SKU, nombre, categoria, proveedor, color, stock)
VALUES ('33100', 'Disco Externo 2TB 2_5" para PS4', 'Consolas_accesorios', '4' , 'NEGRO', 13)
;
-- accesorios_computacion
INSERT INTO Producto (SKU, nombre, categoria, proveedor, color, stock)
VALUES ('40643', 'Cargador alternativo para Notebook Samsung 40W_19V_2.1A_conector_5.5mm*3', 'Computacion_accesorios','4', 'NEGRO', 50)
;
INSERT INTO Producto (SKU, nombre, categoria, proveedor, color, stock)
VALUES ('39813', 'Candado Notebook Combinacion de 3 digitos tipo USB Lock', 'Computacion_accesorios', '5', 'BLANCO', 100)
;
INSERT INTO Producto (SKU, nombre, categoria, proveedor, color, stock)
VALUES ('33028', 'Base Notebook con 2 Ventiladores', 'Computacion_accesorios', '5', 'NEGRO', 50)
;
INSERT INTO Producto (SKU, nombre, categoria, proveedor, color, stock)
VALUES ('30145', 'Bateria alternativa para Notebook Asus A450x450 R510 P450 F550', 'Computacion_accesorios', 5, 'NEGRO', 5)
;
INSERT INTO Producto (SKU, nombre, categoria, proveedor, color, stock)
VALUES ('40631', 'Cargador alternativo para Notebook Dell_45w_19.5V', 'Computacion_accesorios', 'NEGRO', 22)
;
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

/* Comentado Sugerencias:

a) crear una entidad proveedor_producto, como tabla de unión de la reLación muchos a muchos 
(en este caso se debe eliminar la llave foranea existente aen la entidad productos)

create table  proveedor_producto(
producto_id  SKU VARCHAR(255) ,
proveedor_id int,
FOREIGN (producto_id) REFERENCES producto(SKU),
FOREIGN (proveedor_id) REFERENCES proveedor(id),
);

b) crear tabla  pedido  que haga relación con la entidad cliente, relación 1-n

CREATE TABLE pedido(
  numero_pedido INT AUTO_INCREMENT PRIMARY KEY,
  codigo_cliente INT NOT NULL,
  FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo),
  fecha DATE,
  total_pagado INT NOT NULL
);

c) crear tabla detallePedido,  relación 1-n

CREATE TABLE detallePedido(
	id_detallete INT NOT NULL PRIMARY KEY,
	pedido_id int,
	FOREIGN KEY (pedido_id) REFERENCES pedido(numero_pedido),
	cantidad INT NOT NULL,
	SKU_producto VARCHAR(255) NOT NULL,
	FOREIGN KEY (SKU_producto) REFERENCES producto(SKU),

);
