IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;
IF OBJECT_ID('secciones') IS NOT NULL
	DROP TABLE secciones;

CREATE TABLE secciones(
	codigo int identity,
	nombre varchar(30),
	constraint pk_secciones primary key (codigo)
); 

CREATE TABLE empleados(
	documento char(8) not null,
	nombre varchar(30),
	domicilio varchar(30),
	seccion int not null,
	constraint pk_empleados primary key (documento),
	constraint fk_empleados_seccion foreign key(seccion)
	references secciones (codigo)
);

INSERT INTO secciones
VALUES('Secretaria'),
('Sistemas'),
('Contaduría'),
('Gerencia');

INSERT INTO empleados
VALUES('22222222','Alejandro Acosta','Avellaneda 90',1),
('22333333','Betina Bustos','Bulnes 345',2),
('23444444','Camila Costa','Colon 234',1),
('23555555','Daniel Duarte','Duarte Quiros 345',3),
('23666666','Estela Esperanza','España 211',4);

CREATE TRIGGER dis_empleados_borrar
ON empleados
AFTER DELETE
AS
DECLARE @seccion int
SELECT @seccion = codigo FROM secciones WHERE nombre = 'Gerencia'
DECLARE @borrados int
SELECT @borrados = COUNT(*)FROM deleted
DECLARE @insertados int
SELECT @insertados = COUNT(*)FROM inserted
	IF EXISTS (SELECT* FROM deleted WHERE seccion = @seccion)
	BEGIN
		INSERT INTO empleados SELECT documento, nombre, domicilio, seccion FROM deleted
		WHERE deleted.seccion = @seccion
		SELECT @insertados = COUNT(*)FROM inserted
	END;

DELETE empleados WHERE documento LIKE '23%';

SELECT* FROM empleados;/*Notamos que no elimino al empleado con puesto de gerencia*/