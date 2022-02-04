IF OBJECT_ID('articulos') is not null
	DROP TABLE articulos;

CREATE TABLE articulos(
	codigo int identity,
	nombre varchar(20),
	descripcion varchar(30),
	precio smallmoney,
	cantidad tinyint default 0,
	primary key (codigo)
);

INSERT INTO articulos (nombre, descripcion, precio,cantidad)
VALUES('impresora','Epson Stylus C45',400.80,20);

INSERT INTO articulos (nombre, descripcion, precio)
VALUES('impresora','Epson Stylus C85',500);

INSERT INTO articulos (nombre, descripcion, precio)
VALUES('monitor','Samsung 14',800);

INSERT INTO articulos (nombre, descripcion, precio,cantidad)
VALUES('teclado','ingles Biswal',100,50);

SELECT* FROM articulos;

UPDATE articulos SET precio = precio + (precio * 0.15);

SELECT* FROM articulos;

SELECT nombre +', '+ descripcion FROM articulos;

UPDATE articulos SET cantidad = cantidad - 5
WHERE nombre = 'teclado';

SELECT* FROM articulos;