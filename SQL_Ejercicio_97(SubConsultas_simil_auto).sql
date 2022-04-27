IF OBJECT_ID('deportes') IS NOT NULL
	DROP TABLE deportes;

CREATE TABLE deportes(
	nombre varchar(15),
	profesor varchar(30),
	dia varchar(10),
	cuota decimal(5,2),
);

INSERT INTO deportes
VALUES('tenis','Ana Lopez','lunes',20),
('natacion','Ana Lopez','martes',15),
('futbol','Carlos Fuentes','miercoles',10),
('basquet','Gaston Garcia','jueves',15),
('padle','Juan Huerta','lunes',15),
('handball','Juan Huerta','martes',10);

SELECT DISTINCT d1.profesor
FROM deportes AS d1
WHERE d1.profesor IN
(SELECT d2.profesor
FROM deportes AS d2 
WHERE d1.nombre <> d2.nombre);

SELECT DISTINCT d1.profesor
FROM deportes AS d1
JOIN deportes AS d2
ON d1.profesor = d2.profesor
WHERE d1.nombre <> d2.nombre;

SELECT nombre
FROM deportes
WHERE nombre <> 'natacion' AND
dia = (SELECT dia
FROM deportes
WHERE nombre = 'natacion');

SELECT d1.nombre
FROM deportes AS d1
JOIN deportes AS d2
ON d1.dia = d2.dia
WHERE d2.nombre = 'natacion' AND
d1.nombre <> d2.nombre;