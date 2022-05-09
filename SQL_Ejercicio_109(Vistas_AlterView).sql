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
('30000000',3,'s'),
('30000000',6,null),
('31111111',1,'n'),
('31111111',4,'s'),
('32222222',1,'n'),
('32222222',7,'n');

IF OBJECT_ID('vista_deudores') IS NOT NULL
	DROP VIEW vista_deudores;

CREATE VIEW vista_deudores AS
SELECT documento, nombre, c.deporte, c.dia, matricula
FROM socios AS s
JOIN inscriptos AS i
ON documento = documentosocio
JOIN cursos AS c
ON c.numero = i.numero
WHERE matricula = 'n'
WITH CHECK OPTION;

SELECT* FROM vista_deudores;

sp_helptext vista_deudores;

UPDATE vista_deudores SET matricula = 's'
WHERE documento = '31111111';/*No se puede actualizar porque la vista tiene la restriccion check*/

UPDATE vista_deudores SET documento = '31111113'
WHERE documento = '31111111';/*Modificamos un documento en la vista*/

SELECT* FROM socios;
SELECT* FROM inscriptos;/*Notamos que no afecto a ninguna de las tablas originales*/

ALTER VIEW vista_deudores WITH ENCRYPTION AS
SELECT documento, nombre, domicilio, c.deporte, c.dia, matricula
FROM socios AS s
JOIN inscriptos AS i
ON documento = documentosocio
JOIN cursos AS c
ON c.numero = i.numero
WHERE matricula = 'n';/*Modificamos la vista para añadir el campo domicilio ademas de añadir la encriptacion*/

SELECT* FROM vista_deudores;/*realiamos la consulta de la vista*/

sp_helptext vista_deudores;/*No podemos ver el texto de la vista porque esta encriptado*/

UPDATE vista_deudores SET matricula = 's'
WHERE documento = '31111113';/*Ahora si permite actualizar el documento porque la restriccion check se quitó*/

SELECT* FROM vista_deudores;/*Notamos que aparece un registro menos por la actualizacion de la linea 105-106*/

IF OBJECT_ID('vista_socios') IS NOT NULL
	DROP VIEW vista_socios;

CREATE VIEW vista_socios AS
SELECT* FROM socios;

SELECT* FROM vista_socios;

ALTER TABLE socios
ADD telefono char(10);/*Agregamos un nuevo campo a la tabla original socios*/

SELECT* FROM vista_socios;/*Notamos que no aparece el nuevo campo que se agrego en la linea 118-119*/

ALTER VIEW vista_socios AS
SELECT* FROM socios;/*Usamos alter view para que se actualice la vista con los nuevos campos de socios*/

SELECT* FROM vista_socios;/*Notamos que ahora si aparece el nuevo campo*/