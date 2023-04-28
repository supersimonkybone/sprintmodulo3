-- CREAMOS BASE DE DATOS
CREATE DATABASE Sprint_telovendo;

-- EJECUTAMOS BASE DE DATOS
USE Sprint_telovendo;

-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Table `sprint_telovendo`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sprint_telovendo`.`cliente` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(255) NOT NULL,
  `apellidos` VARCHAR(255) NOT NULL,
  `telefono` VARCHAR(12) NULL DEFAULT NULL,
  `direccion` VARCHAR(255) NULL DEFAULT NULL,
  `comuna` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`codigo`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `sprint_telovendo`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sprint_telovendo`.`pedido` (
  `numero_pedido` INT NOT NULL AUTO_INCREMENT,
  `codigo_cliente` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `boleta` INT NOT NULL,
  `total_pagado` INT NOT NULL,
  PRIMARY KEY (`numero_pedido`),
  INDEX `codigo_cliente` (`codigo_cliente` ASC) VISIBLE,
  CONSTRAINT `pedidos_ibfk_1`
    FOREIGN KEY (`codigo_cliente`)
    REFERENCES `sprint_telovendo`.`cliente` (`codigo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `sprint_telovendo`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sprint_telovendo`.`producto` (
  `SKU` VARCHAR(255) NOT NULL,
  `nombre` VARCHAR(255) NOT NULL,
  `categoria` VARCHAR(255) NOT NULL,
  `Color` ENUM('ROJO', 'AMARILLO', 'AZUL', 'BLANCO', 'GRIS', 'NEGRO', 'VERDE', 'CYAN', 'MAGENTA', 'ROSADO', 'PURPURA', 'VIOLETA', 'FUCSIA', 'CAFE') NOT NULL,
  `Stock` INT NOT NULL,
  PRIMARY KEY (`SKU`),
  UNIQUE INDEX `SKU` (`SKU` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `sprint_telovendo`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sprint_telovendo`.`proveedor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `representante_legal` VARCHAR(255) NOT NULL,
  `nombre_corporativo` VARCHAR(255) NOT NULL,
  `telefono` VARCHAR(20) NOT NULL,
  `telefono2` VARCHAR(20) NOT NULL,
  `nombre_contacto` VARCHAR(255) NOT NULL,
  `categoria` VARCHAR(50) NOT NULL,
  `correo_facturacion` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `sprint_telovendo`.`producto_has_proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sprint_telovendo`.`producto_has_proveedor` (
  `producto_SKU` VARCHAR(255) NOT NULL,
  `proveedor_id` INT NOT NULL,
  PRIMARY KEY (`producto_SKU`, `proveedor_id`),
  INDEX `fk_producto_has_proveedor_proveedor1_idx` (`proveedor_id` ASC) VISIBLE,
  INDEX `fk_producto_has_proveedor_producto1_idx` (`producto_SKU` ASC) VISIBLE,
  CONSTRAINT `fk_producto_has_proveedor_producto1`
    FOREIGN KEY (`producto_SKU`)
    REFERENCES `sprint_telovendo`.`producto` (`SKU`),
  CONSTRAINT `fk_producto_has_proveedor_proveedor1`
    FOREIGN KEY (`proveedor_id`)
    REFERENCES `sprint_telovendo`.`proveedor` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `sprint_telovendo`.`producto_has_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sprint_telovendo`.`producto_has_pedido` (
  `producto_SKU` VARCHAR(255) NOT NULL,
  `pedido_numero_pedido` INT NOT NULL,
  PRIMARY KEY (`producto_SKU`, `pedido_numero_pedido`),
  INDEX `fk_producto_has_pedido_pedido1_idx` (`pedido_numero_pedido` ASC) VISIBLE,
  INDEX `fk_producto_has_pedido_producto1_idx` (`producto_SKU` ASC) VISIBLE,
  CONSTRAINT `fk_producto_has_pedido_producto1`
    FOREIGN KEY (`producto_SKU`)
    REFERENCES `sprint_telovendo`.`producto` (`SKU`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_producto_has_pedido_pedido1`
    FOREIGN KEY (`pedido_numero_pedido`)
    REFERENCES `sprint_telovendo`.`pedido` (`numero_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- ALGUNAS VALIDACIONES
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- CREACIÓN DE USUARIO Y PERMISOS
CREATE USER 'admintienda'@'localhost' IDENTIFIED BY 'admintienda';
GRANT ALL PRIVILEGES ON Sprint_telovendo.* TO 'admintienda'@'localhost';

-- TABLA PRODUCTOS INFO: 
-- 10 CLIENTES
INSERT INTO cliente (codigo, nombres, apellidos, telefono, direccion, comuna) 
VALUES 	(1, 'Ignacio Simon', 'Perez Lastra', '+56912345678', 'San Pablo 123', 'Vitacura'),
	    (2, 'Eduardo Ricardo', 'Rockefeler Soto', '+56943245678', 'San Pedro 321', 'Las Condes'),
        (3, 'Harry Edgard', 'Potter Rodriguez', '+56912654678', 'Providencia 23', 'Providencia'),
        (4, 'Hermione Sandra', 'Granger Sotomayor', '+56912345123', 'Alvarez 666', 'Viña del mar'),
        (5, 'Ron Vodka', 'Weasly Ramirez', '+56965435678', 'Limache 65', 'Viña del mar'),
        (6, 'Albus Peter', 'Dumbledore Lastra', '+56912765438', 'Londres 43', 'Peñablanca'),
        (7, 'Sasha Ignacia', 'Grey Perez', '+56918765678', 'Liverpool 89', 'Temuco'),
        (8, 'Severus Adolfo', 'Snape Pinochet', '+56917655678', 'Valparaiso 1314', 'Santiago'),
        (9, 'Minerva Marcela', 'McGonagall Veas', '+56976895678', 'Blanco Encalada 154', 'Quilpue'),
        (10, 'Homero Jay', 'Simpson Simpson', '+56979685678', 'Avenida Siempreviva 742', 'Springfield');

-- 05 PROVEEDORES
INSERT INTO proveedor (id, representante_legal, nombre_corporativo, telefono, telefono2, nombre_contacto, categoria, correo_facturacion) 
VALUES  (1, 'Rodrigo Monckenberg', 'Importaciones y Exportaciones Tecnodata S.A.', '+56224456350','+56224456351', 'Tecnodata', 'e-Consolas_accesorios', 'sertec@tecnodatasa.cl'),
  	    (2, 'Ricardo Eluchans', 'Computación e ingeniería S.A.', '+56224112472', '+56224112471','COINSA', 'Computacion', 'facturacion@coinsa.cl'),
  	    (3, 'Elena Risopatron', 'A&S Tecnologias Computacionales Ltda.', '+56226322930','+56226322932', 'A&S', 'Computacion', 'pagofactura@aystecnologia.cl'),
        (4, 'Ignacia Piñera', 'ESPEX Ingeniería LTDA', '+56225124305', '+56225124307','ESPEX', 'Celulares', 'facpag@espex.cl'),
        (5, 'James Wu', 'Foxconn Technology Co Ltd', '+886222683466','+886222683469', 'Foxconn', 'Computacion_accesorios', 'ir@foxconn.com');

-- 20 PRODUCTOS
-- carcasas
INSERT INTO Producto (SKU, nombre, categoria, color, stock)
VALUES ('28346', 'Carcasa Samsung S9','Celulares', 'ROSADO', 10)
;
INSERT INTO Producto (SKU, nombre, categoria, color, stock)
VALUES ('27449' , 'Carcasa Samsung J5 Prime', 'Celulares', 'AZUL', 8)
;
INSERT INTO Producto (SKU, nombre, categoria, color, stock)
VALUES ('21921', 'Carcasa para Motorola G3', 'Celulares', 'ROJO', 5)
;
INSERT INTO Producto (SKU, nombre, categoria, color, stock)
VALUES ('28338', 'Carcasa Apple Iphone 8', 'Celulares', 'NEGRO', 5)
;
INSERT INTO Producto (SKU, nombre, categoria, color, stock)
VALUES ('33719', 'Carcasa Samsung A70', 'Celulares', 'NEGRO', 10)
;
-- Webcams
INSERT INTO Producto (SKU, nombre, categoria, color, stock)
VALUES ('18858', 'Webcam FaceCam 100X HD', 'Computacion', 'NEGRO', 5)
;
INSERT INTO Producto (SKU, nombre, categoria, color, stock)
VALUES ('40509', 'Webcam FullHD 1080p/60 fps StreamCam Plus', 'computacion', 'AZUL', 10)
;
INSERT INTO Producto (SKU, nombre, categoria, color, stock)
VALUES ('44085', 'Kit Webcam y Capturadora de Video BO311D', 'Computacion', 'NEGRO', 10)
;
INSERT INTO Producto (SKU, nombre, categoria, color, stock)
VALUES ('38185', 'Webcam BCC950 ConferenceCam', 'Computacion', 'AZUL', 15)
;
INSERT INTO Producto (SKU, nombre, categoria, color, stock)
VALUES ('38211', 'Webcam PW310O HD', 'computacion','NEGRO', 8)
;
-- Consolas y accesorios
INSERT INTO Producto (SKU, nombre, categoria, color, stock)
VALUES ('30270', 'Adaptador Ethernet para consola Nintendo Switch', 'Consolas_accesorios', 'BLANCO', 15)
;
INSERT INTO Producto (SKU, nombre, categoria, color, stock)
VALUES ('40596', 'Cargador doble controles PS5', 'Consolas_accesorios', 'BLANCO', 30)
;
INSERT INTO Producto (SKU, nombre, categoria, color, stock)
VALUES  ('34603', 'Cargador Joy con 4 en 1 Nintendo Switch', 'Consolas_accesorios', 'NEGRO', 3)
;
INSERT INTO Producto (SKU, nombre, categoria, color, stock)
VALUES ('31510', 'HYPERKIN Amplificador de audifonos para PS4 Controller', 'Consolas_accesorios', 'NEGRO',3)
;
INSERT INTO Producto (SKU, nombre, categoria, color, stock)
VALUES ('33100', 'Disco Externo 2TB 2_5" para PS4', 'Consolas_accesorios', 'NEGRO', 13)
;
-- accesorios_computacion
INSERT INTO Producto (SKU, nombre, categoria, color, stock)
VALUES ('40643', 'Cargador alternativo para Notebook Samsung 40W_19V_2.1A_conector_5.5mm*3', 'Computacion_accesorios', 'NEGRO', 50)
;
INSERT INTO Producto (SKU, nombre, categoria, color, stock)
VALUES ('39813', 'Candado Notebook Combinacion de 3 digitos tipo USB Lock', 'Computacion_accesorios', 'BLANCO', 100)
;
INSERT INTO Producto (SKU, nombre, categoria, color, stock)
VALUES ('33028', 'Base Notebook con 2 Ventiladores', 'Computacion_accesorios', 'NEGRO', 50)
;
INSERT INTO Producto (SKU, nombre, categoria, color, stock)
VALUES ('30145', 'Bateria alternativa para Notebook Asus A450x450 R510 P450 F550', 'Computacion_accesorios', 'NEGRO', 5)
;
INSERT INTO Producto (SKU, nombre, categoria, color, stock)
VALUES ('40631', 'Cargador alternativo para Notebook Dell_45w_19.5V', 'Computacion_accesorios', 'NEGRO', 22)
;

-- AÑADIMOS 15 PEDIDOS
INSERT INTO pedido (numero_pedido, codigo_cliente, cantidad, boleta, total_pagado) 
VALUES 	(1, 3, 5, 1, 10000),
	    (2, 2, 3, 2, 6000),
        (3, 1, 10, 3, 5900),
        (4, 4, 2, 4, 200000),
        (5, 5, 6, 5, 700000),
        (6, 6, 2, 6, 90000),
        (7, 10, 1, 7, 2000),
        (8, 9, 8, 8, 55000),
        (9, 8, 9, 9, 20000),
        (10, 7, 5, 10, 870000),
		(11, 2, 3, 11, 6000),
        (12, 1, 10, 12, 5900),
        (13, 4, 2, 13, 200000),
        (14, 5, 6, 14, 700000),
        (15, 4, 2, 15, 90000);

-- INSERTAMOS LA DATA EN LA TABLA INTERMEDIA producto_has_proveedor, DESDE LAS TABLAS PRODUCTO Y PROVEEDOR
INSERT INTO producto_has_proveedor (producto_SKU, proveedor_id) 
SELECT p.SKU, pr.id 
FROM producto p, proveedor pr 
WHERE p.categoria = pr.categoria;

-- INSERTAMOS LA DATA EN LA TABLA INTERMEDIA producto_has_pedido, DESDE LAS TABLAS PRODUCTO Y PEDIDO
INSERT INTO producto_has_pedido (producto_SKU, pedido_numero_pedido)
SELECT p.SKU, pe.numero_pedido
FROM producto p, pedido pe;        

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

-- 4.-  Cual o cuales son los proveedores con menor stock de productos. (Se decidio mostrar 2)
SELECT pr.id, pr.nombre_corporativo, SUM(p.Stock) AS stock_total
FROM producto p
INNER JOIN producto_has_proveedor pp ON p.SKU = pp.producto_SKU
INNER JOIN proveedor pr ON pp.proveedor_id = pr.id
GROUP BY pr.id, pr.nombre_corporativo
ORDER BY stock_total ASC
LIMIT 2;
set @@sql_mode='ONLY_FULL_GROUP_BY';

select * from producto_has_proveedor;

-- 5.- Cambia la categoría de productos más popular por ‘Electrónica y computación’.
SET SQL_SAFE_UPDATES = 0;
UPDATE producto
SET categoria = 'Electronica y Computacion'
WHERE categoria IN (
  SELECT categoria
  FROM (
    SELECT categoria, COUNT(*) AS count
    FROM producto
    GROUP BY categoria
    ORDER BY count DESC
    LIMIT 1
  ) AS t
);
SET SQL_SAFE_UPDATES = 1;
select * from producto;

-- DROP DATABASE Sprint_telovendo;
-- DROP TABLE producto;

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
