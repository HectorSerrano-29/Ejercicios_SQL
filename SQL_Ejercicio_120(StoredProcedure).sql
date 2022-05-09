IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;

CREATE TABLE empleados(
	documento char(8),
	nombre varchar(20),
	apellido varchar(20),
	sueldo decimal(6,2),
	cantidadhijos tinyint,
	seccion varchar(20),
	primary key(documento)
);

INSERT INTO empleados
VALUES('22222222','Juan','Perez',300,2,'Contaduria'),
('22333333','Luis','Lopez',300,0,'Contaduria'),
('22444444','Marta','Perez',500,1,'Sistemas'),
('22555555','Susana','Garcia',400,2,'Secretaria'),
('22666666','Jose Maria','Morales',400,3,'Secretaria');

IF OBJECT_ID('pa_empleados_sueldo') IS NOT NULL
	DROP PROCEDURE pa_empleados_sueldo;

CREATE PROCEDURE pa_empleados_sueldo
AS
SELECT nombre,apellido,sueldo
FROM empleados;

EXEC pa_empleados_sueldo;

IF OBJECT_ID('pa_empleados_hijos') IS NOT NULL
	DROP PROCEDURE pa_empleados_hijos;

CREATE PROCEDURE pa_empleados_hijos
AS
SELECT nombre,apellido,cantidadhijos
FROM empleados
WHERE cantidadhijos > 0;

EXEC pa_empleados_hijos;

UPDATE empleados SET cantidadhijos = 1 WHERE documento = '22333333';
EXEC pa_empleados_hijos;