IF OBJECT_ID('medicamentos') IS NOT NULL
	DROP TABLE medicamentos;

CREATE TABLE medicamentos(
	codigo int identity,
	nombre varchar(20),
	laboratorio varchar(20),
	precio decimal(5,2),
	cantidad tinyint,
	primary key(codigo)
);

INSERT INTO medicamentos
VALUES('Sertal','Roche',5.2,100),
('Buscapina','Roche',4.10,200),
('Amoxidal 500','Bayer',15.60,100),
('Paracetamol 500','Bago',1.90,200),
('Bayaspirina','Bayer',2.10,150),
('Amoxidal jarabe','Bayer',5.10,250);

SELECT codigo, nombre
FROM medicamentos
WHERE laboratorio = 'Roche' AND precio < 5;

SELECT*
FROM medicamentos
WHERE laboratorio = 'Roche' OR precio < 5;

SELECT*
FROM medicamentos
WHERE NOT laboratorio = 'Bayer' AND cantidad = 100;

SELECT*
FROM medicamentos
WHERE laboratorio = 'Bayer' AND NOT cantidad = 100;

DELETE FROM medicamentos
WHERE laboratorio = 'Bayer' AND precio > 10;

UPDATE medicamentos SET cantidad = 200
WHERE laboratorio = 'Roche' AND precio > 5;

DELETE FROM medicamentos
WHERE laboratorio = 'Bayer' OR  precio < 3;

SELECT* FROM medicamentos;