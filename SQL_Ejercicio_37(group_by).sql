IF OBJECT_ID('visitantes') IS NOT NULL
	DROP TABLE visitantes;

CREATE TABLE visitantes(
	nombre varchar(30),
	edad tinyint,
	sexo char(1) default 'f',
	domicilio varchar(30),
	ciudad varchar(20) default 'Cordoba',
	telefono varchar(11),
	mail varchar(30) default 'no tiene',
	montocompra decimal (6,2)
);

INSERT INTO visitantes
VALUES('Susana Molina',35,default,'Colon 123',default,null,null,59.80),
('Marcos Torres',29,'m',default,'Carlos Paz',default,'marcostorres@hotmail.com',150.50),
('Mariana Juarez',45,default,default,'Carlos Paz',null,default,23.90);

INSERT INTO visitantes(nombre, edad,sexo,telefono, mail)
VALUES('Fabian Perez',36,'m','4556677','fabianperez@xaxamail.com');

INSERT INTO visitantes(nombre, ciudad, montocompra)
VALUES('Alejandra Gonzalez','La Falda',280.50);

INSERT INTO visitantes(nombre, edad,sexo, ciudad, mail,montocompra)
VALUES('Gaston Perez',29,'m','Carlos Paz','gastonperez1@gmail.com',95.40);

INSERT INTO visitantes
VALUES('Liliana Torres',40,default,'Sarmiento 876',default,default,default,85),
('Gabriela Duarte',21,null,null,'Rio Tercero',default,'gabrielaltorres@hotmail.com',321.50);

SELECT ciudad, COUNT(*) AS 'Visitantes' FROM visitantes
GROUP BY ciudad;

SELECT ciudad, COUNT(telefono) AS 'Visitantes con telefono' FROM visitantes
GROUP BY ciudad;

SELECT sexo, SUM(montocompra) AS 'Compras totales' FROM visitantes
GROUP BY sexo;

SELECT sexo, ciudad, MAX(montocompra) AS 'Compra max', MIN(montocompra) AS 'Compra min' FROM visitantes
GROUP BY sexo, ciudad;

SELECT ciudad, AVG(montocompra) AS 'Promedio compras' FROM visitantes
GROUP BY ciudad;

SELECT ciudad, COUNT(*) AS 'Visitantes con mail' FROM visitantes
WHERE mail IS NOT NULL AND mail <>	'no tiene'
GROUP BY ciudad;

SELECT ciudad, COUNT(*) AS 'Visitantes con mail' FROM visitantes
WHERE mail IS NOT NULL AND mail <>	'no tiene'
GROUP BY ALL ciudad;