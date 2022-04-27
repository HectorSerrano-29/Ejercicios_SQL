IF OBJECT_ID('facturas') IS NOT NULL
	DROP TABLE facturas;
IF OBJECT_ID('clientes') IS NOT NULL
	DROP TABLE clientes;

CREATE TABLE clientes(
	codigo int identity,
	nombre varchar(30),
	domicilio varchar(30),
	primary key(codigo)
);

CREATE TABLE facturas(
	numero int not null,
	fecha datetime,
	codigocliente int not null,
	total decimal(6,2),
	primary key(numero),
	constraint FK_facturas_cliente
	foreign key (codigocliente)
	references clientes(codigo)
	on update cascade
);

INSERT INTO clientes 
VALUES('Juan Lopez','Colon 123'),
('Luis Torres','Sucre 987'),
('Ana Garcia','Sarmiento 576'),
('Susana Molina','San Martin 555');

INSERT INTO facturas
VALUES(1200,'2007-01-15',1,300),
(1201,'2007-01-15',2,550),
(1202,'2007-01-15',3,150),
(1300,'2007-01-20',1,350),
(1310,'2007-01-22',3,100);

IF OBJECT_ID('clientespref') IS NOT NULL
	DROP TABLE clientespref;

CREATE TABLE clientespref(
	nombre varchar(30),
	domicilio varchar(30)
);

INSERT INTO clientespref
SELECT nombre, domicilio
FROM clientes 
WHERE codigo IN
(SELECT codigocliente
FROM clientes AS c
JOIN facturas AS f
ON codigocliente = codigo
GROUP BY codigocliente
HAVING sum(total) > 500);/*Seran clientes preferidos aquellos que su total en facutras sea mayor a 500
en el total de sus compras*/

SELECT* FROM clientespref;