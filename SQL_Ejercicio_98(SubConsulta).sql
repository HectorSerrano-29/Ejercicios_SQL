IF OBJECT_ID('inscriptos') IS NOT NULL
	DROP TABLE inscriptos;
IF OBJECT_ID('socios') IS NOT NULL
	DROP TABLE socios;
IF OBJECT_ID('deportes') IS NOT NULL
	DROP TABLE deportes;

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
	año char(4),
	matricula char(1),--'s'=paga, 'n'=impaga
	primary key(documento,codigodeporte,año),
	constraint FK_inscriptos_socio
	foreign key (documento)
	references socios(documento)
	on update cascade
	on delete cascade
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
('24444444',3,'2006','n'),
('22222222',3,'2005','s'),
('22222222',3,'2007','n'),
('24444444',1,'2006','s'),
('24444444',2,'2006','s');

SELECT i.documento, i.codigodeporte, d.nombre AS deporte, año, matricula, d.profesor
FROM deportes AS d
JOIN inscriptos AS i
ON d.codigo = i.codigodeporte;

SELECT s.nombre, td.deporte, td.profesor, td.año, td.matricula
FROM socios AS s
JOIN (SELECT i.documento, i.codigodeporte, d.nombre AS deporte, año, matricula, d.profesor
FROM deportes AS d
JOIN inscriptos AS i
ON d.codigo = i.codigodeporte) AS td
ON td.documento = s.documento;