IF OBJECT_ID('inscriptos') IS NOT NULL
	DROP TABLE inscriptos;
IF OBJECT_ID('socios') IS NOT NULL
	DROP TABLE socios;
IF OBJECT_ID('profesores') IS NOT NULL
	DROP TABLE profesores; 
IF OBJECT_ID('cursos') IS NOT NULL
	DROP TABLE cursos;

CREATE TABLE socios(
	documento char(8) not null,
	nombre varchar(40),
	domicilio varchar(30),
	constraint PK_socios_documento
	primary key (documento)
);

CREATE TABLE profesores(
	documento char(8) not null,
	nombre varchar(40),
	domicilio varchar(30),
	constraint PK_profesores_documento
	primary key (documento)
);

CREATE TABLE cursos(
	numero tinyint identity,
	deporte varchar(20),
	dia varchar(15),
	constraint CK_inscriptos_dia check (dia in('lunes','martes','miercoles','jueves','viernes','sabado')),
	documentoprofesor char(8),
	constraint PK_cursos_numero
	primary key (numero),
);

CREATE TABLE inscriptos(
	documentosocio char(8) not null,
	numero tinyint not null,
	matricula char(1),
	constraint CK_inscriptos_matricula check (matricula in('s','n')),
	constraint PK_inscriptos_documento_numero
	primary key (documentosocio,numero)
);

INSERT INTO socios
VALUES('30000000','Fabian Fuentes','Caseros 987'),
('31111111','Gaston Garcia','Guemes 65'),
('32222222','Hector Huerta','Sucre 534'),
('33333333','Ines Irala','Bulnes 345');

INSERT INTO profesores
VALUES('22222222','Ana Acosta','Avellaneda 231'),
('23333333','Carlos Caseres','Colon 245'),
('24444444','Daniel Duarte','Sarmiento 987'),
('25555555','Esteban Lopez','Sucre 1204');

INSERT INTO cursos
VALUES('tenis','lunes','22222222'),
('tenis','martes','22222222'),
('natacion','miercoles','22222222'),
('natacion','jueves','23333333'),
('natacion','viernes','23333333'),
('futbol','sabado','24444444'),
('futbol','lunes','24444444'),
('basquet','martes','24444444');

INSERT INTO inscriptos
VALUES('30000000',1,'s'),
('30000000',3,'n'),
('30000000',6,null),
('31111111',1,'s'),
('31111111',4,'s'),
('32222222',8,'s');

IF OBJECT_ID('vista_club') IS NOT NULL
DROP VIEW vista_club;

CREATE VIEW vista_club AS
SELECT s.nombre AS socio, s.documento AS docsocio, s.domicilio AS domsocio, c.deporte, dia,
p.nombre AS profesor, matricula
FROM socios AS s
FULL JOIN inscriptos AS i
ON s.documento = i.documentosocio
FULL JOIN cursos AS c
ON i.numero = c.numero
FULL JOIN profesores AS p
ON c.documentoprofesor = p.documento;

SELECT* FROM vista_club;

SELECT deporte, dia, count(socio) AS cantidad
FROM vista_club
WHERE deporte IS NOT NULL
GROUP BY deporte, dia
ORDER BY cantidad;

SELECT deporte, dia FROM vista_club
WHERE socio IS NULL AND deporte IS NOT NULL;

SELECT socio FROM vista_club
WHERE deporte IS NULL AND socio IS NOT NULL;

SELECT profesor FROM vista_club
WHERE deporte IS NULL AND profesor IS NOT NULL;

SELECT socio, docsocio FROM vista_club
WHERE deporte IS NOT NULL AND matricula <> 's';

SELECT DISTINCT profesor, dia
FROM vista_club
WHERE profesor IS NOT NULL;

SELECT DISTINCT profesor, dia
FROM vista_club
WHERE profesor IS NOT NULL
ORDER BY dia;

SELECT socio FROM vista_club
WHERE deporte = 'tenis' AND dia = 'lunes';

IF OBJECT_ID('vista_inscriptos') IS NOT NULL
DROP VIEW vista_inscriptos;

CREATE VIEW vista_inscriptos AS
SELECT deporte, dia, (SELECT COUNT(*)
	FROM inscriptos AS i
	WHERE i.numero = c.numero) AS cantidad
FROM cursos AS c;

SELECT* FROM vista_inscriptos;