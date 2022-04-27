IF OBJECT_ID('inscriptos') IS NOT NULL
	DROP TABLE inscriptos;
IF OBJECT_ID('socios') IS NOT NULL
	DROP TABLE socios;
IF OBJECT_ID('profesores') IS NOT NULL
	DROP TABLE profesores;
IF OBJECT_ID('deportes') IS NOT NULL
	DROP TABLE deportes;

CREATE TABLE profesores(
	documento char(8) not null,
	nombre varchar(30),
	domicilio varchar(30),
	constraint CK_profesores_documento_patron check (documento like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	constraint PK_profesores_documento
	primary key (documento)
);

CREATE TABLE deportes(
	codigo tinyint identity,
	nombre varchar(20) not null,
	dia varchar(30)
	constraint DF_deportes_dia default('sabado'),
	profesor char(8),--documento del profesor
	constraint CK_deportes_dia_lista check (dia in ('lunes','martes','miercoles','jueves','viernes','sabado')),
	constraint PK_deportes_codigo
	primary key (codigo)
);

CREATE TABLE socios(
	numero int identity,
	documento char(8),
	nombre varchar(30),
	domicilio varchar(30),
	constraint CK_documento_patron check (documento like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	constraint PK_socios_numero
	primary key nonclustered(numero),
	constraint UQ_socios_documento
	unique clustered(documento)
);

CREATE TABLE inscriptos(
	numerosocio int not null,
	codigodeporte tinyint,
	matricula char(1),
	constraint PK_inscriptos_numerodeporte
	primary key clustered (numerosocio,codigodeporte),
	constraint FK_inscriptos_deporte
	foreign key (codigodeporte)
	references deportes(codigo)
	on update cascade,
	constraint FK_inscriptos_socios
	foreign key (numerosocio)
	references socios(numero)
	on update cascade
	on delete cascade,
	constraint CK_matricula_valores check (matricula in ('s','n'))
);

INSERT INTO profesores
VALUES('21111111','Andres Acosta','Avellaneda 111'),
('22222222','Betina Bustos','Bulnes 222'),
('23333333','Carlos Caseros','Colon 333');

INSERT INTO deportes
VALUES('basquet','lunes',null),
('futbol','lunes','23333333'),
('natacion',null,'22222222'),
('padle',default,'23333333');
INSERT INTO deportes (nombre,dia) 
VALUES('tenis','jueves');

INSERT INTO socios
VALUES('30111111','Ana Acosta','America 111'),
('30222222','Bernardo Bueno','Bolivia 222'),
('30333333','Camila Conte','Caseros 333'),
('30444444','Daniel Duarte','Dinamarca 444');

INSERT INTO inscriptos
VALUES(1,3,'s'),
(1,5,'s'),
(2,1,'s'),
(4,1,'n'),
(4,4,'s');

SELECT s.*, d.nombre AS deporte, d.dia, p.nombre AS profesor
FROM socios AS s
JOIN inscriptos AS i
ON numero = i.numerosocio
JOIN deportes AS d
ON d.codigo = i.codigodeporte
LEFT JOIN profesores AS p
ON d.profesor = p.documento;

SELECT s.*, d.nombre AS deporte, d.dia, p.nombre AS profesor
FROM socios AS s
FULL JOIN inscriptos AS i
ON numero = i.numerosocio
LEFT JOIN deportes AS d
ON d.codigo = i.codigodeporte
LEFT JOIN profesores AS p
ON d.profesor = p.documento;

SELECT p.*, d.nombre AS deporte, d.dia
FROM profesores AS p
LEFT JOIN deportes AS d
ON d.profesor = p.documento;

SELECT d.nombre, COUNT(i.codigodeporte) AS cantidad
FROM deportes AS d
LEFT JOIN inscriptos AS i
ON d.codigo = i.codigodeporte
GROUP BY d.nombre;

EXEC sp_helpconstraint socios;

EXEC sp_helpconstraint deportes;

EXEC sp_helpconstraint profesores;

EXEC sp_helpconstraint inscriptos;