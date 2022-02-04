 IF OBJECT_ID('medicamentos') is not null
	DROP TABLE medicamentos;

CREATE TABLE medicamentos(
	codigo int identity(10,1),
	nombre varchar(20) not null,
	laboratorio varchar(20),
	precio float,
	cantidad int
 );

INSERT INTO medicamentos (nombre, laboratorio,precio,cantidad)
VALUES('Sertal','Roche',5.2,100),
('Buscapina','Roche',4.10,200),
('Amoxidal 500','Bayer',15.60,100);

SELECT* FROM medicamentos;

INSERT INTO medicamentos (codigo,nombre, laboratorio,precio,cantidad)
VALUES(1,'Sertal','Roche',5.2,100);

SET IDENTITY_INSERT medicamentos ON;

INSERT INTO medicamentos (nombre, laboratorio,precio,cantidad)
VALUES('Sertal','Roche',5.2,100);

INSERT INTO medicamentos (codigo,nombre, laboratorio,precio,cantidad)
VALUES(10,'Sertal','Roche',5.2,100);

SELECT IDENT_SEED('medicamentos');

SELECT IDENT_INCR('medicamentos');

SELECT* FROM medicamentos;