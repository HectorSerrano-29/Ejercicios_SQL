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

EXEC sp_helpindex alumnos;/*Información sobre los índices*/

CREATE NONCLUSTERED INDEX I_alumnos_apellido
ON alumnos(apellido,nombre)
WITH DROP_EXISTING;

EXEC sp_helpindex alumnos;

ALTER TABLE alumnos
ADD CONSTRAINT UQ_alumnos_documento
UNIQUE NONCLUSTERED(documento);

EXEC sp_helpindex alumnos;

CREATE CLUSTERED INDEX UQ_alumnos_documento
ON alumnos(documento)
WITH DROP_EXISTING;/*No se puede emplear "drop_existing" con índices creados a partir de una restricción*/

CREATE NONCLUSTERED INDEX I_alumnos_legajo
ON alumnos(legajo);

EXEC sp_helpindex alumnos;

CREATE CLUSTERED INDEX I_alumnos_legajo
ON alumnos(legajo)
WITH DROP_EXISTING;

EXEC sp_helpindex alumnos;

CREATE NONCLUSTERED INDEX I_alumnos_legajo
ON alumnos(legajo)
WITH DROP_EXISTING;/*No se puede convertir un índice agrupado en no agrupado.*/

CREATE NONCLUSTERED INDEX I_alumnos_apellido
ON alumnos(apellido)
WITH DROP_EXISTING;/*Modificamos el índice quitando el campo nombre*/

CREATE CLUSTERED INDEX I_alumnos_apellido
ON alumnos(apellido)
WITH DROP_EXISTING;/*No se pueden modificar el índice a agrupado debido a que ya existe uno*/

CREATE UNIQUE CLUSTERED INDEX I_alumnos_legajo
ON alumnos(legajo)
WITH DROP_EXISTING;

EXEC sp_helpindex alumnos;

CREATE CLUSTERED INDEX I_alumnos_legajo
ON alumnos(legajo)
WITH DROP_EXISTING;/*Se modifica para que ya no sea único*/

EXEC sp_helpindex alumnos;