IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;
IF OBJECT_ID('secciones') IS NOT NULL
	DROP TABLE secciones;

CREATE TABLE secciones(
	codigo int identity,
	nombre varchar(30),
	sueldomaximo decimal(8,2), 
	constraint PK_secciones primary key(codigo)
);

CREATE TABLE empleados(
	documento char(8) not null,
	nombre varchar(30) not null,
	domicilio varchar(30),
	codigoseccion int not null,
	sueldo decimal(8,2),
	constraint PK_empleados primary key(documento),
	constraint FK_empelados_seccion
	foreign key (codigoseccion) references secciones(codigo)
);

INSERT INTO secciones
VALUES('Administracion',1500),
('Sistemas',2000),
('Secretaria',1000);

INSERT INTO empleados
VALUES('22222222','Ana Acosta','Avellaneda 88',1,1100),
('23333333','Bernardo Bustos','Bulnes 345',1,1200),
('24444444','Carlos Caseres','Colon 674',2,1800),
('25555555','Diana Duarte','Colon 873',3,1000);

CREATE TRIGGER dis_empleados_insertar
ON empleados
FOR INSERT
AS
DECLARE @maximo decimal(8,2)
SET @maximo = (SELECT sueldomaximo FROM secciones
    JOIN inserted
    ON inserted.codigoseccion = secciones.codigo)
IF (@maximo < (SELECT sueldo FROM inserted))
BEGIN
DECLARE @mensaje varchar(40)
SET @mensaje = 'El sueldo debe ser menor a ' + CAST(@maximo AS char(8))
RAISERROR(@mensaje, 16, 1)
ROLLBACK TRANSACTION
END;

INSERT INTO empleados
VALUES('26666666','Federico Fuentes','Francia 938',2,1000);

SELECT* FROM empleados;

INSERT INTO empleados
VALUES('27777777','Gaston Garcia','Guemes 366',3,1200);/*Aquí aparecera el mensaje que colocamos
en el trigger y eliminara la insercion*/

SELECT* FROM empleados;

INSERT INTO empleados
VALUES('27777777','Gaston Garcia','Guemes 366',9,1200);/*mensaje de error porque se viola la restricción
FK el trigger no llegó a ejecutarse.*/