IF OBJECT_ID('clientes') IS NOT NULL
	DROP TABLE clientes;
IF OBJECT_ID('provincias') IS NOT NULL
	DROP TABLE provincias;

CREATE TABLE clientes(
	codigo int identity,
	nombre varchar(30),
	domicilio varchar(30),
	ciudad varchar(20),
	codigoprovincia tinyint,
	primary key(codigo)
);

CREATE TABLE provincias(
	codigo tinyint,
	nombre varchar(20),
	primary key (codigo)
);

INSERT INTO provincias
VALUES(1,'Cordoba'),
(2,'Santa Fe'),
(3,'Misiones'),
(4,'Rio Negro');

INSERT INTO clientes
VALUES('Perez Juan','San Martin 123','Carlos Paz',1),
('Moreno Marcos','Colon 234','Rosario',2),
('Acosta Ana','Avellaneda 333','Posadas',3);

ALTER TABLE clientes
ADD CONSTRAINT FK_clientes_codigoprovincia
FOREIGN KEY (codigoprovincia)
REFERENCES provincias(codigo)
ON UPDATE CASCADE
ON DELETE NO ACTION;

DELETE FROM provincias
WHERE codigo = 3;/*No se puede porque hay registros en "clientes" al cual hace referencia y la opción para 
eliminaciones se estableció como "no action".*/

UPDATE provincias SET codigo = 9
WHERE codigo = 3;

SELECT* FROM provincias;
SELECT* FROM clientes;/*Verificamos que el cambio se realizó en cascada, es decir, que se modificó
en la tabla "provincias" y en "clientes":*/

ALTER TABLE clientes
ADD CONSTRAINT FK_clientes_codigoprovincia
FOREIGN KEY (codigoprovincia)
REFERENCES provincias(codigo)
ON UPDATE CASCADE,
ON DELETE CASCADE;/*No podemos modificar las restricciones*/

DROP TABLE provincias;/*No se puede eliminar porque tiene una restriccion de FK*/