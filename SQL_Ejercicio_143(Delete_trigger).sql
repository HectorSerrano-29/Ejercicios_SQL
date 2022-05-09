IF OBJECT_ID('articulos') IS NOT NULL
	DROP TABLE articulos;

CREATE TABLE articulos(
	codigo int identity,
	tipo varchar(30),
	descripcion varchar(40),
	precio decimal(8,2),
	stock int,
	constraint PK_articulos primary key (codigo)
);

INSERT INTO articulos
VALUES('impresora','Epson Stylus C45',400,100),
('impresora','Epson Stylus C85',500,200),
('impresora','Epson Stylus Color 600',400,0),
('monitor','Samsung 14',900,0),
('monitor','Samsung 17',1200,0),
('monitor','xxx 15',1500,0),
('monitor','xxx 17',1600,0),
('monitor','zzz 15',1300,0);

CREATE TRIGGER DIS_articulos_borrar
ON articulos
FOR DELETE
AS
IF EXISTS(SELECT* FROM deleted WHERE stock > 0)--si algun registro borrado tiene stock
BEGIN
RAISERROR('No puede eliminar artículos que tienen stock',16,1)
ROLLBACK TRANSACTION
END
ELSE
BEGIN
DECLARE @cantidad int
SELECT @cantidad = COUNT(*) FROM deleted
SELECT 'Se eliminaron ' +RTRIM(CAST(@cantidad AS char(10))) + ' registros'
END;

DELETE FROM articulos WHERE codigo = 4;

DELETE FROM articulos WHERE codigo = 2;/*No se podra eliminar porque para este codigo de articulo
si hay stock, en el anterior de la linea 39 no habia stock*/

DELETE FROM articulos WHERE descripcion LIKE '%xx%';/*Se eliminaron todos los articulos sin stock*/

DELETE FROM articulos WHERE codigo <= 3;/*Mientras haya articulos con stock no los va a eliminar a pesar
de que haya codigos con 0 stock en la consulta*/

CREATE TRIGGER DIS_articulos_borrar2
ON articulos
FOR DELETE
AS
DECLARE @cantidad int
SELECT @cantidad = count(*) FROM deleted
IF @cantidad > 1
BEGIN
RAISERROR('No puede eliminar más de 1 artículo',16,1)
ROLLBACK TRANSACTION
END;

DELETE FROM articulos WHERE codigo = 3;

DELETE FROM articulos WHERE codigo = 2;
/*El disparadores "DIS_articulos_borrar" se activa y no permite la transacción. El disparador 
"DIS_articulos_borrar2" no llega a activarse.*/

DELETE FROM articulos WHERE tipo = 'monitor';
/*El disparador "DIS_articulos_borrar" se activa y permite la transacción pero el disparador 
"DIS_articulos_borrar2" no permite la transacción.*/

DELETE FROM articulos WHERE tipo = 'impresora';
/*El disparador "DIS_articulos_borrar" se activa y no permite la transacción. El disparador 
"DIS_articulos_borrar2" no llega a activarse.*/