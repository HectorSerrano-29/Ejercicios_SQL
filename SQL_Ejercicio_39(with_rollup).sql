IF OBJECT_ID('clientes') IS NOT NULL
	DROP TABLE clientes;

CREATE TABLE clientes(
	codigo int identity,
	nombre varchar(30) not null,
	domicilio varchar(30),
	ciudad varchar(20),
	estado varchar (20),
	pais varchar(20),
	primary key(codigo)
);

INSERT INTO clientes
VALUES('Lopez Marcos','Colon 111', 'Cordoba','Cordoba','Argentina'),
('Perez Ana','San Martin 222', 'Carlos Paz','Cordoba','Argentina'),
('Garcia Juan','Rivadavia 333', 'Carlos Paz','Cordoba','Argentina'),
('Perez Luis','Sarmiento 444', 'Rosario','Santa Fe','Argentina'),
('Gomez Ines','San Martin 987', 'Santa Fe','Santa Fe','Argentina'),
('Gomez Ines','San Martin 666', 'Santa Fe','Santa Fe','Argentina'),
('Lopez Carlos','Irigoyen 888', 'Cordoba','Cordoba','Argentina'),
('Ramos Betina','San Martin 999', 'Cordoba','Cordoba','Argentina'),
('Fernando Salas','Mariano Osorio 1234', 'Santiago','Region metropolitana','Chile'),
('German Rojas','Allende 345', 'Valparaiso','Region V','Chile'),
('Ricardo Jara','Pablo Neruda 146', 'Santiago','Region metropolitana','Chile'),
('Joaquin Robles','Diego Rivera 147', 'Guadalajara','Jalisco','Mexico');

SELECT pais, COUNT(pais) AS 'Clientes' FROM clientes
GROUP BY pais WITH ROLLUP;

SELECT pais, estado, COUNT(pais) AS 'Clientes' FROM clientes
GROUP BY pais, estado WITH ROLLUP;

SELECT pais, estado, ciudad, COUNT(pais) AS 'Clientes' FROM clientes
GROUP BY pais, estado, ciudad WITH ROLLUP;