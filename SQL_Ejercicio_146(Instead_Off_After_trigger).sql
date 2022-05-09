IF OBJECT_ID('inscriptos') IS NOT NULL
	DROP TABLE inscriptos;
IF OBJECT_ID('socios') IS NOT NULL
	DROP TABLE socios;
IF OBJECT_ID('cursos') IS NOT NULL
	DROP TABLE cursos;

CREATE TABLE socios(
	documento char(8) not null,
	nombre varchar(30),
	domicilio varchar(30),
	constraint PK_socios primary key(documento)
);
CREATE TABLE cursos(
	numero tinyint identity,
	deporte char(20),
	cantidadmaxima tinyint,
	constraint PK_cursos primary key(numero)
);

CREATE TABLE inscriptos(
	documento char(8) not null,
	numerocurso tinyint,
	fecha datetime,
	constraint PK_inscriptos primary key(documento,numerocurso),
	constraint FK_inscriptos_documento
	foreign key (documento)
	references socios(documento),
	constraint FK_inscriptos_curso
	foreign key (numerocurso)
	references cursos(numero)
);

IF OBJECT_ID('condicionales') IS NOT NULL
	DROP TABLE condicionales;

CREATE TABLE condicionales(
	documento char(8) not null,
	codigocurso tinyint not null,
	fecha datetime
);

INSERT INTO socios
VALUES('22222222','Ana Acosta','Avellaneda 800'),
('23333333','Bernardo Bustos','Bulnes 345'),
('24444444','Carlos Caseros','Colon 382'),
('25555555','Mariana Morales','Maipu 234'),
('26666666','Patricia Palacios','Paru 587');

INSERT INTO cursos
VALUES('tenis',4),
('natacion',6),
('basquet',20),
('futbol',20);

INSERT INTO inscriptos
VALUES('22222222',1,getdate()),
('22222222',2,getdate()),
('23333333',1,getdate()),
('23333333',3,getdate()),
('24444444',1,getdate()),
('24444444',4,getdate()),
('25555555',1,getdate());

CREATE TRIGGER dis_inscriptos_insertar
ON inscriptos
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @maximo tinyint
	SELECT @maximo = cantidadmaxima FROM cursos AS c
	JOIN inserted AS i
	ON c.numero = i.numerocurso
	IF (@maximo = (SELECT COUNT(*) FROM inscriptos AS i
		JOIN cursos AS c
		ON i.numerocurso = c.numero
		JOIN inserted AS ins
		ON i.numerocurso = ins.numerocurso))
		-- esta completo
		BEGIN
			INSERT INTO condicionales SELECT documento, numerocurso, fecha FROM inserted
			SELECT 'Inscripción condicional.'
		END
	ELSE -- no esta completo
		BEGIN
			INSERT INTO inscriptos SELECT documento, numerocurso, fecha FROM inserted
			SELECT 'Inscripción realizada.'
		END
END;

INSERT INTO inscriptos
VALUES('26666666', 2, getdate());
SELECT* FROM inscriptos;
SELECT* FROM condicionales;/*No lo inscribio porque el curso no esta completo*/

INSERT INTO inscriptos
VALUES('26666666',1,getdate());
SELECT* FROM inscriptos;
SELECT* FROM condicionales;/*Si lo inscribe al curso poque está completo*/