IF OBJECT_ID('alumnos') is not null
DROP TABLE alumnos;

CREATE TABLE alumnos(
	apellido varchar(30),
	nombre varchar(30),
	documento char(8),
	domicilio varchar(30),
	fechaingreso datetime,
	fechanacimiento datetime
);

SET DATEFORMAT 'dmy';

INSERT INTO alumnos
VALUES('Gonzalez','Ana','22222222','Colon 123','10-08-1990','15/02/1972');

INSERT INTO alumnos
VALUES('Juarez','Bernardo','25555555','Sucre 456','03-03-1991','15/02/1972');

INSERT INTO alumnos
VALUES('Perez','Laura','26666666','Bulnes 345','03-03-91',null);

INSERT INTO alumnos 
VALUES('Lopez','Carlos','27777777','Sarmiento 1254','03-15-1990',null);

SELECT* FROM alumnos
WHERE fechaingreso < '1-1-91';

SELECT* FROM alumnos
WHERE fechanacimiento is null;

INSERT INTO alumnos
VALUES('Rosas','Romina','28888888','Avellaneda 487','03151990',null);

set dateformat 'mdy';

INSERT INTO alumnos 
VALUES('Lopez','Carlos','27777777','Sarmiento 1254','03-15-1990',null);