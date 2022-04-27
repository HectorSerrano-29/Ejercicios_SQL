IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;
IF OBJECT_ID('clientes') IS NOT NULL
	DROP TABLE clientes;

IF EXISTS (SELECT* FROM systypes
WHERE NAME = 'tipo_a�o')
EXEC sp_droptype tipo_a�o;

EXEC sp_addtype tipo_a�o, 'int', 'null';

EXEC sp_help tipo_a�o;

CREATE TABLE empleados(
	documento char(8),
	nombre varchar(30),
	a�oingreso tipo_a�o
);

IF OBJECT_ID('VP_a�oactual') IS NOT NULL
	DROP DEFAULT VP_a�oactual;

CREATE DEFAULT VP_a�oactual
AS datepart(year,getdate());

EXEC sp_bindefault VP_a�oactual, 'tipo_a�o', 'futureonly';

EXEC sp_helpconstraint empleados;/*No se aplica porque no se especific� la opcion "futureonly"*/

CREATE TABLE clientes(
	documento char(8),
	nombre varchar(30),
	a�oingreso tipo_a�o
);

EXEC sp_helpconstraint clientes;/*Vemos que se aplic� la regla*/

INSERT INTO empleados DEFAULT VALUES;
SELECT* FROM empleados;/*Se almacena null porque no hay valor predeterminado*/

INSERT INTO clientes DEFAULT VALUES;
SELECT* FROM clientes;/*Se almaceno el valor predeterminado*/

IF OBJECT_ID('VP_a�o2000') IS NOT NULL
	DROP DEFAULT Vp_a�o2000;

CREATE DEFAULT VP_a�o2000
AS 2000; /*Creamos un nuevo default*/

EXEC sp_bindefault VP_a�o2000, 'tipo_a�o';/*Lo asociamos*/

EXEC sp_helpconstraint empleados;/*Vemos si se asoci�*/

EXEC sp_helpconstraint clientes;

INSERT INTO empleados DEFAULT VALUES;
SELECT* FROM empleados;
INSERT INTO clientes DEFAULT VALUES;
SELECT* FROM clientes;

EXEC sp_help tipo_a�o;

ALTER TABLE empleados
ADD CONSTRAINT DF_empleados_a�o
DEFAULT 1990
FOR a�oingreso;/*No permite agrega otro default ya que ya tiene uno*/

EXEC sp_unbindefault 'tipo_a�o';/*Quitamos la asociacion*/

ALTER TABLE empleados
ADD CONSTRAINT DF_empleados_a�o
DEFAULT 1990
FOR a�oingreso;/*A�adimos el nuevo valor default una vez quitado el anterior*/

EXEC sp_bindefault VP_a�oactual, 'tipo_a�o';

EXEC sp_help tipo_a�o;

EXEC sp_helpconstraint clientes;

EXEC sp_helpconstraint empleados;