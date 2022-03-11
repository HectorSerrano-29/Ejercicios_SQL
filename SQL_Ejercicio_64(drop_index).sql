IF OBJECT_ID('alumnos') IS NOT NULL
	DROP TABLE alumnos;

CREATE TABLE alumnos(
	legajo char(5) not null,
	documento char(8) not null,
	apellido varchar(30),
	nombre varchar(30),
	notafinal decimal(4,2)
);

CREATE NONCLUSTERED INDEX I_alumnos_apellido
ON alumnos(apellido);

ALTER TABLE alumnos
ADD CONSTRAINT PK_alumnos_legajo
PRIMARY KEY CLUSTERED(legajo);

EXEC sp_helpindex alumnos;

DROP INDEX PK_alumnos_legajo;/*No es posible eliminar de esta forma*/

DROP INDEX I_alumnos_apellido;/*Al igual este marca error*/

DROP INDEX alumnos.I_alumnos_apellido;/*Especificando la tabla, podremos elimiar el índice*/

EXEC sp_helpindex alumnos;/*Verificamos si se eliminó*/

IF EXISTS (SELECT NAME FROM sysindexes
WHERE NAME = 'I_alumnos_apellido')
DROP TABLE alumnos.I_alumnos_apellido;

ALTER TABLE alumnos
DROP PK_alumnos_legajo;/*Eliminamos el índice con PK*/

EXEC sp_helpindex alumnos;