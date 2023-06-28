DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  codigo_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

#1. Lista el nombre de todos los productos que hay en la tabla producto.
SELECT nombre FROM producto;
#2. Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT nombre,precio FROM producto;
#3. Lista todas las columnas de la tabla producto.
SELECT * FROM producto;
#4. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
SELECT nombre,ROUND(precio) FROM producto;
#5. Lista el código de los fabricantes que tienen productos en la tabla producto.
SELECT fabricante.codigo,fabricante.nombre FROM fabricante INNER JOIN producto on fabricante.codigo = producto.codigo_fabricante;
#6. Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrar los repetidos.
SELECT DISTINCT fabricante.codigo,fabricante.nombre FROM fabricante INNER JOIN producto on fabricante.codigo = producto.codigo_fabricante;
#7. Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT nombre FROM fabricante ORDER BY nombre ASC;
#8. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
SELECT nombre,precio FROM producto ORDER BY nombre ASC,precio DESC; 
#9. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT * FROM fabricante LIMIT 5;
#10. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre,precio FROM producto ORDER BY precio ASC LIMIT 1;
#11. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre,precio FROM producto ORDER BY precio DESC LIMIT 1;
#12. Lista el nombre de los productos que tienen un precio menor o igual a $120.
SELECT nombre,precio FROM producto WHERE precio <= 120;
#13. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador BETWEEN.
SELECT * FROM producto WHERE precio BETWEEN 60 AND 200;
#14. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
SELECT * FROM producto WHERE codigo IN(1,3,5);
#15. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
SELECT nombre FROM producto WHERE nombre LIKE '%Portatil%';

#Consultas Multitabla
#1. Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.
SELECT fabricante.codigo AS codigo_fabricante,fabricante.nombre AS nombre_fabricante,codigo_fabricante AS codigo_fabricante_producto,producto.nombre AS nombre_producto FROM producto INNER JOIN fabricante on fabricante.codigo = producto.codigo_fabricante;
#2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.
SELECT producto.nombre AS producto,precio,fabricante.nombre AS fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY fabricante.nombre ASC;
#3. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
SELECT producto.nombre AS 'Producto',precio,fabricante.nombre AS 'Fabricante' FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY precio ASC LIMIT 1;
#4. Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT DISTINCT producto.nombre AS 'Producto',precio,fabricante.nombre AS 'Fabricante' FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Lenovo';
#5. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que $200.
SELECT * FROM producto INNER JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante WHERE fabricante.nombre = 'Crucial' AND precio > 200;
#6. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard. Utilizando el operador IN.
SELECT * FROM producto INNER JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante WHERE fabricante.nombre IN ('Asus','Hewlett-Packard');
#7. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a $180. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
SELECT producto.nombre AS 'Producto',precio,fabricante.nombre AS 'Fabricante' FROM producto INNER JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante WHERE precio >= 180 ORDER BY precio DESC,Producto ASC;

#Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.
#1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.
SELECT * FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante;
#2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado. 
SELECT fabricante.nombre AS 'Fabricante',fabricante.codigo AS 'Codigo Fabricante',producto.nombre AS 'Producto' FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante GROUP BY fabricante.nombre,fabricante.codigo,producto.nombre HAVING COUNT(producto.nombre) = 0;

#Subconsultas (En la cláusula WHERE)
#Con operadores básicos de comparación
#1. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT * FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante WHERE fabricante.nombre = 'Lenovo';
#2. Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT * FROM producto LEFT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio = (SELECT precio FROM producto LEFT JOIN fabricante on producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Lenovo' ORDER BY precio DESC LIMIT 1) AND fabricante.nombre != 'Lenovo';

#3. Lista el nombre del producto más caro del fabricante Lenovo.
SELECT precio,producto.nombre,fabricante.nombre FROM producto JOIN fabricante on producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Lenovo' ORDER BY precio DESC LIMIT 1;
#4. Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
SELECT 
    *
FROM
    producto
        LEFT JOIN
    fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE
    fabricante.nombre = 'Asus'
        AND producto.precio > (SELECT 
            ROUND(AVG(precio))
        FROM
            producto
                LEFT JOIN
            fabricante ON producto.codigo_fabricante = fabricante.codigo
        WHERE
            fabricante.nombre = 'Asus');

#Subconsultas con IN y NOT IN
#1. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
SELECT 
    fabricante.nombre,COUNT(fabricante.codigo) AS CantidadProductos
FROM
    fabricante
	WHERE fabricante.codigo IN (SELECT producto.codigo_fabricante FROM producto) GROUP BY fabricante.nombre;
    
    
  
    
#2. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).
SELECT 
    fabricante.nombre
FROM
    fabricante
	WHERE fabricante.codigo NOT IN (SELECT producto.codigo_fabricante FROM producto);  
#Subconsultas (En la cláusula HAVING)
#1. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo.   
SELECT nombre FROM fabricante WHERE (SELECT COUNT(producto.nombre) FROM producto WHERE fabricante.codigo IN(SELECT producto.codigo_fabricante FROM producto)) = (SELECT COUNT(producto.nombre)FROM producto WHERE producto.nombre = 'Lenovo');
SELECT 
    nombre
FROM
    fabricante
WHERE
    (SELECT 
            COUNT(*)
        FROM
            producto
        WHERE
            codigo_fabricante = fabricante.codigo) = (SELECT 
            COUNT(*)
        FROM
            producto
        WHERE
            codigo_fabricante = (SELECT 
                    codigo
                FROM
                    fabricante
                WHERE
                    nombre = 'Lenovo'))
        AND nombre <> 'Lenovo'; 


SELECT fabricante.nombre,COUNT(producto.nombre) AS CantidadProductos FROM fabricante INNER JOIN producto ON fabricante.codigo = producto.codigo_fabricante GROUP BY fabricante.nombre ORDER BY CantidadProductos DESC;