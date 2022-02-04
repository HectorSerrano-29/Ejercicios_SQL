IF OBJECT_ID('cuentas') is not null
	DROP TABLE cuentas;

CREATE TABLE cuentas(
	numero int identity,
	documento char(8) not null,
	nombre varchar(30),
	saldo money
);
/*Lineas 11 y 12 marca error ya que no se deben ingresar valores para un dato
declarado con identity*/
INSERT INTO cuentas
VALUES(1,'25666777','Juan Perez',2500.50);
--Manera correcta
INSERT INTO cuentas
VALUES('25666777','Juan Perez',2500.50);

INSERT INTO cuentas (documento)
VALUES('docEjem');
--Error por ingresar algo en un campo identity
INSERT INTO cuentas (numero,documento,nombre,saldo)
VALUES(5,'28999777','Luis Lopez',34000);
--Error ya que solo se colocaron 3 campos y se quiere ingresar 4 valores
INSERT INTO cuentas (numero,documento,nombre)
VALUES(5,'28999777','Luis Lopez',34000);
/*Error ya que documento es not null
por lo cual en cada insert se debe ingresar un valor*/
INSERT INTO cuentas (nombre)
VALUES('Luis Lopez');

SELECT* FROM cuentas