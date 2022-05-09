IF OBJECT_ID('libros') IS NOT NULL
	DROP TABLE libros;
IF OBJECT_ID('ventas') IS NOT NULL
	DROP TABLE ventas;

CREATE TABLE libros(
	codigo int identity,
	titulo varchar(40),
	autor varchar(30),
	editorial varchar(20),
	precio decimal(6,2),
	cantidad int,
	primary key (codigo)
);

CREATE TABLE ventas(
	numero int identity,
	codigo int not null,
	preciounitario decimal(6,2),
	cantidad int, 
	constraint PK_ventas primary key (numero),
	constraint FK_ventas_codigolibro
	foreign key (codigo)
	references libros(codigo)
	on update cascade
);

INSERT INTO libros
VALUES('Uno','Richard Bach','Planeta',15,100),
('Ilusiones','Richard Bach','Planeta',18,150),
('El aleph','Borges','Emece',25,200),
('Matematica estas ahi','Paenza','Nuevo siglo',20,300),
('Aprenda PHP','Mario Molina','Nuevo siglo',45,200);
 
INSERT INTO ventas
VALUES(1,15,1),
(2,18,1),
(3,25,100),
(1,15,50);

IF OBJECT_ID('pa_ventas') IS NOT NULL
	DROP PROC pa_ventas;

CREATE PROCEDURE pa_ventas
AS
SELECT v.numero,
(l.titulo + '-' + l.autor + '-' + l.editorial) AS libro,
v.preciounitario,
v.cantidad,
(v.preciounitario * v.cantidad) AS total
FROM ventas AS v
JOIN libros AS l
ON v.codigo = l.codigo;

EXEC pa_ventas;

IF OBJECT_ID('pa_vender') IS NOT NULL
	DROP PROC pa_vender;

CREATE PROCEDURE pa_vender
@codigo int = null,
@cantidad int = 1
AS
--verificamos que el código exista
IF NOT EXISTS (SELECT* FROM libros WHERE codigo = @codigo) OR (@codigo IS NULL)
SELECT 'Ingrese un codigo de libro válido'
ELSE
BEGIN --verificamos que haya stock
DECLARE @disponibles int
SELECT @disponibles = cantidad FROM libros WHERE codigo = @codigo
IF (@disponibles<@cantidad)
SELECT 'Solo hay ' + cast(@disponibles AS varchar(10)) + ' disponibles'
ELSE
BEGIN
DECLARE @precio decimal(6,2) 
SELECT @precio = precio FROM libros WHERE codigo = @codigo
INSERT INTO ventas VALUES(@codigo, @precio, @cantidad)
UPDATE libros SET cantidad = cantidad - @cantidad WHERE @codigo = codigo
END
END;

EXEC pa_vender 1, 20;

SELECT* FROM ventas;
SELECT* FROM libros;

EXEC pa_vender 9;

EXEC pa_vender 5, 250;