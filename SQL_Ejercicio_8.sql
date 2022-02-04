IF OBJECT_ID('agenda') is not null
	DROP TABLE agenda;

CREATE TABLE agenda(
	apellido varchar(30),
	nombre varchar(20),
	domicilio varchar(30),
	telefono varchar(11)
);

INSERT INTO agenda
VALUES('Alvarez','Alberto','Colon 123','4234567'),
('Juarez','Juan','Avellaneda 135','4458787'),
('Lopez','Maria','Urquiza 333','4545454'),
('Lopez','Jose','Urquiza 333','4545454'),
('Salas','Susana','Gral. Paz 1234','4123456');

DELETE FROM agenda
WHERE nombre = 'Juan';

DELETE FROM agenda
WHERE telefono = '4545454';

SELECT* FROM agenda;

DELETE FROM agenda;

SELECT* FROM agenda;