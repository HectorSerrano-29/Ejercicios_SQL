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
('22333333','Luis','Lopez',350,0,'Contaduria'),
('22444444','Marta','Perez',500,1,'Sistemas'),
('22555555','Susana','Garcia',null,2,'Secretaria'),
('22666666','Jose Maria','Morales',460,3,'Secretaria'),
('22777777','Andres','Perez',580,3,'Sistemas'),
('22888888','Laura','Garcia',400,3,'Secretaria');

IF OBJECT_ID('pa_seccion') IS NOT NULL
DROP PROCEDURE pa_seccion;

CREATE PROCEDURE pa_seccion
@seccion varchar(20) = '%',
@promedio decimal(6,2) output,
@mayor decimal(6,2) output
AS
SELECT @promedio = avg(sueldo)
FROM empleados
WHERE seccion LIKE @seccion
SELECT @mayor = max(sueldo)
FROM empleados
WHERE seccion LIKE @seccion;

DECLARE @p decimal(6,2), @m decimal(6,2)
EXECUTE pa_seccion 'Contaduria', @p OUTPUT, @m OUTPUT
SELECT @p AS promedio, @m AS mayor

EXECUTE pa_seccion 'Secretaria', @p OUTPUT, @m OUTPUT
SELECT @p AS promedio, @m AS mayor;

DECLARE @p decimal(6,2), @m decimal(6,2)
EXECUTE pa_seccion @promedio = @p OUTPUT,@mayor = @m OUTPUT
SELECT @p AS promedio, @m AS mayor;

IF OBJECT_ID('pa_sueldototal') IS NOT NULL
	DROP PROCEDURE pa_sueldototal;

CREATE PROCEDURE pa_sueldototal
@documento varchar(8) = '%',
@sueldototal decimal(8,2) OUTPUT
AS
SELECT @sueldototal=
CASE 
WHEN sueldo < 500 THEN sueldo + (cantidadhijos*200)
WHEN sueldo >= 500 THEN sueldo + (cantidadhijos*100)
END
FROM empleados
WHERE documento LIKE @documento;

DECLARE @st decimal(8,2)
EXEC pa_sueldototal '22666666', @st OUTPUT
SELECT @st;

DECLARE @st decimal(8,2)
EXEC pa_sueldototal '22999999', @st OUTPUT
SELECT @st;

DECLARE @st decimal(8,2)
EXEC pa_sueldototal '22555555', @st OUTPUT
SELECT @st;

DECLARE @st decimal(8,2)
EXEC pa_sueldototal @sueldototal = @st OUTPUT
SELECT @st;