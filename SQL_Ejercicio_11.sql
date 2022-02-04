IF OBJECT_ID('medicamentos') is not null
	DROP TABLE medicamentos;

CREATE TABLE medicamentos(
  codigo int not null,
  nombre varchar(20) not null,
  laboratorio varchar(20),
  precio float,
  cantidad int not null
 );

EXEC SP_COLUMNS medicamentos;

INSERT INTO medicamentos(codigo,nombre,laboratorio,precio,cantidad)
VALUES(1,'Sertal gotas',null,null,100),
(2,'Sertal compuesto',null,8.90,150),
(3,'Buscapina','Roche',null,200)

SELECT* FROM medicamentos;

INSERT INTO medicamentos(codigo,nombre, laboratorio,precio,cantidad)
VALUES(4,'Bayaspirina','',0,150);

INSERT INTO medicamentos(codigo,nombre, laboratorio,precio,cantidad)
VALUES (0,'','Bayer',15.60,0);

SELECT* FROM medicamentos;

INSERT INTO medicamentos(codigo,nombre, laboratorio,precio,cantidad)
VALUES (null,'Amoxidal jarabe','Bayer',25,120);

SELECT* FROM medicamentos
WHERE laboratorio is null;

SELECT* FROM medicamentos
WHERE laboratorio = '';

SELECT* FROM medicamentos
WHERE precio is null;

SELECT* FROM medicamentos
WHERE precio = 0;

SELECT* FROM medicamentos
WHERE laboratorio <> '';

SELECT* FROM medicamentos
WHERE laboratorio is not null;

SELECT* FROM medicamentos
WHERE precio <> 0;

SELECT* FROM medicamentos
WHERE precio is null;