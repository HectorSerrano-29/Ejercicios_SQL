IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;

CREATE TABLE empleados(
	legajo int not null,
	documento char(7) not null,
	nombre varchar(10),
	domicilio varchar(30),
	ciudad varchar(20) default 'Buenos Aires',
	sueldo decimal(6,2),
	cantidadhijos tinyint default 0,
	primary key(legajo)
);

ALTER TABLE empleados
ALTER COLUMN nombre varchar(30);/*Alter, actualiza los parametros de los campos de la tabla*/

sp_columns empleados;/*Vemos si se modificó*/

ALTER TABLE empleados
ALTER COLUMN sueldo decimal(6,2) not null;

ALTER TABLE empleados
ALTER COLUMN documento char(8) not null;

ALTER TABLE empleados
ALTER COLUMN legajo tinyint not null;/*No se puede porque tiene una restriccion*/

INSERT INTO empleados
VALUES(1,'22222222','Juan Perez','Colon 123','Cordoba',500,3),
(2,'30000000',null,'Sucre 456','Cordoba',600,2);

ALTER TABLE empleados
ALTER COLUMN nombre varchar(30) not null;/*No se puede modificar porque hay registros nulos*/

DELETE FROM empleados
WHERE nombre IS NULL;/*Eliminamos los registros nulos*/

ALTER TABLE empleados
ALTER COLUMN nombre varchar(30) not null;/*Ahora lo modificamos ya que no hay ningun registro nulo que lo afecte*/

ALTER TABLE empleados
ALTER COLUMN ciudad varchar(10);

INSERT INTO empleados values(3,'33333333','Juan Perez','Sarmiento 856',default,500,4);

ALTER TABLE empleados
ALTER COLUMN ciudad varchar(15);

INSERT INTO empleados values(3,'33333333','Juan Perez','Sarmiento 856',default,500,4);

ALTER TABLE empleados
ALTER COLUMN legajo int identity;