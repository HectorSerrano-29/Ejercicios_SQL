IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;

IF EXISTS (SELECT NAME FROM systypes
WHERE NAME = 'tipo_legajo')
	EXEC sp_droptype tipo_legajo;

EXEC sp_addtype tipo_legajo, 'char(4)', 'not null';

EXEC sp_help tipo_legajo;

CREATE TABLE empleados(
	legajo tipo_legajo,
	documento char(8),
	nombre varchar(30)
);

INSERT INTO empleados
DEFAULT VALUES;/*No se permite ya que el campo con "tipo_legajo" no admite valores nulos
y no hay un valor default*/

INSERT INTO empleados
VALUES('A111','22222222','Juan Perez');/*Este es un registro valido*/