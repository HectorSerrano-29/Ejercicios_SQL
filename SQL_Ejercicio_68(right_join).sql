IF (OBJECT_ID('clientes')) IS NOT NULL
	DROP TABLE clientes;
IF (object_id('provincias')) IS NOT NULL
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
FROM provincias AS p/*left table*/
RIGHT JOIN clientes AS c/*right table*/
ON codigoprovincia = p.codigo;
/*Right join hace coincidir registros en una tabla (derecha) con otra tabla (izquierda)*/

SELECT c.nombre,domicilio,ciudad, p.nombre
FROM clientes AS c/*left table*/
LEFT JOIN provincias AS p/*right table*/
ON codigoprovincia = p.codigo;
/*Left join hace que la tabla de la izquierda es la que se usa para localizar registros en la tabla de la derecha*/

SELECT c.nombre,domicilio,ciudad, p.nombre
FROM provincias AS p
RIGHT JOIN clientes AS c
ON codigoprovincia = p.codigo
WHERE p.codigo IS NOT NULL;/*Muestra 5 registros, solo muestra clientes con provincias que no sean nulas*/

SELECT c.nombre,domicilio,ciudad, p.nombre
FROM provincias AS p
RIGHT JOIN clientes AS c
ON codigoprovincia = p.codigo
WHERE p.codigo IS NULL
ORDER BY ciudad;/*2 registros, solo muestra los clientes cuando las provincias sean nulas, ademas están ordenados
por nombre de ciudad*/