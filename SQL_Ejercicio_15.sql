IF OBJECT_ID('alumnos') is not null
	DROP TABLE alumnos;

CREATE TABLE alumnos(
	legajo int identity,
	documento varchar(8),
	nombre varchar(30),
	domicilio varchar(30)
);

INSERT INTO alumnos(documento,nombre,domicilio)
VALUES('22345345','Perez Mariana','Colon 234'),
('23545345','Morales Marcos','Avellaneda 348'),
('24356345','Gonzalez Analia','Caseros 444'),
('25666777','Torres Ramiro','Dinamarca 209');

DELETE FROM alumnos

INSERT INTO alumnos(documento,nombre,domicilio)
VALUES('22345345','Perez Mariana','Colon 234'),
('23545345','Morales Marcos','Avellaneda 348'),
('24356345','Gonzalez Analia','Caseros 444'),
('25666777','Torres Ramiro','Dinamarca 209');
SELECT* FROM alumnos;

TRUNCATE TABLE alumnos;

INSERT INTO alumnos(documento,nombre,domicilio)
VALUES('22345345','Perez Mariana','Colon 234'),
('23545345','Morales Marcos','Avellaneda 348'),
('24356345','Gonzalez Analia','Caseros 444'),
('25666777','Torres Ramiro','Dinamarca 209');
SELECT* FROM alumnos;