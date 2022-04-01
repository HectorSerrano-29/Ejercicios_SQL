IF OBJECT_ID('mujeres') IS NOT NULL
	DROP TABLE mujeres;
IF OBJECT_ID('varones') IS NOT NULL
	DROP TABLE varones;

CREATE TABLE mujeres(
	nombre varchar(30),
	domicilio varchar(30),
	edad int
);

CREATE TABLE varones(
	nombre varchar(30),
	domicilio varchar(30),
	edad int
);

INSERT INTO mujeres
VALUES('Maria Lopez','Colon 123',45),
('Liliana Garcia','Sucre 456',35),
('Susana Lopez','Avellaneda 98',41);

INSERT INTO varones 
VALUES('Juan Torres','Sarmiento 755',44),
('Marcelo Oliva','San Martin 874',56),
('Federico Pereyra','Colon 234',38),
('Juan Garcia','Peru 333',50);

SELECT m.nombre, m.edad, v.nombre, v.edad
FROM mujeres AS m
CROSS JOIN varones AS v;/*Muestra ambas tablas, en este caso repite todos los registros de mujeres para cada
registro en varones así hasta que terminen todos los registros en mujeres*/

SELECT m.nombre, m.edad, v.nombre, v.edad
FROM mujeres AS m
CROSS JOIN varones AS v
WHERE m.edad > 40 AND v.edad > 40;/*Misma consulta pero solo apareceran las personas mayores a 40*/

SELECT m.nombre, m.edad, v.nombre, v.edad
FROM mujeres AS m
CROSS JOIN varones AS v
WHERE (m.edad - v.edad) BETWEEN -10 AND 10;/*Se harán parejas de varones y mujeres con la condicion que
las parejas no se llevarán mas de 10 años de diferencia*/