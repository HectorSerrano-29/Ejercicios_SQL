IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;

CREATE TABLE empleados(
	apellido varchar(20),
	nombre varchar(20),
	domicilio varchar(30),
	fechaingreso datetime
);

INSERT INTO empleados(apellido,nombre)
VALUES('Rodriguez','Pablo');

ALTER TABLE empleados
ADD sueldo decimal(5,2);

EXEC sp_columns empleados;

ALTER TABLE empleados
ADD codigo int identity;

ALTER TABLE empleados
ADD documento char(8) not null;/*No se podrá agrega ya que no tiene un valor por defecto*/

ALTER TABLE empleados
ADD documento char(8) not null default '00000000';/*Con el valor default es posible que sea no nulo el valor*/

EXEC sp_columns empleados;

ALTER TABLE empleados
DROP COLUMN sueldo;/*Eliminamos el campo sueldo*/

EXEC sp_columns empleados;

ALTER TABLE empleados
DROP COLUMN documento;

ALTER TABLE empleados
DROP COLUMN codigo, fechaingreso;/*Eliminacion de dos campos*/

EXEC sp_columns empleados;