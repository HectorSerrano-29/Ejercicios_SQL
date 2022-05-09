IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;

CREATE TABLE empleados(
	documento char(8) not null,
	nombre varchar(30) not null,
	sexo char(1),
	fechanacimiento datetime,
	fechaingreso datetime,
	cantidadhijos tinyint,
	sueldo decimal(5,2),
	primary key(documento)
);

INSERT INTO empleados
VALUES('22333111','Juan Perez','m','1970-05-10','1987-04-05',2,550),
('25444444','Susana Morales','f','1975-11-06','1990-04-06',0,650),
('20111222','Hector Pereyra','m','1965-03-25','1997-04-12',3,510),
('30000222','Luis LUque','m','1980-03-29','1999-11-06',1,700),
('20555444','Laura Torres','f','1965-12-22','2003-11-06',3,400),
('30000234','Alberto Soto','m','1989-10-10','1999-11-06',2,420),
('20125478','Ana Gomez','f','1976-09-21','1998-11-06',3,350),
('24154269','Ofelia Garcia','f','1974-05-12','1990-11-06',0,390),
('30415426','Oscar Torres','m','1978-05-02','1997-11-06',1,400);

SELECT sexo, COUNT(*) AS cantidad, obsequio =
CASE
WHEN sexo = 'f' THEN 'rosas'
ELSE 'corbata'
END
FROM empleados
WHERE datepart(month,fechanacimiento) = 5
GROUP BY sexo;

SELECT nombre, datepart(year, fechaingreso) AS añoingreso,
datepart(year, getdate()) - datepart(year, fechaingreso) AS AñosdeServicio, placa =
CASE (datepart(year, getdate()) - datepart(year, fechaingreso)) % 10
WHEN 0 THEN 'Si'  --si la cantidad de años es divisible por 10
ELSE 'No'
END
FROM empleados
WHERE datepart(month, fechaingreso) = 4;

SELECT nombre, sueldo, cantidadhijos, porhijo=
CASE
WHEN sueldo <= 500 THEN 200
ELSE 100
END,
salariofamilar =
CASE
WHEN sueldo <= 500 THEN 200*cantidadhijos
ELSE 100*cantidadhijos
END,
sueldototal=
CASE
WHEN sueldo <= 500 THEN sueldo + (200*cantidadhijos)
ELSE sueldo + (100*cantidadhijos)
END
FROM empleados
ORDER BY sueldototal;