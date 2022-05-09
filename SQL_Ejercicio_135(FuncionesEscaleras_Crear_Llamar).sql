IF OBJECT_ID('consultas') IS NOT NULL
	DROP TABLE consultas;
IF OBJECT_ID('medicos') IS NOT NULL
	DROP TABLE medicos;

CREATE TABLE medicos(
	documento char(8) not null,
	nombre varchar(30),
	constraint PK_medicos 
	primary key clustered (documento)
);

CREATE TABLE consultas(
	fecha datetime,
	medico char(8) not null,
	paciente varchar(30),
	constraint PK_consultas
	primary key (fecha,medico),
	constraint FK_consultas_medico
	foreign key (medico)
	references medicos(documento)
	on update cascade
	on delete cascade
);

INSERT INTO medicos
VALUES('22222222','Alfredo Acosta'),
('23333333','Pedro Perez'),
('24444444','Marcela Morales');

INSERT INTO consultas
VALUES('2007/03/26 8:00','22222222','Juan Juarez'),
('2007/03/26 8:00','23333333','Gaston Gomez'),
('2007/03/26 8:30','22222222','Nora Norte'),
('2007/03/28 9:00','22222222','Juan Juarez'),
('2007/03/29 8:00','24444444','Nora Norte'),
('2007/03/24 8:30','22222222','Hector Huerta'),
('2007/03/24 9:30','23333333','Hector Huerta');

IF OBJECT_ID('f_nombreDia') IS NOT NULL
	DROP FUNCTION f_nombreDia;

CREATE FUNCTION f_nombreDia
(@fecha varchar(30))
RETURNS varchar(10)
AS
BEGIN
DECLARE @nombre varchar(10)
SET @nombre = 'Fecha inválida'   
IF (ISDATE(@fecha) = 1)
BEGIN
SET @fecha = CAST(@fecha AS DATETIME)
SET @nombre =
CASE datename(weekday, @fecha)
WHEN 'Monday' THEN 'lunes'
WHEN 'Tuesday' THEN 'martes'
WHEN 'Wednesday' THEN 'miércoles'
WHEN 'Thursday' THEN 'jueves'
WHEN 'Friday' THEN 'viernes'
WHEN 'Saturday' THEN 'sábado'
WHEN 'Sunday' THEN 'domingo'
END--case
END--si es una fecha válida
RETURN @nombre
END;
 
IF OBJECT_ID('f_horario') IS NOT NULL
	DROP FUNCTION f_horario;

CREATE FUNCTION f_horario
(@fecha varchar(30))
RETURNS varchar(5)
AS
BEGIN
DECLARE @nombre varchar(5)
SET @nombre = 'Fecha inválida'   
IF (ISDATE(@fecha) = 1)
BEGIN
SET @fecha = CAST(@fecha AS DATETIME)
SET @nombre = RTRIM(CAST(DATEPART(HOUR, @fecha) AS char(2))) + ':'
SET @nombre = @nombre + RTRIM(CAST(DATEPART(MINUTE, @fecha) AS char(2)))
END--si es una fecha válida
RETURN @nombre
END;

IF OBJECT_ID('f_fecha') IS NOT NULL
	DROP FUNCTION f_fecha;

CREATE FUNCTION f_fecha
(@fecha varchar(30))
RETURNS varchar(12)
AS
BEGIN
DECLARE @nombre varchar(12)
SET @nombre = 'Fecha inválida'   
IF (ISDATE(@fecha) = 1)
BEGIN
SET @fecha = CAST(@fecha AS DATETIME)
SET @nombre = RTRIM(CAST(DATEPART(DAY, @fecha) AS char(2))) + '/'
SET @nombre = @nombre + RTRIM(CAST(DATEPART(MONTH, @fecha) AS char(2))) + '/'
SET @nombre = @nombre + RTRIM(CAST(DATEPART(YEAR, @fecha) AS char(4)))
END--si es una fecha válida
RETURN @nombre
END;

SELECT dbo.f_nombredia(fecha) AS dia,
dbo.f_fecha(fecha) AS fecha,
dbo.f_horario(fecha) AS horario,
paciente
FROM consultas AS c
JOIN medicos AS m
ON m.documento = c.medico
WHERE m.nombre = 'Alfredo Acosta';

SELECT fecha, m.nombre
FROM consultas AS c
JOIN medicos AS m
ON m.documento = c.medico
WHERE dbo.f_nombredia(fecha) = 'sábado';

DECLARE @valor char(30)
SET @valor = '2007/04/09'
SELECT dbo.f_nombreDia(@valor);