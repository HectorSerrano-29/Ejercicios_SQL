IF OBJECT_ID('articulos') is not null
	DROP TABLE articulos;

CREATE TABLE articulos(
	codigo int,
	nombre varchar(20),
	descripcion varchar(30),
	precio float,
	cantidad int
 );

EXEC SP_COLUMNS articulos;

INSERT INTO articulos (codigo, nombre, descripcion, precio,cantidad)
VALUES(1,'impresora','Epson Stylus C45',400.80,20);

INSERT INTO articulos (codigo, nombre, descripcion, precio,cantidad)
VALUES(2,'impresora','Epson Stylus C85',500,30);

 INSERT INTO articulos (codigo, nombre, descripcion, precio,cantidad)
VALUES(3,'monitor','Samsung 14',800,10);

INSERT INTO articulos (codigo, nombre, descripcion, precio,cantidad)
VALUES(4,'teclado','ingles Biswal',100,50);

INSERT INTO articulos (codigo, nombre, descripcion, precio,cantidad)
VALUES(5,'teclado','español Biswal',90,50);

SELECT* FROM articulos
WHERE nombre = 'impresora';

SELECT* FROM articulos
WHERE precio >= 400;

SELECT codigo,nombre FROM articulos
WHERE cantidad < 30;

SELECT nombre,descripcion FROM articulos
WHERE precio <> 100;