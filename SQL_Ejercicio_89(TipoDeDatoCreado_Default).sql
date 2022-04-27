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

IF OBJECT_ID('VP_añoactual') IS NOT NULL
	DROP DEFAULT VP_añoactual;

CREATE DEFAULT VP_añoactual
AS datepart(year,getdate());

EXEC sp_bindefault VP_añoactual, 'tipo_año', 'futureonly';

EXEC sp_helpconstraint empleados;/*No se aplica porque no se especificó la opcion "futureonly"*/

CREATE TABLE clientes(
	documento char(8),
	nombre varchar(30),
	añoingreso tipo_año
);

EXEC sp_helpconstraint clientes;/*Vemos que se aplicó la regla*/

INSERT INTO empleados DEFAULT VALUES;
SELECT* FROM empleados;/*Se almacena null porque no hay valor predeterminado*/

INSERT INTO clientes DEFAULT VALUES;
SELECT* FROM clientes;/*Se almaceno el valor predeterminado*/

IF OBJECT_ID('VP_año2000') IS NOT NULL
	DROP DEFAULT Vp_año2000;

CREATE DEFAULT VP_año2000
AS 2000; /*Creamos un nuevo default*/

EXEC sp_bindefault VP_año2000, 'tipo_año';/*Lo asociamos*/

EXEC sp_helpconstraint empleados;/*Vemos si se asoció*/

EXEC sp_helpconstraint clientes;

INSERT INTO empleados DEFAULT VALUES;
SELECT* FROM empleados;
INSERT INTO clientes DEFAULT VALUES;
SELECT* FROM clientes;

EXEC sp_help tipo_año;

ALTER TABLE empleados
ADD CONSTRAINT DF_empleados_año
DEFAULT 1990
FOR añoingreso;/*No permite agrega otro default ya que ya tiene uno*/

EXEC sp_unbindefault 'tipo_año';/*Quitamos la asociacion*/

ALTER TABLE empleados
ADD CONSTRAINT DF_empleados_año
DEFAULT 1990
FOR añoingreso;/*Añadimos el nuevo valor default una vez quitado el anterior*/

EXEC sp_bindefault VP_añoactual, 'tipo_año';

EXEC sp_help tipo_año;

EXEC sp_helpconstraint clientes;

EXEC sp_helpconstraint empleados;