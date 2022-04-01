IF (OBJECT_ID('deportes')) IS NOT NULL
	DROP TABLE deportes;
IF (OBJECT_ID('inscriptos')) IS NOT NULL
	DROP TABLE inscriptos;

CREATE TABLE deportes(
	codigo tinyint identity,
	nombre varchar(30),
	profesor varchar(30),
	primary key (codigo)
);

CREATE TABLE inscriptos(
	documento char(8),
	codigodeporte tinyint not null,
	matricula char(1) --'s'=paga 'n'=impaga
);

INSERT INTO deportes
VALUES('tenis','Marcelo Roca'),
('natacion','Marta Torres'),
('basquet','Luis Garcia'),
('futbol','Marcelo Roca');
 
INSERT INTO inscriptos
VALUES('22222222',3,'s'),
('23333333',3,'s'),
('24444444',3,'n'),
('22222222',2,'s'),
('23333333',2,'s'),
('22222222',4,'n'), 
('22222222',5,'n');

SELECT documento, d.nombre, matricula
FROM inscriptos AS i
JOIN deportes AS d
ON codigodeporte = codigo;/*Con un join solo muestra las coincidencias en ambas tablas*/

SELECT documento,d.nombre,matricula
FROM inscriptos AS i
LEFT JOIN deportes AS d
ON codigodeporte = codigo;/*Usamos en este caso el left join para ver todos los inscriptos, y vemos que obtiene
todos los registros y coloca NULL donde no haya coincidencia*/

SELECT documento,d.nombre,matricula
FROM deportes AS d
RIGHT JOIN inscriptos AS i
ON codigodeporte = codigo;/*Misma consulta que la anterior pero con un right join*/

SELECT nombre
FROM deportes AS d
LEFT JOIN inscriptos AS i
ON codigodeporte = codigo
WHERE codigodeporte IS NULL;/*Muestra los deportes para los cuales no hay inscriptos*/

SELECT documento
FROM inscriptos AS i
LEFT JOIN deportes AS d
ON codigodeporte=codigo
WHERE codigo IS NULL;/*Muestra los documentos de los inscriptos a deportes que son nulos*/

SELECT documento,nombre,profesor,matricula
FROM inscriptos AS i
FULL join deportes AS d
ON codigodeporte=codigo;/*Con un FULL JOIN podemos mostrar ambas tablas y cuando no haya coincidencais mostrara NULL*/