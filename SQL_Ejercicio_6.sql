 IF OBJECT_iD('agenda') is not null
	DROP TABLE agenda;

 CREATE TABLE agenda(
  apellido varchar(30),
  nombre varchar(20),
  domicilio varchar(30),
  telefono varchar(11)
 );

EXEC SP_COLUMNS agenda;

INSERT INTO agenda(apellido,nombre,domicilio,telefono)
VALUES ('Acosta', 'Ana', 'Colon 123', '4234567');

INSERT INTO agenda(apellido,nombre,domicilio,telefono)
VALUES ('Bustamante', 'Betina', 'Avellaneda 135', '4458787');

INSERT INTO agenda(apellido,nombre,domicilio,telefono)
VALUES ('Lopez', 'Hector', 'Salta 545', '4887788'); 

INSERT INTO agenda(apellido,nombre,domicilio,telefono)
VALUES ('Lopez', 'Luis', 'Urquiza 333', '4545454');

INSERT INTO agenda(apellido,nombre,domicilio,telefono)
VALUES ('Lopez', 'Marisa', 'Urquiza 333', '4545454');

SELECT* FROM agenda;

SELECT* FROM agenda
WHERE nombre='Marisa';

SELECT nombre,domicilio FROM agenda
WHERE apellido='Lopez';

SELECT nombre FROM agenda
WHERE telefono='4545454';