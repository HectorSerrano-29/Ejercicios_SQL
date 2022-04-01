IF OBJECT_ID('clientes') IS NOT NULL
	DROP TABLE clientes;

IF OBJECT_ID('provincias') IS NOT NULL
	DROP TABLE provincias;

CREATE TABLE clientes (
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
('Garcia Juan','Sucre 345','Cordoba',1),
('Lopez Susana','Caseros 998','Posadas',3),
('Marcelo Moreno','Peru 876','Viedma',4),
('Lopez Sergio','Avellaneda 333','La Plata',5);

ALTER TABLE clientes
ADD CONSTRAINT FK_clientes_codigoprovincia
FOREIGN KEY(codigoprovincia)
REFERENCES provincias(codigo)
ON UPDATE CASCADE
ON DELETE CASCADE;/*No se puede porque al no especificar opción para la comprobación de datos, por defecto es
"check" y hay un registro que no cumple con la restricción.*/

ALTER TABLE clientes
WITH NOCHECK/*Agregando esta línea lo que hace es no revisar la comprobación de datos existentes y así funciona*/
ADD CONSTRAINT FK_clientes_codigoprovincia
FOREIGN KEY(codigoprovincia)
REFERENCES provincias(codigo)
ON UPDATE CASCADE
ON DELETE CASCADE;

sp_helpconstraint clientes;/*Vemos las restricciones de clientes*/

sp_helpconstraint provincias;/*Vemos las restricciones de provincias*/

ALTER TABLE clientes
NOCHECK CONSTRAINT FK_clientes_codigoprovincia;/*Se deshabilita la restriccion de la llave foranea*/

EXEC sp_helpconstraint clientes;

EXEC sp_helpconstraint provincias;

INSERT INTO clientes
VALUES('Garcia Omar','San Martin 100','La Pampa',6);/*Este registro no cumple con la restriccion,
pero lo permite porque deshabilitamos la restriccion en la linea 56-57*/

DELETE FROM provincias
WHERE codigo = 2;/*Eliminamos esta provincia donde hay clientes registrados*/

SELECT* FROM clientes;
SELECT* FROM provincias;/*Vemos que se elimino el registro de provincias, pero no en clientes*/

UPDATE provincias SET codigo = 9
WHERE codigo = 3;/*Modificamos el codigo provincia donde hay clientes registrados*/

SELECT* FROM clientes;
SELECT* FROM provincias;/*Vemos que se modificó el registro de provincias, pero no en clientes*/

DROP TABLE provincias/*A pesar de que esté deshabilidata la restriccion de la FK, no se puede eliminar la tabla*/

ALTER TABLE clientes
CHECK CONSTRAINT FK_clientes_codigoprovincia;/*Habilitamos nuevamente la FK*/

INSERT INTO clientes
VALUES('Hector Ludueña','Paso 123','La Plata',8);/*Intentamos ingresar el registo pero no es posible
ya que la resgriccion se activó nuevamente*/

UPDATE provincias SET codigo = 20
WHERE codigo = 4;/*Actualizamos el código en provincias*/

SELECT * FROM clientes;
SELECT * FROM provincias;/*Comprobamos que se actualizó*/

DELETE FROM provincias
WHERE codigo = 1;

SELECT * FROM clientes;
SELECT * FROM provincias;

ALTER TABLE clientes
DROP CONSTRAINT FK_clientes_codigoprovincia;

EXEC sp_helpconstraint provincias;

DROP TABLE provincias;