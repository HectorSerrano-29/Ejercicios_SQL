IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;
IF OBJECT_ID('sucursales') IS NOT NULL
	DROP TABLE sucursales;

CREATE TABLE sucursales(
	codigo int identity,
	domicilio varchar(30),
	constraint PK_sucursales primary key (codigo)
);

CREATE TABLE empleados(
	documento char(8) not null,
	nombre varchar(30),
	domicilio varchar(30),
	sucursal int not null,
	constraint PK_empleados primary key (documento),
	constraint FK_empleados_sucursal foreign key(sucursal)
	references sucursales(codigo)
);

INSERT INTO sucursales
VALUES('Colon 123'),
('Sucre 234'),
('Rivadavia 345');

INSERT INTO empleados
VALUES('22222222','Ana Acosta','Avellaneda 1258',1),
('23333333','Betina Bustos','Bulnes 345',2),
('24444444','Carlos Caseres','Caseros 948',3),
('25555555','Fabian Fuentes','Francia 845',1),
('26666666','Gustavo Garcia','Guemes 587',2),
('27777777','Maria Morales','Maipu 643',3);

CREATE TRIGGER dis_empleados
ON empleados
FOR INSERT, UPDATE, DELETE
AS
DECLARE @suc int
IF (EXISTS (SELECT* FROM inserted WHERE sucursal = 1)) OR
(EXISTS (SELECT* FROM deleted WHERE sucursal = 1))
	BEGIN
		RAISERROR('No puede modificar datos de empleados de la sucursal 1', 16, 1)
		ROLLBACK TRANSACTION
	END;

INSERT INTO empleados
VALUES('30000000','Zulma Zapata','Suiza 258',3);

INSERT INTO empleados 
VALUES('31111111','Ricardo Rojas','Rivadavia 256',1);/*El trigger no lo permite porque afectaria 
a los empleados de la sucursal 1*/

UPDATE empleados SET domicilio = 'Avellaneda 234'
WHERE documento = '23333333';

UPDATE empleados SET domicilio = 'Avellaneda 234'
WHERE documento = '22222222';/*No lo permite porque es un empleado de la sucursal 1*/

DELETE FROM empleados
WHERE documento = '25555555';/*No lo permite eliminar porque es de la sucursal 1*/

DELETE FROM empleados
WHERE documento='30000000';