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
@sueldo decimal(6,2)
AS
SELECT nombre,apellido,sueldo
FROM empleados
WHERE sueldo >= @sueldo;

EXEC pa_empleados_sueldo 400;
EXEC pa_empleados_sueldo 500;

EXEC pa_empleados_sueldo;

IF OBJECT_ID('pa_empleados_actualizar_sueldo') IS NOT NULL
	DROP PROCEDURE pa_empleados_actualizar_sueldo;

CREATE PROCEDURE pa_empleados_actualizar_sueldo
@sueldoanterior decimal(6,2),
@sueldonuevo decimal(6,2)
AS
UPDATE empleados SET sueldo = @sueldonuevo
WHERE sueldo = @sueldoanterior;

EXEC pa_empleados_actualizar_sueldo 300,350;
SELECT* FROM empleados;

EXEC pa_empleados_actualizar_sueldo 350;

EXEC pa_empleados_actualizar_sueldo @sueldonuevo=400,@sueldoanterior=350;

SELECT* FROM empleados;

IF OBJECT_ID('pa_sueldototal') IS NOT NULL
	DROP PROCEDURE pa_sueldototal;

CREATE PROCEDURE pa_sueldototal
@documento varchar(8) = '%'
AS
SELECT nombre,apellido,
sueldototal=
CASE
WHEN sueldo < 500 THEN sueldo+(cantidadhijos*200)
WHEN sueldo >= 500 THEN sueldo+(cantidadhijos*100)
END
FROM empleados
WHERE documento LIKE @documento;

EXEC pa_sueldototal '22333333';
EXEC pa_sueldototal '22444444';
EXEC pa_sueldototal '22666666';

EXEC pa_sueldototal;