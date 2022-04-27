IF (OBJECT_ID('ciudades')) IS NOT NULL
	DROP TABLE ciudades;
IF (OBJECT_ID('clientes')) IS NOT NULL
	DROP TABLE clientes;

CREATE TABLE ciudades(
	codigo tinyint identity,
	nombre varchar(20),
	primary key (codigo)
);

CREATE TABLE clientes (
	codigo int identity,
	nombre varchar(30),
	domicilio varchar(30),
	codigociudad tinyint not null,
	PRIMARY KEY(codigo),
	CONSTRAINT FK_clientes_ciudad
	FOREIGN KEY(codigociudad)
	REFERENCES ciudades(codigo)
	ON UPDATE CASCADE,
);

INSERT INTO ciudades (nombre)
VALUES('Cordoba'),
('Cruz del Eje'),
('Carlos Paz'),
('La Falda'),
('Villa Maria');

INSERT INTO clientes
VALUES('Lopez Marcos','Colon 111',1),
('Lopez Hector','San Martin 222',1),
('Perez Ana','San Martin 333',2),
('Garcia Juan','Rivadavia 444',3),
('Perez Luis','Sarmiento 555',3),
('Gomez Ines','San Martin 666',4),
('Torres Fabiola','Alem 777',5),
('Garcia Luis','Sucre 888',5);

SELECT nombre
FROM ciudades
WHERE codigo IN (SELECT codigociudad FROM clientes
	WHERE domicilio LIKE 'San Martin %');/*Consulta con una subconsulta usando "in"*/

SELECT DISTINCT ci.nombre
FROM ciudades AS ci
JOIN clientes AS cl
ON codigociudad = ci.codigo
WHERE domicilio LIKE 'San Martin%';/*Misma consulta pero con "join"*/

SELECT nombre
FROM ciudades
WHERE codigo NOT IN (SELECT codigociudad FROM clientes
	WHERE nombre LIKE 'G%');

SELECT codigociudad
FROM clientes
WHERE nombre LIKE 'G%';