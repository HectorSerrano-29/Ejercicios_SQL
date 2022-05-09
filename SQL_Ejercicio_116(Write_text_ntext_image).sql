IF OBJECT_ID('visitas') IS NOT NULL
	DROP TABLE visitas;

CREATE TABLE visitas (
	numero int identity,
	nombre varchar(30),
	mail varchar(50),
	pais varchar (20),
	fecha datetime
	constraint DF_visitas_fecha default getdate(),
	comentarios text,
	constraint PK_visitas
	primary key(numero)
);

INSERT INTO visitas
VALUES('Ana Maria Lopez','AnaMaria@hotmail.com','Argentina','2006-10-10 10:10',null),
('Gustavo Gonzalez','GustavoGGonzalez@hotmail.com','Chile','2006-10-10 21:30',default),
('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico',default,'Excelente página'),
('Mariano Perez','PerezM@hotmail.com','Argentina','2006-11-11 14:30','Muy buena y divertida');

SELECT* FROM visitas;

DECLARE @puntero binary(16)
SELECT @puntero = textptr (comentarios)
FROM visitas
WHERE numero = 3
 
WRITETEXT visitas.comentarios @puntero 'Esta página es excelente, no hay otra mejor.';

DECLARE @puntero binary(16)
SELECT @puntero = textptr (comentarios)
FROM visitas
WHERE numero = 3
 
READTEXT visitas.comentarios @puntero 0 0;

DECLARE @puntero varbinary(16)
SELECT @puntero = textptr(comentarios) 
FROM visitas WHERE numero = 1

WRITETEXT visitas.comentarios @puntero 'Es una muy buena página, pero tiene algunos errores.';

DECLARE @puntero varbinary(16)
SELECT @puntero = textptr(comentarios) 
FROM visitas WHERE numero = 1
IF (textvalid('visitas.comentarios', @puntero) = 1)
WRITETEXT visitas.comentarios @puntero 'Es una muy buena página, pero tiene algunos errores.'
ELSE SELECT 'puntero invalido, no se actualizó el registro';

INSERT INTO visitas
VALUES('Salvador Quiroga','salvador@hotmail.com','Argentina','2006-09-09 18:25','');

DECLARE @puntero varbinary(16)
SELECT @puntero = textptr(comentarios) 
FROM visitas WHERE nombre = 'Salvador Quiroga'
IF (textvalid('visitas.comentarios', @puntero) = 1)
WRITETEXT visitas.comentarios @puntero 'Es una página más que interesante.';

DECLARE @puntero binary(16)
SELECT @puntero = textptr (comentarios)
FROM visitas
WHERE nombre = 'Salvador Quiroga'
 
READTEXT visitas.comentarios @puntero 0 0;