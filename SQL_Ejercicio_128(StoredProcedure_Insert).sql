EXEC sp_help alumnos;/*Veo la foreign key que tenia la tabla*/

ALTER TABLE dbo.notas
DROP CONSTRAINT FK_notas_documento;/*Elimino la FK de la tabla para poder crearla nuevamente*/

IF OBJECT_ID('alumnos') IS NOT NULL
	DROP TABLE alumnos;

CREATE TABLE alumnos(
	documento char(8),
	nombre varchar(40),
	nota decimal(4,2),
	primary key(documento)
);

INSERT INTO alumnos
VALUES('22222222','Pedro Lopez',5),
('23333333','Ana Lopez',4),
('24444444','Maria Juarez',8),
('25555555','Juan Garcia',5.6),
('26666666','Karina Torres',2),
('27777777','Nora Torres',7.5),
('28888888','Mariano Herrero',3.5);

IF OBJECT_ID('aprobados') IS NOT NULL
	DROP TABLE aprobados;

CREATE TABLE aprobados(
	documento char(8),
	nombre varchar(40),
	nota decimal(4,2)
);

IF OBJECT_ID('desaprobados') IS NOT NULL
	DROP TABLE desaprobados;

CREATE TABLE desaprobados(
	documento char(8),
	nombre varchar(40)
);

IF OBJECT_ID('pa_aprobados') IS NOT NULL
	DROP PROCEDURE pa_aprobados;

CREATE PROC pa_aprobados
AS
SELECT*
FROM alumnos
WHERE nota >= 4;

INSERT INTO aprobados
EXEC pa_aprobados;

SELECT* FROM aprobados;

IF OBJECT_ID('pa_desaprobados') IS NOT NULL
DROP PROCEDURE pa_desaprobados;

CREATE PROC pa_desaprobados
AS
SELECT documento,nombre
FROM alumnos
WHERE nota < 4;

INSERT INTO desaprobados
EXEC pa_desaprobados;

SELECT* FROM desaprobados;