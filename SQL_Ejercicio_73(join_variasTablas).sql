IF OBJECT_ID('socios') IS NOT NULL
	DROP TABLE socios;
IF OBJECT_ID('deportes') IS NOT NULL
	DROP TABLE deportes;
IF OBJECT_ID('inscriptos') IS NOT NULL
	DROP TABLE inscriptos;

CREATE TABLE socios(
	documento char(8) not null, 
	nombre varchar(30),
	domicilio varchar(30),
	primary key(documento)
);

CREATE TABLE deportes(
	codigo tinyint identity,
	nombre varchar(20),
	profesor varchar(15),
	primary key(codigo)
);

CREATE TABLE inscriptos(
	documento char(8) not null, 
	codigodeporte tinyint not null,
	anio char(4),
	matricula char(1),--'s'=paga, 'n'=impaga
	primary key(documento,codigodeporte,anio)
);

INSERT INTO socios
VALUES('22222222','Ana Acosta','Avellaneda 111'),
('23333333','Betina Bustos','Bulnes 222'),
('24444444','Carlos Castro','Caseros 333'),
('25555555','Daniel Duarte','Dinamarca 44');

INSERT INTO deportes
VALUES('basquet','Juan Juarez'),
('futbol','Pedro Perez'),
('natacion','Marina Morales'),
('tenis','Marina Morales');

INSERT INTO inscriptos
VALUES('22222222',3,'2006','s'),
('23333333',3,'2006','s'),
('24444444',3,'2006','n');

INSERT INTO inscriptos
VALUES('22222222',3,'2005','s'),
('22222222',3,'2007','n');

INSERT INTO inscriptos
VALUES('24444444',1,'2006','s'),
('24444444',2,'2006','s');

INSERT INTO inscriptos
VALUES('26666666',0,'2006','s');

SELECT s.nombre, d.nombre, anio
FROM deportes AS d
RIGHT JOIN inscriptos AS i
ON codigodeporte = d.codigo
LEFT JOIN socios AS s
ON i.documento = s.documento;

SELECT s.nombre, d.nombre, anio, matricula
FROM deportes AS d
FULL JOIN inscriptos AS i
ON codigodeporte = d.codigo
FULL JOIN socios AS s
ON s.documento = i.documento;

SELECT s.nombre,d.nombre,anio,matricula
FROM deportes AS d
JOIN inscriptos AS i
ON codigodeporte = d.codigo
JOIN socios AS s
ON s.documento = i.documento
WHERE s.documento = '22222222';