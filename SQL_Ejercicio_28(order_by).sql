IF OBJECT_ID('visitas') is not null
	DROP TABLE visitas;

CREATE TABLE visitas(
	numero int identity,
	nombre varchar(30) default 'Anonimo',
	mail varchar(50),
	pais varchar (20),
	fecha datetime,
	primary key(numero)
);

INSERT INTO visitas (nombre,mail,pais,fecha)
VALUES('Ana Maria Lopez','AnaMaria@hotmail.com','Argentina','2006-10-10 10:10'),
('Gustavo Gonzalez','GustavoGGonzalez@hotmail.com','Chile','2006-10-10 21:30'),
('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-10-11 15:45'),
('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-10-12 08:15'),
('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','2006-09-12 20:45'),
('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-09-12 16:20'),
('Juancito','JuanJosePerez@hotmail.com','Argentina','2006-09-15 16:25');

SELECT* FROM visitas
ORDER BY fecha ASC;

SELECT nombre, pais, DATENAME(MONTH,fecha) AS mes FROM visitas
ORDER BY pais ASC, DATENAME(MONTH,fecha) DESC;

SELECT pais, DATENAME(MONTH,fecha) AS mes, DATENAME(DAY,fecha) AS dia, DATENAME(HOUR,fecha) AS hora
FROM visitas
ORDER BY 2, 3, 4;

SELECT mail, pais
FROM visitas
WHERE DATENAME(MONTH, fecha) = 'October'
ORDER BY 2;