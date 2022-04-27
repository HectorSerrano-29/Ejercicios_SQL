IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;

IF EXISTS (SELECT* FROM systypes
WHERE NAME = 'tipo_a�o')
EXEC sp_droptype tipo_a�o;

EXEC sp_addtype tipo_a�o, 'int','null';

IF OBJECT_ID('RG_a�o') IS NOT NULL
	DROP RULE RG_a�o;

CREATE RULE RG_a�o
AS @a�o BETWEEN 1990 AND datepart(year,getdate());

EXEC sp_bindrule RG_a�o, 'tipo_a�o';

CREATE TABLE empleados(
	documento char(8),
	nombre varchar(30),
	a�oingreso tipo_a�o
);

INSERT INTO empleados
VALUES('22222222','Juan Lopez',1980);/*No se puede ingresar el registro porque es un a�o invalido*/

INSERT INTO empleados
VALUES('22222222','Juan Lopez',2000);

DROP RULE RG_a�o;/*No se puede porque esta regla est� asociada a un tipo de dato*/

EXEC sp_unbindrule 'tipo_a�o';/*Con esto eliminamos la asociacion*/

EXEC sp_helpconstraint empleados;/*La asociacion ha sido eliminada*/
EXEC sp_help tipo_a�o;/*Sin embargo la regla sigue existitendo*/

DROP RULE RG_a�o;/*Eliminamos la regla*/

EXEC sp_help RG_a�o;/*Vemos que la regla ya no existe*/

INSERT INTO empleados
VALUES('22222222','Juan Lopez',1980);/*Como ya no existe la regla, entonces podemos ingresar el registro
que no cumplia con la regla para el campo a�o*/

EXEC sp_droptype tipo_a�o;/*No se puede eliminar el tipo de dato porque hay una tabla que lo utiliza*/

DROP TABLE empleados;/*Eliminamos la tabla*/

EXEC sp_help tipo_a�o;/*Notamos que aun existe el tipo de dato*/

EXEC sp_droptype tipo_a�o;/*Eliminamos el tipo de dato*/

EXEC sp_help tipo_a�o;/*Vemos que ya no existe el tipo de dato*/