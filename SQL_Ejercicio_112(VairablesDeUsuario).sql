IF OBJECT_ID('alumnos') IS NOT NULL
	DROP TABLE alumnos;
IF OBJECT_ID('notas') IS NOT NULL
	DROP TABLE notas;

CREATE TABLE alumnos(
	documento char(8) not null
	constraint CK_alumnos_documento check (documento like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	nombre varchar(30),
	constraint PK_alumnos
	primary key(documento)
);

CREATE TABLE notas(
	documento char(8) not null,
	nota decimal(4,2)
	constraint CK_notas_nota check (nota between 0 and 10),
	constraint FK_notas_documento
	foreign key(documento)
	references alumnos(documento)
	on update cascade
);

INSERT INTO alumnos
VALUES('30111111','Ana Algarbe'),
('30222222','Bernardo Bustamante'),
('30333333','Carolina Conte'),
('30444444','Diana Dominguez'),
('30555555','Fabian Fuentes'),
('30666666','Gaston Gonzalez');

INSERT INTO notas
VALUES('30111111',5.1),
('30222222',7.8),
('30333333',4),
('30444444',2.5),
('30666666',9.9),
('30111111',7.3),
('30222222',8.9),
('30444444',6),
('30666666',8);

DECLARE @documento char(8)
SELECT @documento;

SELECT @documento = documento FROM notas
WHERE nota = (SELECT max(nota) FROM notas);/*No se puede porque la variable fue declarada en otro
lote de sentencias y no es reconocida.*/

DECLARE @documento char(8)
SELECT @documento = documento FROM notas

WHERE nota = (SELECT max(nota) FROM notas)
SELECT nombre FROM alumnos WHERE documento=@documento;