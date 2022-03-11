IF OBJECT_ID('clientes') IS NOT NULL
	DROP TABLE clientes;

IF OBJECT_ID('VP_legajo_patron') is not null
	DROP DEFAULT VP_legajo_patron;
IF OBJECT_ID('RG_legajo_patron') is not null
	DROP RULE RG_legajo_patron;
IF OBJECT_ID('RG_legajo') is not null
	DROP RULE RG_legajo;
IF OBJECT_ID('VP_datodesconocido') is not null
	DROP DEFAULT VP_datodesconocido;
IF OBJECT_ID('VP_fechaactual') is not null
	DROP DEFAULT VP_fechaactual;/*Eliminamos posibles reglas, si existen*/

CREATE TABLE clientes(
	legajo char(4),
	nombre varchar(30),
	domicilio varchar(30),
	ciudad varchar(15),
	provincia varchar(20) default 'Cordoba',
	fechaingreso datetime
);

CREATE RULE RG_legajo_patron
AS @valor LIKE '[A-Z][A-Z][0-9][0-9]';/*Regla para el campo legajo*/

EXEC sp_bindrule RG_legajo_patron,'clientes.legajo';/*Asociamos la regla a legajo en la tabla clientes*/

CREATE DEFAULT VP_legajo_patron
AS 'AA00';/*Creamos un valor default*/

EXEC sp_bindefault VP_legajo_patron,'clientes.legajo';/*Lo asociamos a legajo en la tabla clientes*/

CREATE DEFAULT VP_datodesconocido
AS '??';/*Creamos otro valor default*/

EXEC sp_bindefault VP_datodesconocido,'clientes.domicilio';/*Lo asociamos a domicilio en la tabla clientes*/

EXEC sp_bindefault VP_datodesconocido,'clientes.ciudad';/*También asociamos el default anterior a ciudad
en la tabla clientes, esto es posible porque es un valor default*/

INSERT INTO clientes
VALUES('GF12','Ana Perez',default,default,'Cordoba','2001-10-10');
SELECT* FROM clientes;/*Insertamos un registro con valores default y vemos que se agregó*/

EXEC sp_bindefault VP_datodesconocido,'clientes.provincia';/*Intentamos agregar el default a provincia
sin embargo no es posible ya que provincia ya tiene un valor default establecido en la creación de la tabla*/

CREATE DEFAULT VP_fechaactual
AS getdate();/*Valor default que regresa la fecha actual*/

EXEC sp_bindefault VP_fechaactual,'clientes.fechaingreso';/*Asociamos el valor default a el campo fechaingreso
en la tabla clientes*/

INSERT INTO clientes DEFAULT
VALUES;
SELECT* FROM clientes;/*Se insertan todos los datos default y vemos que se ingresa NULL en donde
no hay valores default*/

EXEC sp_bindefault VP_datodesconocido,'clientes.fechaingreso';/*Note que se asoció un valor predeterminado de tipo
caracter a un campo de tipo "datetime"; SQL Server lo permite, pero al intentar ingresar el valor
aparece un mensaje de error.*/

INSERT INTO clientes DEFAULT
VALUES;/*No lo permite porque son datos de distinto tipo*/

CREATE RULE RG_legajo
AS @valor LIKE 'B%';/*Creamos una regla que se contradiga con el patron en legajo*/

EXEC sp_bindrule RG_legajo,'clientes.legajo';/*Asociamos pero note que la regla especifica que el campo "legajo"
debe comenzar con la letra "B", pero el valor predeterminado tiene el valor "AA00";
SQL Server realiza la asociación, pero al intentar ingresar el valor predeterminado,
no puede hacerlo y muestra un mensaje de error.*/

INSERT INTO clientes
VALUES(default,'Luis Garcia','Colon 876','Cordoba','Cordoba','2001-10-10');/*No lo permite porque al intentar
ingresar el valor por defecto establecido con el valor predeterminado entra en conflicto con la regla "RG_legajo".*/