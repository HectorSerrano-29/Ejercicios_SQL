IF OBJECT_ID('libros') is not null
	DROP TABLE libros;

CREATE TABLE libros(
  codigo int not null,
  titulo varchar(40) not null,
  autor varchar(20),
  editorial varchar(15),
  primary key(codigo)
 );

INSERT INTO libros(codigo,titulo,autor,editorial)
VALUES(1,'El aleph','Borges','Emece'),
(2,'Martin Fierro','Jose Hernandez','Planeta'),
(3,'Aprenda PHP','Mario Molina','Nuevo Siglo');

INSERT INTO libros
VALUES (1,'Libro','Autor','edit');

INSERT INTO libros
VALUES (null,'Libro','Autor','edit');

UPDATE libros set codigo = 1
WHERE titulo = 'Martin Fierro'