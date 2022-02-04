IF OBJECT_ID('medicamentos') is not null
	DROP TABLE medicamentos;

CREATE TABLE medicamentos(
	codigo int identity,
	nombre varchar(20) not null,
	laboratorio varchar(20),
	precio float,
	cantidad int
);

EXEC SP_COLUMNS medicamentos;

INSERT INTO medicamentos(nombre,laboratorio,precio,cantidad)
VALUES('Sertal','Roche',5.2,100),
('Buscapina','Roche',4.10,200),
('Amoxidal 500','Bayer',15.60,100);

SELECT* FROM medicamentos;

INSERT INTO medicamentos(codigo,nombre,laboratorio,precio,cantidad)
VALUES(1,'Sertal','Roche',5.2,100);

UPDATE medicamentos set codigo = 2
WHERE nombre = 'Hector';

DELETE FROM medicamentos
WHERE codigo = 3;

INSERT INTO medicamentos(nombre, laboratorio,precio,cantidad)
VALUES('Amoxilina 500','Bayer',15.60,100);

SELECT* FROM medicamentos;