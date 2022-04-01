IF OBJECT_ID('clientes') IS NOT NULL
	DROP TABLE clientes;

CREATE TABLE clientes(
	nombre varchar(30),
	sexo char(1),--'f'=femenino, 'm'=masculino
	edad int,
	domicilio varchar(30)
);

INSERT INTO clientes
VALUES('Maria Lopez','f',45,'Colon 123'),
('Liliana Garcia','f',35,'Sucre 456'),
('Susana Lopez','f',41,'Avellaneda 98'),
('Juan Torres','m',44,'Sarmiento 755'),
('Marcelo Oliva','m',56,'San Martin 874'),
('Federico Pereyra','m',38,'Colon 234'),
('Juan Garcia','m',50,'Peru 333');

SELECT cm.nombre, cm.edad, cv.nombre, cv.edad
FROM clientes AS cm
CROSS JOIN clientes cv
WHERE cm.sexo = 'f' AND cv.sexo='m';

SELECT cm.nombre, cm.edad, cv.nombre, cv.edad
FROM clientes AS cm
JOIN clientes cv
ON cm.nombre <> cv.nombre
WHERE cm.sexo = 'f' AND cv.sexo = 'm';

SELECT cm.nombre, cm.edad, cv.nombre, cv.edad
FROM clientes AS cm
CROSS JOIN clientes cv
WHERE cm.sexo='f' AND cv.sexo='m' AND cm.edad - cv.edad between -5 and 5;