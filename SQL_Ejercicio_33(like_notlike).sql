IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;

CREATE TABLE empleados(
	nombre varchar(30),
	documento char(8),
	domicilio varchar(30),
	fechaingreso datetime,
	seccion varchar(20),
	sueldo decimal(6,2),
	primary key(documento)
);

INSERT INTO empleados
VALUES('Juan Perez','22333444','Colon 123','1990-10-08','Gerencia',900.50),
('Ana Acosta','23444555','Caseros 987','1995-12-18','Secretaria',590.30),
('Lucas Duarte','25666777','Sucre 235','2005-05-15','Sistemas',790),
('Pamela Gonzalez','26777888','Sarmiento 873','1999-02-12','Secretaria',550),
('Marcos Juarez','30000111','Rivadavia 801','2002-09-22','Contaduria',630.70),
('Yolanda Perez','35111222','Colon 180','1990-10-08','Administracion',400),
('Rodolfo Perez','35555888','Coronel Olmedo 588','1990-05-28','Sistemas',800);

SELECT* FROM empleados
WHERE nombre LIKE '%Perez%';

SELECT* FROM empleados
WHERE domicilio LIKE 'Co%8%';

SELECT* FROM empleados
WHERE documento LIKE '%[02468]';

SELECT* FROM empleados
WHERE documento LIKE '[^13]%' AND nombre LIKE '%ez';

SELECT nombre FROM empleados
WHERE nombre LIKE '%[yj]%';

SELECT nombre, seccion FROM empleados
WHERE seccion LIKE '[sg]_______';

SELECT nombre,seccion FROM empleados
WHERE seccion NOT LIKE '[sg]%';

SELECT nombre,sueldo FROM empleados
WHERE sueldo NOT LIKE '%.00';

SELECT* FROM empleados
WHERE fechaingreso LIKE '%1990%';