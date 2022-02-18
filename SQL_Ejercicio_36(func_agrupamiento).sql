IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;

CREATE TABLE empleados(
	nombre varchar(30),
	documento char(8),
	domicilio varchar(30),
	seccion varchar(20),
	sueldo decimal(6,2),
	cantidadhijos tinyint,
	primary key(documento)
);

INSERT INTO empleados
VALUES('Juan Perez','22333444','Colon 123','Gerencia',5000,2),
('Ana Acosta','23444555','Caseros 987','Secretaria',2000,0),
('Lucas Duarte','25666777','Sucre 235','Sistemas',4000,1),
('Pamela Gonzalez','26777888','Sarmiento 873','Secretaria',2200,3),
('Marcos Juarez','30000111','Rivadavia 801','Contaduria',3000,0),
('Yolanda Perez','35111222','Colon 180','Administracion',3200,1),
('Rodolfo Perez','35555888','Coronel Olmedo 588','Sistemas',4000,3),
('Martina Rodriguez','30141414','Sarmiento 1234','Administracion',3800,4),
('Andres Costa','28444555',default,'Secretaria',null,null);

SELECT COUNT(*) AS '# Empleados' FROM empleados;

SELECT COUNT(sueldo) FROM empleados
WHERE seccion = 'Secretaria';

SELECT MAX(sueldo) AS 'Sueldo max', MIN(sueldo) AS 'Sueldo min' FROM empleados

SELECT MAX(cantidadhijos) AS 'Hijos de Perez' FROM empleados
WHERE nombre LIKE '%Perez%';

SELECT AVG(sueldo) AS 'Promedio de sueldos' FROM empleados;

SELECT AVG(sueldo) AS 'Promedio de sueldos en Secretaria' FROM empleados
WHERE seccion = 'Secretaria';

SELECT AVG(cantidadhijos) AS 'Promedio de hijos en Sistemas' FROM empleados
WHERE seccion = 'Sistemas';