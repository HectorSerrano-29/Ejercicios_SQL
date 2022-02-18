IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;

CREATE TABLE empleados(
	documento varchar(8) not null,
	nombre varchar(30),
	estadocivil char(1),--c=casado, s=soltero,v=viudo
	seccion varchar(20)
);

INSERT INTO empleados
VALUES('22222222','Alberto Lopez','c','Sistemas'),
('23333333','Beatriz Garcia','c','Administracion'),
('24444444','Carlos Fuentes','s','Administracion'),
('25555555','Daniel Garcia','s','Sistemas'),
('26666666','Ester Juarez','c','Sistemas'),
('27777777','Fabian Torres','s','Sistemas'),
('28888888','Gabriela Lopez',null,'Sistemas'),
('29999999','Hector Garcia',null,'Administracion');

SELECT TOP 5 * FROM empleados

SELECT TOP 4 nombre, seccion FROM empleados
ORDER BY seccion;

SELECT TOP 4 WITH TIES nombre, seccion FROM empleados
ORDER BY seccion;

SELECT TOP 4 nombre, estadocivil, seccion FROM  empleados
ORDER BY estadocivil, seccion;

SELECT TOP 4 WITH TIES nombre, estadocivil, seccion FROM  empleados
ORDER BY estadocivil, seccion;