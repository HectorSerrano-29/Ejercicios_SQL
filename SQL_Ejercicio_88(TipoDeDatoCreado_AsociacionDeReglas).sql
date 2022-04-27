IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;
IF OBJECT_ID('clientes') IS NOT NULL
	DROP TABLE clientes;

IF EXISTS (SELECT* FROM systypes
WHERE NAME = 'tipo_año')
EXEC sp_droptype tipo_año;

EXEC sp_addtype tipo_año, 'int', 'null';

EXEC sp_help tipo_año;

CREATE TABLE empleados(
	documento char(8),
	nombre varchar(30),
	añoingreso tipo_año
);

IF OBJECT_ID('RG_año') IS NOT NULL
	DROP RULE RG_año;

CREATE RULE RG_año
AS @año BETWEEN 1990 AND datepart(year,getdate());

EXEC sp_bindrule RG_año, 'tipo_año', 'futureonly';

EXEC sp_helpconstraint empleados;/*No se aplico el cambio porque colocamos para datos futuros*/

CREATE TABLE clientes(
	documento char(8),
	nombre varchar(30),
	añoingreso tipo_año
);

EXEC sp_helpconstraint clientes;/*Notamos que ahora si se hizo el cambio*/

INSERT INTO empleados
VALUES('11111111','Ana Acosta',2050);
SELECT* FROM empleados;
/*Se acepta el registro porque la tabla no tiene la restriccion*/

INSERT INTO clientes values('22222222','Juan Perez',2050);
/*No lo permite porque esta tabla tiene la restriccion*/

EXEC sp_unbindrule 'tipo_año';/*Así se quita la asociacio*/

EXEC sp_helpconstraint clientes;/*Comprobamos que se quito la asociacion*/

EXEC sp_bindrule RG_año, 'tipo_año';/*Volvemos a asociar la regla pero ahora sin "futureonly"
hay valores que no cumplen, pero SQL Server no lo verifica*/

INSERT INTO empleados
VALUES('33333333','Romina Guzman',1900);/*Este no se podrá ingresar porque no cumple*/

EXEC sp_help tipo_año;/*Vemos la informacion en RG_año*/

IF OBJECT_ID('RG_añonegativo') IS NOT NULL
	DROP RULE RG_añonegativo;/*Eliminamos la regla*/

CREATE RULE RG_añonegativo
AS @año BETWEEN -2000 AND -1;/*Creamos una regla para que valide año*/

EXEC sp_bindrule RG_añonegativo, 'clientes.añoingreso';/*Se hace la asociacion*/

EXEC sp_helpconstraint clientes;/*Vemos la asociacion*/

EXEC sp_help tipo_año;/*Tiene asociada la regla "RG_año"*/

INSERT INTO empleados
VALUES('44444444','Pedro Perez',-1900);/*No lo permite por la regla asociada*/

INSERT INTO clientes
VALUES('44444444','Pedro Perez',-1900);
SELECT * FROM clientes;