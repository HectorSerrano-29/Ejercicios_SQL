IF OBJECT_ID('clientes') IS NOT NULL
	DROP TABLE clientes;

CREATE TABLE clientes(
	codigo int not null,
	nombre varchar(30),
	domicilio varchar(30),
	ciudad varchar(20),
	referenciadopor int,
	primary key(codigo)
);

INSERT INTO clientes
VALUES(50,'Juan Perez','Sucre 123','Cordoba',null),
(90,'Marta Juarez','Colon 345','Carlos Paz',null),
(110,'Fabian Torres','San Martin 987','Cordoba',50),
(125,'Susana Garcia','Colon 122','Carlos Paz',90),
(140,'Ana Herrero','Colon 890','Carlos Paz',9);

ALTER TABLE clientes
ADD CONSTRAINT FK_clientes_referenciadopor
FOREIGN KEY (referenciadopor)
REFERENCES clientes (codigo);/*No lo permite porque hay un registro que no cumple la restricción*/

UPDATE clientes SET referenciadopor = 90
WHERE referenciadopor = 9;/*Modificamos el dato invalido para poder añadir la FK*/

ALTER TABLE clientes
ADD CONSTRAINT FK_clientes_referenciadopor
FOREIGN KEY (referenciadopor)
REFERENCES clientes (codigo);/*Agregamos la FK*/

EXEC sp_helpconstraint clientes;/*Vemos la informacion de la restriccion*/

INSERT INTO clientes
VALUES(150,'Karina Gomez','Caseros 444','Cruz del Eje',8);/*Vemos que no se puede ingresar ya que infringe la FK*/

UPDATE clientes SET codigo = 180
WHERE codigo = 90;

DELETE FROM clientes
WHERE nombre = 'Marta Juarez';/*No podemos modificar ni eliminar por la FK*/

UPDATE clientes SET codigo = 180
WHERE codigo = 125;/*Cambiamos este código que no hace referencia a ningun cliente*/

DELETE FROM clientes
WHERE codigo = 110;/*Ahora eliminamos el cliente que no referenció a otros*/