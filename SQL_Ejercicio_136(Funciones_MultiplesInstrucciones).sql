IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;

CREATE TABLE empleados(
	documento char(8) not null,
	apellido varchar(30) not null,
	nombre varchar(30) not null,
	domicilio varchar(30),
	ciudad varchar(30),
	fechanacimiento datetime,
	constraint PK_empleados
	primary key(documento)
);

INSERT INTO empleados
VALUES('22222222','Acosta','Ana','Avellaneda 123','Cordoba','1970/10/10'),
('23333333','Bustos','Bernardo','Bulnes 234','Cordoba','1972/05/15'),
('24444444','Caseros','Carlos','Colon 356','Carlos Paz','1980/02/25'),
('25555555','Fuentes','Fabiola','Fragueiro 987','Jesus Maria','1984/06/12');

IF OBJECT_ID('f_empleados') IS NOT NULL
	DROP FUNCTION f_empleados;

CREATE FUNCTION f_empleados
(@opcion varchar(10)
)
RETURNS @listado TABLE
(documento char(8),
nombre varchar(60),
domicilio varchar(60),
nacimiento varchar(12))
AS 
BEGIN
IF @opcion NOT IN ('total','parcial')
SET @opcion = 'parcial'
IF @opcion = 'total'
INSERT @listado 
SELECT documento,
(apellido + ' ' + nombre),
(domicilio + ' (' + ciudad + ')'), 
CAST(fechanacimiento AS varchar(12))
FROM empleados
ELSE
INSERT @listado
SELECT documento, apellido, ciudad, CAST(DATEPART(YEAR, fechanacimiento) AS char(4))
FROM empleados
RETURN
END;

SELECT* FROM dbo.f_empleados('total');

SELECT* FROM dbo.f_empleados();/*Manda error ya que debe recibir un argumento la funcion*/

SELECT* FROM dbo.f_empleados('');

SELECT* FROM dbo.f_empleados('parcial')
WHERE domicilio = 'Cordoba';