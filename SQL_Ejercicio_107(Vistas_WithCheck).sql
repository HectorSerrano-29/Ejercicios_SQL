EXEC sp_helpconstraint clientes

ALTER TABLE clientes
DROP CONSTRAINT FK_facturas_cliente

IF OBJECT_ID('clientes') IS NOT NULL
	DROP TABLE clientes;
IF OBJECT_ID('ciudades') IS NOT NULL
	DROP TABLE ciudades;
	
CREATE TABLE ciudades(
	codigo tinyint identity,
	nombre varchar(20),
	constraint PK_ciudades
	primary key (codigo)
);

CREATE TABLE clientes(
	nombre varchar(20),
	apellido varchar(20),
	documento char(8),
	domicilio varchar(30),
	codigociudad tinyint
	constraint FK_clientes_ciudad
	foreign key (codigociudad)
	references ciudades(codigo)
	on update cascade
);

INSERT INTO ciudades
VALUES('Cordoba'),
('Carlos Paz'),
('Cruz del Eje'),
('La Falda');

INSERT INTO clientes
VALUES('Juan','Perez','22222222','Colon 1123',1),
('Karina','Lopez','23333333','San Martin 254',2),
('Luis','Garcia','24444444','Caseros 345',1),
('Marcos','Gonzalez','25555555','Sucre 458',3),
('Nora','Torres','26666666','Bulnes 567',1),
('Oscar','Luque','27777777','San Martin 786',4);

IF OBJECT_ID('vista_clientes') IS NOT NULL
	DROP VIEW vista_clientes;

CREATE VIEW vista_clientes AS
SELECT apellido, cl.nombre, documento, domicilio, cl.codigociudad, ci.nombre AS ciudad
FROM clientes AS cl
JOIN ciudades AS ci
ON codigociudad = codigo
WHERE ci.nombre = 'Cordoba'
WITH CHECK OPTION;

SELECT* FROM vista_clientes;

UPDATE vista_clientes SET apellido = 'Pereyra'
WHERE documento = '22222222';

SELECT* FROM clientes;

UPDATE vista_clientes SET codigociudad = 2
WHERE documento = '22222222'; /*No se puede cambiar porque la vista tienen la opcion check,
al cambiarlo no cumpliria con la condicion de la vista*/