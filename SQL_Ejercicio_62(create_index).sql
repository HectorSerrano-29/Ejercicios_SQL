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
ON alumnos(apellido);/*Creación de un índice agrupado único, este no se podrá crear porque hay valores repetidos*/

CREATE CLUSTERED INDEX I_alumnos_apellido
ON alumnos(apellido);/*Creación de un índice agrupado no único, este se podrá crear
porque no es único así que puede repetir valores*/

ALTER TABLE alumnos
ADD CONSTRAINT PK_alumnos_legajo
PRIMARY KEY CLUSTERED (legajo);/*Creación de una llave primaria con un índice agrupado,
este no se podrá crear, debido a que ya existe un índice agrupado*/

ALTER TABLE alumnos
ADD CONSTRAINT PK_alumnos_legajo
PRIMARY KEY NONCLUSTERED (legajo);/*Creación de una llave primaria con un índice no agrupado*/

EXEC sp_helpindex alumnos;/*Vemos los indices en alumnos*/

EXEC sp_helpconstraint alumnos;/*Vemos la llave primaria con un índice no agrupado*/

CREATE UNIQUE NONCLUSTERED INDEX I_alumnos_documento
ON alumnos(documento);/*Creación de un índice no agrupado en el campo documento*/

INSERT INTO alumnos
VALUES('A789','27777777','Morales','Hector',8);/*Intentamos ingresar un alumno con un documento duplicado
pero no es posible por la restricción del indice creado anteriormente*/

EXEC sp_helpindex alumnos;/*Vemos los indices creados*/

CREATE INDEX I_alumnos_apellidonombre
ON alumnos(apellido,nombre);/*Creación de un índice compuesto por apellido y nombre, por de defecto
se creará uno no agrupado, sin embargo solo puede haber uno por tabla*/

SELECT NAME FROM sysindexes
WHERE NAME LIKE '%alumnos%';/*Proceso para ver los nombres de los índices creados*/

ALTER TABLE alumnos
ADD CONSTRAINT UQ_alumnos_documento
UNIQUE (documento);/*Creamos una restricción unica para el campo documento*/

EXEC sp_helpconstraint alumnos;/*Vemos la información de las restricciones*/

EXEC sp_helpindex alumnos;/*Vemos los índices de alumnos, aparecen 5 filas, 1 por cada índice*/

SELECT NAME FROM sysindexes
WHERE NAME LIKE '%alumnos%';/*Proceso para ver los nombres de los índices creados*/

SELECT NAME FROM sysindexes
WHERE NAME LIKE 'I_%';/*Proceso para ver los nombres de los índices creados por nosotros, en este caso 3 ya que
los que crea SQL no empiezan con I_*/