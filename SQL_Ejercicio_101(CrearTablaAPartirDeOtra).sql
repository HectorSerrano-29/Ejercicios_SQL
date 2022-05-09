IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;
IF OBJECT_ID('sucursales') IS NOT NULL
	DROP TABLE sucursales;

CREATE TABLE sucursales( 
	codigo int identity,
	ciudad varchar(30) not null,
	primary key(codigo)
);

CREATE TABLE empleados( 
	documento char(8) not null,
	nombre varchar(30) not null,
	domicilio varchar(30),
	seccion varchar(20),
	sueldo decimal(6,2),
	codigosucursal int,
	primary key(documento),
	constraint FK_empleados_sucursal
	foreign key (codigosucursal)
	references sucursales(codigo)
	on update cascade
); 

INSERT INTO sucursales
VALUES('Cordoba'),
('Villa Maria'),
('Carlos Paz'),
('Cruz del Eje');

INSERT INTO empleados VALUES('22222222','Ana Acosta','Avellaneda 111','Secretaria',500,1),
('23333333','Carlos Caseros','Colon 222','Sistemas',800,1),
('24444444','Diana Dominguez','Dinamarca 333','Secretaria',550,2),
('25555555','Fabiola Fuentes','Francia 444','Sistemas',750,2),
('26666666','Gabriela Gonzalez','Guemes 555','Secretaria',580,3),
('27777777','Juan Juarez','Jujuy 777','Secretaria',500,4),
('28888888','Luis Lopez','Lules 888','Sistemas',780,4),
('29999999','Maria Morales','Marina 999','Contaduria',670,4);

SELECT documento, nombre, domicilio, seccion, sueldo, ciudad
FROM empleados
JOIN sucursales ON codigosucursal = codigo;

IF OBJECT_ID('secciones') IS NOT NULL
	DROP TABLE secciones;

SELECT DISTINCT seccion AS nombre
INTO secciones/*Nombre de la nueva tabla*/
FROM empleados;/*Creacion de una tabla apartir de una consulta*/

SELECT* FROM secciones;

IF OBJECT_ID('sueldosxseccion') IS NOT NULL
	DROP TABLE sueldosxseccion;

SELECT seccion, sum(sueldo) AS total
INTO sueldosxseccion
FROM empleados
GROUP BY seccion;

SELECT* FROM sueldosxseccion;

IF OBJECT_ID('maximossueldos') IS NOT NULL
	DROP TABLE maximossueldos;

SELECT TOP 3 *
INTO maximossueldos
FROM empleados
ORDER BY sueldo;

SELECT* FROM maximossueldos;

IF OBJECT_ID('sucursalCordoba') IS NOT NULL
	DROP TABLE sucursalCordoba;

SELECT nombre, ciudad
INTO sucursalCordoba
FROM empleados
JOIN sucursales
ON codigosucursal = codigo
WHERE ciudad = 'Cordoba';

SELECT* FROM sucursalCordoba;