IF OBJECT_ID('empleados') is not null
	DROP TABLE empleados;

CREATE TABLE empleados(
	nombre varchar(30) not null,
	apellido varchar(20) not null,
	documento char(8),
	fechanacimiento datetime,
	fechaingreso datetime,
	sueldo decimal(6,2),
	primary key(documento)
);

INSERT INTO empleados
VALUES('Ana','Acosta','22222222','1970/10/10','1995/05/05',228.50),
('Carlos','Caseres','25555555','1978/02/06','1998/05/05',309),
('Francisco','Garcia','26666666','1978/10/15','1998/10/02',250.68),
('Gabriela','Garcia','30000000','1985/10/25','2000/12/22',300.25),
('Luis','Lopez','31111111','1987/02/10','2000/08/21',350.98);

SELECT nombre+space(1)+upper(apellido) as nombre,
STUFF(documento,1,0,'DNI Nº ') as documento,
STUFF(sueldo,1,0,'$ ') as sueldo
FROM empleados

SELECT documento,stuff(ceiling(sueldo),1,0,'$ ') as 'sueldo redondeado'
FROM empleados;

SELECT nombre,apellido
FROM empleados
WHERE datename(month,fechanacimiento) = 'october';

SELECT nombre,apellido
FROM empleados
WHERE datepart(year,fechaingreso) = 1998;