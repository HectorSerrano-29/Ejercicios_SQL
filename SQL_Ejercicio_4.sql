IF OBJECT_ID('peliculas') is not null
	DROP TABLE peliculas;

CREATE TABLE peliculas(
nombre varchar(20),
actor varchar(20),
duracion int,
cantidad int
);

EXEC SP_COLUMNS peliculas;

INSERT INTO peliculas (nombre, actor, duracion, cantidad)
VALUES('Mision imposible','Tom Cruise',128,3);
INSERT INTO peliculas (nombre, actor, duracion, cantidad)
VALUES('Mision imposible 2','Tom Cruise',130,2);
INSERT INTO peliculas (nombre, actor, duracion, cantidad)
VALUES('Mujer bonita','Julia Roberts',118,3);
INSERT INTO peliculas (nombre, actor, duracion, cantidad)
VALUES('Elsa y Fred','China Zorrilla',110,2);

SELECT* FROM peliculas;