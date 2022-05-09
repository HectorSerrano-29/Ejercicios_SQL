IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;

CREATE TABLE empleados(
	documento char(8) not null,
	nombre varchar(30) not null,
	sexo char(1),
	fechanacimiento datetime,
	sueldo decimal(5,2),
	primary key(documento)
);

INSERT INTO empleados
VALUES('22333111','Juan Perez','m','1970-05-10',550),
('25444444','Susana Morales','f','1975-11-06',650),
('20111222','Hector Pereyra','m','1965-03-25',510),
('30000222','Luis LUque','m','1980-03-29',700),
('20555444','Laura Torres','f','1965-12-22',400),
('30000234','Alberto Soto','m','1989-10-10',420),
('20125478','Ana Gomez','f','1976-09-21',350),
('24154269','Ofelia Garcia','f','1974-05-12',390),
('30415426','Oscar Torres','m','1978-05-02',400);

IF EXISTS(SELECT * FROM empleados
WHERE datepart(month, fechanacimiento) = 5)--si hay empleados que cumplan en mayo
	(SELECT sexo, count(*) AS cantidad 
	FROM empleados
	WHERE datepart(month, fechanacimiento) = 5
	GROUP BY sexo)
ELSE SELECT 'no hay empleados que cumplan en mayo';