IF OBJECT_ID('alumnos') IS NOT NULL
	DROP TABLE alumnos;

CREATE TABLE alumnos(
	legajo char(5) not null,
	documento char(8) not null,
	apellido varchar(30),
	nombre varchar(30),
	notafinal decimal(4,2)
);

INSERT INTO alumnos
VALUES('A123','22222222','Perez','Patricia',5.50),
('A234','23333333','Lopez','Ana',9),
('A345','24444444','Garcia','Carlos',8.5),
('A348','25555555','Perez','Daniela',7.85),
('A457','26666666','Perez','Fabian',3.2),
('A589','27777777','Gomez','Gaston',6.90);

CREATE UNIQUE CLUSTERED INDEX I_alumnos_apellido
ON alumnos(apellido);/*Creaci�n de un �ndice agrupado �nico, este no se podr� crear porque hay valores repetidos*/

CREATE CLUSTERED INDEX I_alumnos_apellido
ON alumnos(apellido);/*Creaci�n de un �ndice agrupado no �nico, este se podr� crear
porque no es �nico as� que puede repetir valores*/

ALTER TABLE alumnos
ADD CONSTRAINT PK_alumnos_legajo
PRIMARY KEY CLUSTERED (legajo);/*Creaci�n de una llave primaria con un �ndice agrupado,
este no se podr� crear, debido a que ya existe un �ndice agrupado*/

ALTER TABLE alumnos
ADD CONSTRAINT PK_alumnos_legajo
PRIMARY KEY NONCLUSTERED (legajo);/*Creaci�n de una llave primaria con un �ndice no agrupado*/

EXEC sp_helpindex alumnos;/*Vemos los indices en alumnos*/

EXEC sp_helpconstraint alumnos;/*Vemos la llave primaria con un �ndice no agrupado*/

CREATE UNIQUE NONCLUSTERED INDEX I_alumnos_documento
ON alumnos(documento);/*Creaci�n de un �ndice no agrupado en el campo documento*/

INSERT INTO alumnos
VALUES('A789','27777777','Morales','Hector',8);/*Intentamos ingresar un alumno con un documento duplicado
pero no es posible por la restricci�n del indice creado anteriormente*/

EXEC sp_helpindex alumnos;/*Vemos los indices creados*/

CREATE INDEX I_alumnos_apellidonombre
ON alumnos(apellido,nombre);/*Creaci�n de un �ndice compuesto por apellido y nombre, por de defecto
se crear� uno no agrupado, sin embargo solo puede haber uno por tabla*/

SELECT NAME FROM sysindexes
WHERE NAME LIKE '%alumnos%';/*Proceso para ver los nombres de los �ndices creados*/

ALTER TABLE alumnos
ADD CONSTRAINT UQ_alumnos_documento
UNIQUE (documento);/*Creamos una restricci�n unica para el campo documento*/

EXEC sp_helpconstraint alumnos;/*Vemos la informaci�n de las restricciones*/

EXEC sp_helpindex alumnos;/*Vemos los �ndices de alumnos, aparecen 5 filas, 1 por cada �ndice*/

SELECT NAME FROM sysindexes
WHERE NAME LIKE '%alumnos%';/*Proceso para ver los nombres de los �ndices creados*/

SELECT NAME FROM sysindexes
WHERE NAME LIKE 'I_%';/*Proceso para ver los nombres de los �ndices creados por nosotros, en este caso 3 ya que
los que crea SQL no empiezan con I_*/