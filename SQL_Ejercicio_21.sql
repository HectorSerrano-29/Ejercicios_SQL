IF OBJECT_ID('visitantes') is not null
	DROP TABLE visitantes;

CREATE TABLE visitantes(
	nombre varchar(30),
	edad tinyint,
	sexo char(1) default 'f',
	domicilio varchar(30),
	ciudad varchar(20) default 'Cordoba',
	telefono varchar(11),
	mail varchar(30) default 'no tiene',
	montocompra decimal (6,2)
);
--Storage procedure para ver los atributos de la tabla
EXEC SP_COLUMNS visitantes;

INSERT INTO visitantes (nombre, domicilio, montocompra)
VALUES('Susana Molina','Colon 123',59.80);

INSERT INTO visitantes (nombre, edad, ciudad, mail)
VALUES('Marcos Torres',29,'Carlos Paz','marcostorres@hotmail.com');

SELECT* FROM visitantes;

INSERT INTO visitantes
VALUES('Marcelo Morales',38,default,default,default,'4255232','marcelomorales@hotmail.com',default);

INSERT INTO visitantes default values;

SELECT* FROM visitantes;