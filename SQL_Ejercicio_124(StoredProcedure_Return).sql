IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;

CREATE TABLE empleados(
	documento char(8),
	nombre varchar(20),
	apellido varchar(20),
	cantidadhijos tinyint,
	seccion varchar(20),
	primary key(documento)
);

INSERT INTO empleados
VALUES('22222222','Juan','Perez',2,'Contaduria'),
('22333333','Luis','Lopez',0,'Contaduria'),
('22444444','Marta','Perez',NULL,'Sistemas'),
('22555555','Susana','Garcia',2,'Secretaria'),
('22666666','Jose Maria','Morales',1,'Secretaria'),
('22777777','Andres','Perez',3,'Sistemas'),
('22888888','Laura','Garcia',3,'Secretaria');

IF OBJECT_ID('pa_empleados_seccion') IS NOT NULL
DROP PROCEDURE pa_empleados_seccion;

CREATE PROCEDURE pa_empleados_seccion
@seccion varchar(20) = null
AS
IF @seccion IS NULL
BEGIN
SELECT 'Debe indicar una seccion'
RETURN
END
SELECT nombre FROM empleados WHERE seccion = @seccion;

EXEC pa_empleados_seccion 'Secretaria';

EXEC pa_empleados_seccion;

IF OBJECT_ID('pa_actualizarhijos') IS NOT NULL
DROP PROCEDURE pa_actualizarhijos;

CREATE PROCEDURE pa_actualizarhijos
@documento char(8) = null,
@hijos tinyint = null
AS
IF (@documento IS NULL) OR (@hijos IS NULL)
RETURN 0
ELSE
BEGIN
UPDATE empleados SET cantidadhijos = @hijos WHERE documento = @documento
RETURN 1
END;

DECLARE @retorno int
EXEC @retorno = pa_actualizarhijos '22222222',3
SELECT 'Registro actualizado=1' = @retorno;

SELECT* FROM empleados;

DECLARE @retorno int
EXEC @retorno = pa_actualizarhijos '22333333'
SELECT 'Registro actualizado=1' = @retorno;

SELECT* FROM empleados;

DECLARE @retorno int
EXEC @retorno = pa_actualizarhijos '22333333',2
IF @retorno = 1 SELECT 'Registro actualizado'
ELSE SELECT 'Registro no actualizado, se necesita un documento y la cantidad de hijos';

SELECT* FROM empleados;

DECLARE @retorno int
EXEC @retorno = pa_actualizarhijos @hijos=4
IF @retorno = 1 SELECT 'Registro actualizado'
ELSE SELECT 'Registro no actualizado, se necesita un documento y la cantidad de hijos';