IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;

CREATE TABLE empleados(
	documento varchar(8) not null,
	nombre varchar(30),
	sexo char(1),
	estadocivil char(1),--c=casado, s=soltero,v=viudo
	seccion varchar(20),
	primary key (documento)
);

INSERT INTO empleados
VALUES('22222222','Alberto Lopez','m','c','Sistemas'),
('23333333','Beatriz Garcia','f','c','Administracion'),
('24444444','Carlos Fuentes','m','s','Administracion'),
('25555555','Daniel Garcia','m','s','Sistemas'),
('26666666','Ester Juarez',null,'c','Sistemas'),
('27777777','Fabian Torres',null,'s','Sistemas'),
('28888888','Gabriela Lopez','f',null,'Sistemas'),
('29999999','Hector Garcia','m',null,'Administracion');

SELECT sexo, estadocivil, COUNT(*) AS 'Empleados' FROM empleados
GROUP BY sexo, estadocivil WITH ROLLUP

SELECT sexo, estadocivil, COUNT(*) AS 'Empleados',
GROUPING(sexo) AS 'Resumen sexo', GROUPING(estadocivil) AS 'Resumen EdoCivil' FROM empleados
GROUP BY sexo, estadocivil WITH ROLLUP

SELECT sexo, estadocivil, COUNT(*) AS 'Empleados',
GROUPING(sexo) AS 'Resumen sexo', GROUPING(estadocivil) AS 'Resumen EdoCivil' FROM empleados
GROUP BY sexo, estadocivil WITH CUBE