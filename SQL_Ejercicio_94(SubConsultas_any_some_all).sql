IF OBJECT_ID('inscriptos') IS NOT NULL
	DROP TABLE inscriptos;
IF OBJECT_ID('socios') IS NOT NULL
	DROP TABLE socios;

CREATE TABLE socios(
	numero int identity,
	documento char(8),
	nombre varchar(30),
	domicilio varchar(30),
	primary key (numero)
);
 
CREATE TABLE inscriptos(
	numerosocio int not null,
	deporte varchar(20) not null,
	cuotas tinyint
	constraint CK_inscriptos_cuotas
	check (cuotas>=0 and cuotas<=10)
	constraint DF_inscriptos_cuotas default 0,
	primary key(numerosocio,deporte),
	constraint FK_inscriptos_socio
	foreign key (numerosocio)
	references socios(numero)
	on update cascade
	on delete cascade,
);

INSERT INTO socios
VALUES('23333333','Alberto Paredes','Colon 111'),
('24444444','Carlos Conte','Sarmiento 755'),
('25555555','Fabian Fuentes','Caseros 987'),
('26666666','Hector Lopez','Sucre 344');

INSERT INTO inscriptos
VALUES(1,'tenis',1),
(1,'basquet',2),
(1,'natacion',1),
(2,'tenis',9),
(2,'natacion',1),
(2,'basquet',default),
(2,'futbol',2),
(3,'tenis',8),
(3,'basquet',9),
(3,'natacion',0),
(4,'basquet',10);

SELECT numero, nombre, deporte
FROM socios AS s
JOIN inscriptos AS i
ON numerosocio = numero;

SELECT nombre
FROM socios
JOIN inscriptos AS i
ON numero = numerosocio
WHERE deporte = 'natacion' AND numero = any
(SELECT numerosocio
FROM inscriptos AS i
WHERE deporte = 'tenis');

SELECT deporte
FROM inscriptos AS i
WHERE numerosocio = 1 AND
deporte = ANY
(SELECT deporte
FROM inscriptos AS i
WHERE numerosocio = 2);

SELECT i1.deporte
FROM inscriptos AS i1
JOIN inscriptos AS i2
ON i1.deporte = i2.deporte
WHERE i1.numerosocio = 1 AND i2.numerosocio =  2;

SELECT deporte
FROM inscriptos AS i
WHERE numerosocio = 2 AND cuotas > any
(SELECT cuotas
FROM inscriptos
WHERE numerosocio = 1);

SELECT deporte
FROM inscriptos AS i
WHERE numerosocio = 2 AND cuotas > ALL
(SELECT cuotas
FROM inscriptos
WHERE numerosocio = 1);

DELETE FROM inscriptos
WHERE numerosocio = any
(SELECT numerosocio 
FROM inscriptos
WHERE cuotas = 0);