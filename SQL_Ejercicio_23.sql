 IF OBJECT_ID('libros') is not null
	DROP TABLE libros;

CREATE TABLE libros(
	codigo int identity,
	titulo varchar(40) not null,
	autor varchar(20) default 'Desconocido',
	editorial varchar(20),
	precio decimal(6,2),
	cantidad tinyint default 0,
	primary key (codigo)
);

INSERT INTO libros (titulo,autor,editorial,precio)
VALUES('El aleph','Borges','Emece',25);

INSERT INTO libros
VALUES('Java en 10 minutos','Mario Molina','Siglo XXI',50.40,100);

INSERT INTO libros (titulo,autor,editorial,precio,cantidad)
VALUES('Alicia en el pais de las maravillas','Lewis Carroll','Emece',15,50);

SELECT titulo, autor, editorial, precio, cantidad, precio*cantidad AS 'Monto Total'
FROM libros;

SELECT titulo, autor, precio, precio*0.1 AS Descuento, precio - (precio * 0.1) AS 'Precio Final'
FROM libros
WHERE editorial = 'Emece';

SELECT titulo + '-' + autor AS "Titulo y autor"
FROM libros;