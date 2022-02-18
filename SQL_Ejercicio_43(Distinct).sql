IF OBJECT_ID('clientes') IS NOT NULL
	DROP TABLE clientes

CREATE TABLE clientes(
	codigo int identity,
	nombre varchar(30) not null,
	domicilio varchar(30),
	ciudad varchar(20),
	provincia varchar (20),
	primary key(codigo)
);

INSERT INTO clientes
VALUES('Lopez Marcos','Colon 111','Cordoba','Cordoba'),
('Perez Ana','San Martin 222','Cruz del Eje','Cordoba'),
('Garcia Juan','Rivadavia 333','Villa del Rosario','Cordoba'),
('Perez Luis','Sarmiento 444','Rosario','Santa Fe'),
('Pereyra Lucas','San Martin 555','Cruz del Eje','Cordoba'),
('Gomez Ines','San Martin 666','Santa Fe','Santa Fe'),
('Torres Fabiola','Alem 777','Villa del Rosario','Cordoba'),
('Lopez Carlos',null,'Cruz del Eje','Cordoba'),
('Ramos Betina','San Martin 999','Cordoba','Cordoba'),
('Lopez Lucas','San Martin 1010','Posadas','Misiones');

SELECT DISTINCT provincia FROM clientes;

SELECT COUNT(DISTINCT provincia) AS 'Num diferentes provincias' FROM clientes;

SELECT DISTINCT ciudad FROM clientes;

SELECT COUNT(DISTINCT ciudad) AS 'Num diferentes ciudades' FROM clientes;

SELECT DISTINCT ciudad FROM clientes
WHERE provincia <> 'Cordoba';

SELECT provincia, COUNT(DISTINCT ciudad) AS 'Num diferentes ciudades' FROM clientes
GROUP BY provincia;