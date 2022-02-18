IF OBJECT_ID('visitas') IS NOT NULL
	DROP TABLE visitas;

CREATE TABLE visitas(
	numero int identity,
	nombre varchar(30) default 'Anonimo',
	mail varchar(50),
	pais varchar (20),
	fechayhora datetime,
	primary key(numero)
);

INSERT INTO visitas (nombre,mail,pais,fechayhora)
VALUES('Ana Maria Lopez','AnaMaria@hotmail.com','Argentina','2006-10-10 10:10'),
('Gustavo Gonzalez','GustavoGGonzalez@gotmail.com','Chile','2006-10-10 21:30'),
('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-10-11 15:45'),
('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-10-12 08:15'),
('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-09-12 20:45'),
('Juancito','JuanJosePerez@gmail.com','Argentina','2006-09-12 16:20'),
('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-09-15 16:25');
INSERT INTO visitas (nombre,mail,pais)
VALUES('Federico1','federicogarcia@xaxamail.com','Argentina');

SELECT* FROM visitas
WHERE fechayhora BETWEEN '2006-09-12' AND '2006-10-11';

SELECT* FROM visitas
WHERE numero BETWEEN 2 AND 5;