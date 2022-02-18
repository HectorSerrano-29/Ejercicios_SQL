IF OBJECT_ID('ventas') IS NOT NULL
	DROP TABLE ventas;

CREATE TABLE ventas(
	numero int identity,
	montocompra decimal(6,2),
	tipopago char(1),--c=contado, t=tarjeta
	vendedor varchar(30),
	primary key (numero)
);

INSERT INTO ventas
VALUES(100.50,'c','Marisa Perez'),
(200,'c','Marisa Perez'),
(50,'t','Juan Lopez'),
(220,'c','Juan Lopez'),
(150,'t','Marisa Perez'),
(550.80,'c','Marisa Perez'),
(300,'t','Juan Lopez'),
(25,'c','Marisa Perez');

SELECT vendedor, tipopago, COUNT(*) AS 'Ventas' FROM ventas
GROUP BY vendedor, tipopago WITH ROLLUP;

SELECT vendedor, tipopago, COUNT(*) AS 'Ventas' FROM ventas
GROUP BY vendedor, tipopago WITH CUBE;