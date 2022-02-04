IF OBJECT_ID('agenda')is not null
	DROP TABLE agenda;

CREATE TABLE agenda(
  apellido varchar(30),
  nombre varchar(20),
  domicilio varchar(30),
  telefono int
);

EXEC SP_TABLES @table_owner='dbo';

EXEC SP_COLUMNS agenda;

INSERT INTO agenda (apellido, nombre, domicilio, telefono)
	VALUES('Moreno','Alberto','Colon 123','4234567');
INSERT INTO agenda (apellido,nombre, domicilio, telefono)
	VALUES('Torres','Juan','Avellaneda 135','4458787');

SELECT* FROM agenda;

DROP TABLE agenda;

DROP TABLE agenda;