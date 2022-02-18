IF OBJECT_ID('peliculas') IS NOT NULL
	DROP TABLE peliculas;

CREATE TABLE peliculas(
	codigo int identity,
	titulo varchar(40) not null,
	actor varchar(20),
	duracion tinyint,
	primary key (codigo)
);

INSERT INTO peliculas
VALUES('Mision imposible','Tom Cruise',120),
('Harry Potter y la piedra filosofal','Daniel R.',null),
('Harry Potter y la camara secreta','Daniel R.',190),
('Mision imposible 2','Tom Cruise',120),
('Mujer bonita',null,120),
('Tootsie','D. Hoffman',90);
INSERT INTO peliculas (titulo)
VALUES('Un oso rojo');

SELECT*
FROM peliculas
WHERE actor IS NULL;

UPDATE peliculas SET duracion = 0
WHERE duracion IS NULL;

DELETE FROM peliculas
WHERE actor IS NULL AND duracion = 0;

SELECT* FROM peliculas;