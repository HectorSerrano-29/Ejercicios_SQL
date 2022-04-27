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
	matricula char(1),-- 'n' o 's'
	primary key(numerosocio,deporte),
	constraint FK_inscriptos_socio
	foreign key (numerosocio)
	references socios(numero)
);

INSERT INTO socios
VALUES('23333333','Alberto Paredes','Colon 111'),
('24444444','Carlos Conte','Sarmiento 755'),
('25555555','Fabian Fuentes','Caseros 987'),
('26666666','Hector Lopez','Sucre 344');

INSERT INTO inscriptos
VALUES(1,'tenis','s'),
(1,'basquet','s'),
(1,'natacion','s'),
(2,'tenis','s'),
(2,'natacion','s'),
(2,'basquet','n'),
(2,'futbol','n'),
(3,'tenis','s'),
(3,'basquet','s'),
(3,'natacion','n'),
(4,'basquet','n');

UPDATE inscriptos SET matricula='s'
WHERE numerosocio=
(SELECT numero
FROM socios
WHERE documento = '25555555');

SELECT* FROM inscriptos;

DELETE FROM inscriptos
WHERE numerosocio IN
(SELECT numero
FROM socios AS s
JOIN inscriptos
ON numerosocio = numero
WHERE matricula = 'n');