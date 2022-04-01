IF (OBJECT_ID('clientes')) IS NOT NULL
	DROP TABLE clientes;
IF (OBJECT_ID('provincias')) IS NOT NULL
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

INSERT INTO provincias (nombre)
VALUES('Cordoba'), ('Santa Fe'), ('Corrientes');

INSERT INTO clientes 
VALUES('Lopez Marcos','Colon 111','Córdoba',1),
('Perez Ana','San Martin 222','Cruz del Eje',1),
('Garcia Juan','Rivadavia 333','Villa Maria',1),
('Perez Luis','Sarmiento 444','Rosario',2),
('Gomez Ines','San Martin 666','Santa Fe',2),
('Torres Fabiola','Alem 777','La Plata',4),
('Garcia Luis','Sucre 475','Santa Rosa',5);

SELECT c.nombre, domicilio, ciudad, p.nombre
FROM clientes AS c
LEFT JOIN provincias AS p
ON codigoprovincia = p.codigo;/*En la consulta se puede ver que se muestra para la tabla clientes y en algunos clientes
no aparecen provnicias con el codigo entonces aparecen como NULL*/

SELECT c.nombre,domicilio,ciudad, p.nombre
FROM provincias AS p
LEFT JOIN clientes AS c
ON codigoprovincia = p.codigo;/*Se puede apreciar que en este caso muestra para la tabla de provincias y como no hay
registros de clientes que pertenezcan a provincias entonces aparece NULL*/

SELECT c.nombre,domicilio,ciudad, p.nombre
FROM clientes AS c
LEFT JOIN provincias AS p
ON codigoprovincia = p.codigo
WHERE p.codigo IS NOT NULL /*Aquí se muestra solamente los clientes que tienen provincias existentes*/

SELECT c.nombre, domicilio, ciudad, p.nombre
FROM clientes AS c
LEFT JOIN provincias AS p
ON codigoprovincia = p.codigo
WHERE p.codigo IS NULL
ORDER BY c.nombre; /*Se mostrará todos los clientes que no tengan provincias existentes ordenados por nombre*/

SELECT c.nombre,domicilio,ciudad, p.nombre
FROM clientes AS c
LEFT JOIN provincias AS p
ON codigoprovincia = p.codigo
WHERE p.nombre='Cordoba';/*Obtiene todos los clientes donde la residencia es Cordoba*/