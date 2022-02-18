IF OBJECT_ID('clientes') IS NOT NULL
	DROP TABLE clientes;

CREATE TABLE clientes(
	codigo int identity,
	nombre varchar(30) not null,
	domicilio varchar(30),
	ciudad varchar(20),
	provincia varchar (20),
	telefono varchar(11),
	primary key(codigo)
);

INSERT INTO clientes
VALUES('Lopez Marcos','Colon 111','Cordoba','Cordoba','null'),
('Perez Ana','San Martin 222','Cruz del Eje','Cordoba','4578585'),
('Garcia Juan','Rivadavia 333','Villa del Rosario','Cordoba','4578445'),
('Perez Luis','Sarmiento 444','Rosario','Santa Fe',null),
('Pereyra Lucas','San Martin 555','Cruz del Eje','Cordoba','4253685'),
('Gomez Ines','San Martin 666','Santa Fe','Santa Fe','0345252525'),
('Torres Fabiola','Alem 777','Villa del Rosario','Cordoba','4554455'),
('Lopez Carlos',null,'Cruz del Eje','Cordoba',null),
('Ramos Betina','San Martin 999','Cordoba','Cordoba','4223366'),
('Lopez Lucas','San Martin 1010','Posadas','Misiones','0457858745');

SELECT ciudad, provincia, COUNT(*) AS 'Clientes' FROM clientes
GROUP BY ciudad, provincia;

SELECT ciudad, provincia, COUNT(*) AS 'Clientes' FROM clientes
GROUP BY ciudad, provincia
HAVING COUNT(*) > 1

SELECT ciudad, provincia, COUNT(*) AS 'Clientes' FROM clientes
WHERE domicilio LIKE '%San Martin%' 
GROUP BY ALL ciudad, provincia
HAVING COUNT(*) < 2 AND ciudad <> 'Cordoba';