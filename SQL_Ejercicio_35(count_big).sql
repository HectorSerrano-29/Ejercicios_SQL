IF OBJECT_ID('medicamentos') IS NOT NULL
	DROP TABLE medicamentos;

CREATE TABLE medicamentos(
	codigo int identity,
	nombre varchar(20),
	laboratorio varchar(20),
	precio decimal(6,2),
	cantidad tinyint,
	fechavencimiento datetime not null,
	numerolote int default null,
	primary key(codigo)
);

INSERT INTO medicamentos
VALUES('Sertal','Roche',5.2,1,'2015-02-01',null),
('Buscapina','Roche',4.10,3,'2016-03-01',null),
('Amoxidal 500','Bayer',15.60,100,'2017-05-01',null),
('Paracetamol 500','Bago',1.90,20,'2018-02-01',null),
('Bayaspirina',null,2.10,null,'2019-12-01',null),
('Amoxidal jarabe','Bayer',null,250,'2019-12-15',null);

SELECT COUNT_BIG(*) AS '# de registros' FROM medicamentos;

SELECT COUNT_BIG(DISTINCT laboratorio) AS '# Labs distintos' FROM medicamentos;

SELECT COUNT_BIG(precio) AS '# Med con precio', COUNT_BIG(cantidad) AS 'Cantidad' FROM medicamentos