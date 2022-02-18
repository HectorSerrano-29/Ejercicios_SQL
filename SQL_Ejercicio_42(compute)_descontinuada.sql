/*La cláusula compute y compute by están discontinuadas en las versiones de SQL Server 2012 y sucesivas.
No utilice esta característica en nuevos proyectos y modifique lo antes posible las aplicaciones que actualmente
la utilizan. En su lugar, utilice rollup.*/
IF OBJECT_ID('inmuebles') IS NOT NULL
	DROP TABLE inmuebles;

CREATE TABLE inmuebles(
	documento varchar(8) not null,
	nombre varchar(30),
	domicilio varchar(20),
	barrio varchar(20),
	ciudad varchar(20),
	tipo char(1),--b=baldio, e: edificado
	superficie decimal (8,2),
	monto decimal (8,2)
);

INSERT INTO inmuebles
VALUES('11111111','Alberto Acosta','Avellaneda 800','Centro','Cordoba','e',100,1200),
('11111111','Alberto Acosta','Sarmiento 245','Gral. Paz','Cordoba','e',200,2500),
('22222222','Beatriz Barrios','San Martin 202','Centro','Cordoba','e',250,1900),
('33333333','Carlos Caseres','Paso 1234','Alberdi','Cordoba','b',200,1000),
('33333333','Carlos Caseres','Guemes 876','Alberdi','Cordoba','b',300,1500),
('44444444','Diana Dominguez','Calderon 456','Matienzo','Cordoba','b',200,800),
('55555555','Estela Fuentes','San Martin 321','Flores','Carlos Paz','e',500,4500),
('55555555','Estela Fuentes','Lopez y Planes 853','Alberdi','Cordoba','e',350,2200);

--Compute solo funciona en versiones de SQL Server menores a 2012
select *from inmuebles
compute avg(monto);

select *from inmuebles
compute avg(superficie),sum(monto);

select *from inmuebles
order by documento,barrio,ciudad
compute avg(superficie),sum(monto)
by documento,barrio,ciudad;

select *from inmuebles
order by documento,barrio,ciudad
compute avg(superficie),sum(monto)
by documento,barrio;

select *from inmuebles
order by documento,barrio,ciudad
compute avg(superficie),sum(monto)
by documento;

select *from inmuebles
order by documento,barrio,ciudad
compute avg(superficie),sum(monto)
by documento,ciudad;

select *from inmuebles
order by documento
compute sum(monto)
compute avg(monto)
by documento;