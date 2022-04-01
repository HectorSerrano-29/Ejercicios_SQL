IF OBJECT_ID('clientes') IS NOT NULL
	DROP TABLE clientes;
IF OBJECT_ID('provincias') IS NOT NULL
	DROP TABLE provincias;

CREATE TABLE clientes(
	codigo int identity,
	nombre varchar(30),
	domicilio varchar(30),
	ciudad varchar(20),
	codigoprovincia tinyint
);

CREATE TABLE provincias(
	codigo tinyint not null,
	nombre varchar(20)
);/*En este ejemplo, el campo "codigoprovincia" de "clientes" es una clave foránea, se emplea para 
enlazar la tabla "clientes" con "provincias".*/

ALTER TABLE clientes
ADD CONSTRAINT FK_clientes_codigoprovincia
FOREIGN KEY(codigoprovincia)
REFERENCES provincias(codigo);/*No se puede porque "provincias" no tiene restricción "primary key" ni "unique".*/

ALTER TABLE provincias
ADD CONSTRAINT PK_provincias_codigo
PRIMARY KEY(codigo);/*Añadimos la llave primaria a "codigo" en "provincias"*/

INSERT INTO provincias
VALUES(1,'Cordoba'),
(2,'Santa Fe'),
(3,'Misiones'),
(4,'Rio Negro');

INSERT INTO clientes
VALUES('Perez Juan','San Martin 123','Carlos Paz',1),
('Moreno Marcos','Colon 234','Rosario',2),
('Acosta Ana','Avellaneda 333','Posadas',3),
('Luisa Lopez','Juarez 555','La Plata',6);

ALTER TABLE clientes
ADD CONSTRAINT FK_clientes_codigoprovincia
FOREIGN KEY(codigoprovincia)
REFERENCES provincias(codigo);/*No se puede porque hay un registro en "clientes" cuyo valor de "codigoprovincia"
no existe en "provincias"*/

DELETE FROM clientes WHERE codigoprovincia=6;
ALTER TABLE clientes
ADD CONSTRAINT FK_clientes_codigoprovincia
FOREIGN KEY(codigoprovincia)
REFERENCES provincias(codigo);

INSERT INTO clientes
VALUES('Garcia Marcos','Colon 877','Lules',9);/*No se puede porque es un código inexistente*/

DELETE FROM provincias
WHERE codigo = 3;/*No se puede porque hay registros en cliente que le hacen referencia*/

DELETE FROM provincias
WHERE codigo=4;/*Esto si lo permite ya que no hay ningun registro en clientes que haga referencia al codigo = 4*/

UPDATE provincias SET codigo = 7
WHERE codigo=1;/*No se puede porque hay registros en clientes que le hacen referencia*/

EXEC sp_helpconstraint clientes;

EXEC sp_helpconstraint provincias;