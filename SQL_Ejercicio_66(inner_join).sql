IF OBJECT_ID('clientes') IS NOT NULL
	DROP TABLE clientes;

IF OBJECT_ID('provincias') IS NOT NULL
	DROP TABLE provincias;

CREATE TABLE clientes(
	codigo int identity,
	nombre varchar(30),
	domicilio varchar(30),
	ciudad varchar(20),
	codigoprovincia tinyint not null,
	primary key(codigo)
);

CREATE TABLE provincias(
	codigo tinyint identity,
	nombre varchar(20),
	primary key (codigo)
);

INSERT INTO provincias(nombre)
VALUES('Cordoba'),('Santa Fe'),('Corrientes');

INSERT INTO clientes
VALUES('Lopez Marcos','Colon 111','Córdoba',1),
('Perez Ana','San Martin 222','Cruz del Eje',1),
('Garcia Juan','Rivadavia 333','Villa Maria',1),
('Perez Luis','Sarmiento 444','Rosario',2),
('Pereyra Lucas','San Martin 555','Cruz del Eje',1),
('Gomez Ines','San Martin 666','Santa Fe',2),
('Torres Fabiola','Alem 777','Ibera',3);

SELECT c.nombre,domicilio,ciudad,p.nombre AS provincia
FROM clientes AS c
JOIN provincias AS p
ON c.codigoprovincia = p.codigo;/*agrupa tablas por un campo en común*/

SELECT c.nombre,domicilio,ciudad,p.nombre AS provincia
FROM clientes AS c
JOIN provincias AS p
ON c.codigoprovincia = p.codigo
ORDER BY p.nombre;/*agrupamos las tablas y ordenamos por nombre*/

SELECT c.nombre,domicilio,ciudad
FROM clientes AS c
JOIN provincias AS p
ON c.codigoprovincia = p.codigo
WHERE p.nombre = 'Santa Fe';/*agrupamos las tablas solo mostramos los registros cuando el campo nombre
de la tabla provincias cuando sea igual a 'Santa Fe'*/