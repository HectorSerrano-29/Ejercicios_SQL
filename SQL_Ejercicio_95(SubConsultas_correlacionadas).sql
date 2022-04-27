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
 
CREATE TABLE inscriptos (
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
VALUES (1,'tenis',1),
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

SELECT nombre, domicilio,
(SELECT count(*)
FROM inscriptos AS i
WHERE s.numero = i.numerosocio) AS 'deportes'
FROM socios AS s;

SELECT nombre,
(SELECT (count(*)*10)
FROM inscriptos AS i
WHERE s.numero = i.numerosocio) AS total,
(SELECT sum(i.cuotas)
FROM inscriptos AS i
WHERE s.numero = i.numerosocio) AS pagas
FROM socios AS s;

SELECT nombre,
count(i.deporte)*10 AS total,
sum(i.cuotas) AS pagas
FROM socios AS s
JOIN inscriptos AS i
ON numero = numerosocio
GROUP BY nombre;