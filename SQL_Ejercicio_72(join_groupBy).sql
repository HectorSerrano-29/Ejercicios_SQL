IF OBJECT_ID('visitantes') IS NOT NULL
	DROP TABLE visitantes;
IF OBJECT_ID('ciudades') IS NOT NULL
	DROP TABLE ciudades;

CREATE TABLE visitantes(
	nombre varchar(30),
	edad tinyint,
	sexo char(1) default 'f',
	domicilio varchar(30),
	codigociudad tinyint not null,
	mail varchar(30),
	montocompra decimal (6,2)
);

CREATE TABLE ciudades(
	codigo tinyint identity,
	nombre varchar(20)
);

INSERT INTO ciudades
VALUES('Cordoba'),
('Carlos Paz'),
('La Falda'),
('Cruz del Eje');

INSERT INTO visitantes
VALUES('Susana Molina', 35,'f','Colon 123', 1, null,59.80),
('Marcos Torres', 29,'m','Sucre 56', 1, 'marcostorres@hotmail.com',150.50),
('Mariana Juarez', 45,'f','San Martin 111',2,null,23.90),
('Fabian Perez',36,'m','Avellaneda 213',3,'fabianperez@xaxamail.com',0),
('Alejandra Garcia',28,'f',null,2,null,280.50),
('Gaston Perez',29,'m',null,5,'gastonperez1@gmail.com',95.40),
('Mariana Juarez',33,'f',null,2,null,90);

SELECT c.nombre,
COUNT(*) AS cantidad
FROM ciudades AS c
JOIN visitantes AS v
ON codigociudad=c.codigo
GROUP BY c.nombre;

SELECT c.nombre,sexo,
AVG(montocompra) AS 'promedio de compra'
FROM ciudades AS c
JOIN visitantes AS v
ON codigociudad=c.codigo
GROUP BY c.nombre,sexo;

SELECT c.nombre,
COUNT(mail) AS 'tienen mail'
FROM ciudades AS c
JOIN visitantes AS v
ON codigociudad=c.codigo
GROUP BY c.nombre;

SELECT c.nombre,
MAX(montocompra)
FROM visitantes AS v
JOIN ciudades AS c
ON codigociudad=c.codigo
GROUP BY c.nombre;