IF OBJECT_ID('articulos') IS NOT NULL
	DROP TABLE articulos;

CREATE TABLE articulos(
	  codigo int identity,
	descripcion varchar(30),
	precio decimal(5,2) not null,
	cantidad smallint not null default 0,
	montototal as precio * cantidad
);

INSERT INTO articulos
VALUES('birome',1.5,100,150);/*No permite agregar valores a montototal porque es un dato calculado*/

INSERT INTO articulos
VALUES('birome',1.5,100),
('cuaderno 12 hojas',4.8,150),
('lapices x 12',5,200);

SELECT* FROM articulos;

UPDATE articulos SET precio = 2
WHERE descripcion = 'birome';

SELECT* FROM articulos;/*Podemos ver que montototal hace los calculos de manera automatica*/

UPDATE articulos SET cantidad = 200
WHERE descripcion = 'birome';

SELECT* FROM articulos;/*Nuevamente actualiza los valores en automatico*/

UPDATE articulos SET montototal = 300
WHERE descripcion = 'birome';/*Sin embargo no permite cambiar los valores del campo calculado*/