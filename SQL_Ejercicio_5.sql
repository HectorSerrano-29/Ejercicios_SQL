IF OBJECT_ID('peliculas') is not null
	DROP TABLE peliculas;

CREATE TABLE peliculas(
	titulo varchar(20),
	actor varchar(20),
	duracion int,
	cantidad int
);

EXEC SP_COLUMNS peliculas;

INSERT INTO peliculas (titulo, actor, duracion, cantidad)
VALUES ('Mision imposible','Tom Cruise',180,3);
INSERT INTO peliculas (titulo, actor, duracion, cantidad)
VALUES ('Mision imposible 2','Tom Cruise',190,2);
INSERT INTO peliculas (titulo, actor, duracion, cantidad)
VALUES ('Mujer bonita','Julia Roberts',118,3);
INSERT INTO peliculas (titulo, actor, duracion, cantidad)
VALUES ('Elsa y Fred','China Zorrilla',110,2);

SELECT titulo,actor FROM peliculas;

SELECT titulo,duracion FROM peliculas;

SELECT titulo,cantidad FROM peliculas;