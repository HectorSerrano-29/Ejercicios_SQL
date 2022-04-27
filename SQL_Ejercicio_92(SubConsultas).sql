IF OBJECT_ID('alumnos') IS NOT NULL
	DROP TABLE alumnos;

CREATE TABLE alumnos(
	documento char(8),
	nombre varchar(30),
	nota decimal(4,2),
	PRIMARY KEY(documento),
	CONSTRAINT CK_alumnos_nota_valores CHECK (nota >= 0 AND nota <= 10),
);

INSERT INTO alumnos
VALUES('30111111','Ana Algarbe',5.1),
('30222222','Bernardo Bustamante',3.2),
('30333333','Carolina Conte',4.5),
('30444444','Diana Dominguez',9.7),
('30555555','Fabian Fuentes',8.5),
('30666666','Gaston Gonzalez',9.70);

SELECT alumnos.*
FROM alumnos
WHERE nota = (SELECT MAX(nota) FROM alumnos);

SELECT documento , nombre, nota
FROM alumnos
WHERE nota = (SELECT nombre,MAX	(nota) FROM alumnos);/*Manda error porque la subconsulta que va luego de un
operador de comparacion, solamante incluye un campo o expresion (excepto si emplea "exists" o "in")*/

SELECT alumnos.*, (SELECT AVG(nota) FROM alumnos) - nota AS diferencia
FROM alumnos
WHERE nota < (SELECT AVG(nota) FROM alumnos);

UPDATE alumnos SET nota = 4
WHERE nota = (SELECT MIN(nota) FROM alumnos);

DELETE FROM alumnos
WHERE nota < (SELECT AVG(nota) FROM alumnos);