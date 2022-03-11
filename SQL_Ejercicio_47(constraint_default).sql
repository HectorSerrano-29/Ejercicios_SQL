IF OBJECT_ID('visitantes') IS NOT NULL
	DROP TABLE visitantes;

CREATE TABLE visitantes(
	numero int identity,
	nombre varchar(30),
	edad tinyint,
	domicilio varchar(30),
	ciudad varchar(20),
	montocompra decimal (6,2) not null
);

ALTER TABLE visitantes
ADD CONSTRAINT DF_visitantes_ciudad
DEFAULT 'Cordoba'
FOR ciudad;

ALTER TABLE visitantes
ADD CONSTRAINT DF_visitantes_montocompra
DEFAULT 0
FOR montocompra;

INSERT INTO visitantes
VALUES('Susana Molina',35,'Colon 123',default,59.80),
('Mariana Juarez',45,'Carlos Paz',null,23.90);

INSERT INTO visitantes (nombre,edad,domicilio)
VALUES('Marcos Torres',29,'Carlos Paz');

SELECT* FROM visitantes;

EXEC sp_helpconstraint visitantes;

ALTER TABLE visitantes
ADD CONSTRAINT DF_visitantes_ciudad
DEFAULT 'Desconocida'
FOR ciudad;

ALTER TABLE visitantes
ADD CONSTRAINT DF_visitantes_numero
DEFAULT NULL
FOR numero;