IF OBJECT_ID('visitas') IS NOT NULL
	DROP TABLE visitas;

CREATE TABLE visitas (
	numero int identity,
	nombre varchar(30),
	mail varchar(50),
	pais varchar (20),
	fecha datetime
	constraint DF_visitas_fecha default getdate(),
	comentarios text
	constraint DF_visitas_comentarios default 'Ninguno',
	constraint PK_visitas
	primary key(numero)
);

INSERT INTO visitas
VALUES('Ana Maria Lopez','AnaMaria@hotmail.com','Argentina','2006-10-10 10:10',null),
('Gustavo Gonzalez','GustavoGGonzalez@hotmail.com','Chile','2006-10-10 21:30',default),
('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico',default,'Excelente página'),
('Mariano Perez','PerezM@hotmail.com','Argentina','2006-11-11 14:30','Muy buena y divertida');

SELECT* FROM visitas;

SELECT count(*)
FROM visitas
WHERE comentarios IS NOT NULL;

ALTER TABLE visitas
ADD CONSTRAINT CK_comentarios
CHECK (comentarios NOT LIKE '[0-9]%');/*No lo permite.*/

ALTER TABLE visitas
ALTER COLUMN comentarios TEXT NOT NULL;/*No lo permite.*/

IF OBJECT_ID('RG_texto') IS NOT NULL
	DROP RULE RG_texto;

CREATE RULE RG_texto
AS @valor NOT LIKE '[0-9]%';

EXEC sp_bindrule RG_texto, 'visitas.nombre';

EXEC sp_bindrule RG_texto, 'visitas.comentarios';/*No lo permite.*/

ALTER TABLE visitas
DROP DF_visitas_comentarios;

INSERT INTO visitas DEFAULT VALUES;
SELECT* FROM visitas;

IF OBJECT_ID('VP_Sincomentarios') IS NOT NULL
	DROP DEFAULT VP_Sincomentarios;

CREATE DEFAULT VP_Sincomentarios
AS 'Sin comentarios';

EXEC sp_bindefault VP_Sincomentarios, 'visitas.comentarios';

INSERT INTO visitas DEFAULT VALUES;
SELECT* FROM visitas;

IF OBJECT_ID('visitas') IS NOT NULL
	DROP TABLE visitas;

CREATE TABLE visitas (
	numero int identity,
	nombre varchar(30),
	mail varchar(50),
	pais varchar (20),
	fecha datetime
	constraint DF_visitas_fecha default getdate(),
	comentarios varchar(max)
	constraint DF_visitas_comentarios default 'Ninguno',
	constraint PK_visitas
	primary key(numero)
);

INSERT INTO visitas
VALUES('Ana Maria Lopez','AnaMaria@hotmail.com','Argentina','2006-10-10 10:10',null),
('Gustavo Gonzalez','GustavoGGonzalez@hotmail.com','Chile','2006-10-10 21:30',default),
('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico',default,'Excelente página'),
('Mariano Perez','PerezM@hotmail.com','Argentina','2006-11-11 14:30','Muy buena y divertida');

SELECT* FROM visitas;