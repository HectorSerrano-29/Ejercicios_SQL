IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;

IF EXISTS (SELECT* FROM systypes
WHERE NAME = 'tipo_año')
EXEC sp_droptype tipo_año;

EXEC sp_addtype tipo_año, 'int','null';

IF OBJECT_ID('RG_año') IS NOT NULL
	DROP RULE RG_año;

CREATE RULE RG_año
AS @año BETWEEN 1990 AND datepart(year,getdate());

EXEC sp_bindrule RG_año, 'tipo_año';

CREATE TABLE empleados(
	documento char(8),
	nombre varchar(30),
	añoingreso tipo_año
);

INSERT INTO empleados
VALUES('22222222','Juan Lopez',1980);/*No se puede ingresar el registro porque es un año invalido*/

INSERT INTO empleados
VALUES('22222222','Juan Lopez',2000);

DROP RULE RG_año;/*No se puede porque esta regla está asociada a un tipo de dato*/

EXEC sp_unbindrule 'tipo_año';/*Con esto eliminamos la asociacion*/

EXEC sp_helpconstraint empleados;/*La asociacion ha sido eliminada*/
EXEC sp_help tipo_año;/*Sin embargo la regla sigue existitendo*/

DROP RULE RG_año;/*Eliminamos la regla*/

EXEC sp_help RG_año;/*Vemos que la regla ya no existe*/

INSERT INTO empleados
VALUES('22222222','Juan Lopez',1980);/*Como ya no existe la regla, entonces podemos ingresar el registro
que no cumplia con la regla para el campo año*/

EXEC sp_droptype tipo_año;/*No se puede eliminar el tipo de dato porque hay una tabla que lo utiliza*/

DROP TABLE empleados;/*Eliminamos la tabla*/

EXEC sp_help tipo_año;/*Notamos que aun existe el tipo de dato*/

EXEC sp_droptype tipo_año;/*Eliminamos el tipo de dato*/

EXEC sp_help tipo_año;/*Vemos que ya no existe el tipo de dato*/