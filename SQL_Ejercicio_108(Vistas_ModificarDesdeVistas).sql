IF OBJECT_ID('inscriptos') IS NOT NULL
	DROP TABLE inscriptos;
IF OBJECT_ID('socios') IS NOT NULL
	DROP TABLE socios;
IF OBJECT_ID('cursos') IS NOT NULL
	DROP TABLE cursos;

CREATE TABLE socios(
	documento char(8) not null,
	nombre varchar(40),
	domicilio varchar(30),
	constraint PK_socios_documento
	primary key (documento)
);

CREATE TABLE cursos(
	numero tinyint identity,
	deporte varchar(20),
	dia varchar(15),
	constraint CK_inscriptos_dia check (dia in('lunes','martes','miercoles','jueves','viernes','sabado')),
	profesor varchar(20),
	constraint PK_cursos_numero
	primary key (numero),
);

CREATE TABLE inscriptos(
	documentosocio char(8) not null,
	numero tinyint not null,
	matricula char(1),
	constraint PK_inscriptos_documento_numero
	primary key (documentosocio,numero),
	constraint FK_inscriptos_documento
	foreign key (documentosocio)
	references socios(documento)
	on update cascade,
	constraint FK_inscriptos_numero
	foreign key (numero)
	references cursos(numero)
	on update cascade
);

INSERT INTO socios
VALUES('30000000','Fabian Fuentes','Caseros 987'),
('31111111','Gaston Garcia','Guemes 65'),
('32222222','Hector Huerta','Sucre 534'),
('33333333','Ines Irala','Bulnes 345');

INSERT INTO cursos
VALUES('tenis','lunes','Ana Acosta'),
('tenis','martes','Ana Acosta'),
('natacion','miercoles','Ana Acosta'),
('natacion','jueves','Carlos Caseres'),
('futbol','sabado','Pedro Perez'),
('futbol','lunes','Pedro Perez'),
('basquet','viernes','Pedro Perez');

INSERT INTO inscriptos
VALUES('30000000',1,'s'),
('30000000',3,'n'),
('30000000',6,null),
('31111111',1,'s'),
('31111111',4,'s'),
('32222222',1,'s'),
('32222222',7,'s');

SELECT documento, nombre, domicilio, c.numero, deporte, dia, profesor, matricula
FROM socios AS s
JOIN inscriptos AS i
ON s.documento = documentosocio
JOIN cursos AS c
ON c.numero = i.numero;

IF OBJECT_ID('vista_cursos') IS NOT NULL
	DROP VIEW vista_cursos;

CREATE VIEW vista_cursos AS
SELECT numero, deporte, dia
FROM cursos;

SELECT* FROM vista_cursos
ORDER BY deporte;

INSERT INTO vista_cursos VALUES('futbol','martes');
/*Puede realizarse el ingreso porque solamente afecta a una tabla base.*/
SELECT* FROM cursos;

UPDATE vista_cursos SET dia = 'miercoles' WHERE numero = 8;
/*Puede realizarse la actualización porque solamente afecta a una tabla base.*/
SELECT* FROM cursos;

DELETE FROM vista_cursos
WHERE numero = 8;
SELECT* FROM cursos;/*Puede realizarse la eliminación porque solamente afecta a una tabla base.*/

DELETE FROM vista_cursos
where numero = 1;/*No se puede eliminar por la restriccion de la FK*/

IF OBJECT_ID('vista_inscriptos') IS NOT NULL
	DROP VIEW vista_inscriptos;

CREATE VIEW vista_inscriptos AS
SELECT i.documentosocio, s.nombre, i.numero, c.deporte, dia
FROM inscriptos AS i
JOIN socios AS s
ON s.documento = documentosocio
JOIN cursos AS c
ON c.numero = i.numero;

INSERT INTO vista_inscriptos
VALUES('32222222','Hector Huerta',6,'futbol','lunes');/*No lo permite porque afecta a mas de una tabla base*/

UPDATE vista_inscriptos SET nombre = 'Fabio Fuentes'
/*Lo permite porque la modificación afecta a una sola tabla base.*/
WHERE nombre = 'Fabian Fuentes';

SELECT* FROM socios;/*Notamos que la actualizacion no afecta a la tabla base*/

UPDATE vista_inscriptos SET documentosocio = '30000111'
WHERE documentosocio = '30000000';
/*No lo permite por la restricción de la FK*/

DELETE FROM vista_inscriptos
WHERE documentosocio = '30000111' AND deporte = 'tenis';
/*No lo permite porque la vista incluye varias tablas.*/