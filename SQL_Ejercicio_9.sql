IF OBJECT_ID('agenda') is not null
	DROP TABLE agenda;

CREATE TABLE agenda(
	apellido varchar(30),
	nombre varchar(20),
	domicilio varchar(30),
	telefono varchar(11)
);

INSERT INTO agenda(apellido,nombre,domicilio,telefono)
VALUES('Acosta','Alberto','Colon 123','4234567'),
('Juarez','Juan','Avellaneda 135','4458787'),
('Lopez','Maria','Urquiza 333','4545454'),
('Lopez','Jose','Urquiza 333','4545454'),
('Suarez','Susana','Gral. Paz 1234','4123456');

UPDATE agenda set nombre = 'Juan Jose'
WHERE nombre = 'Juan';

UPDATE agenda set telefono = '4445566'
WHERE telefono = '4545454';

UPDATE agenda set nombre = 'Juan Jose'
WHERE nombre = 'Juan';

 SELECT* FROM agenda;