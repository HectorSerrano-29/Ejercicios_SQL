IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;

CREATE TABLE empleados(
	documento varchar(8) not null,
	nombre varchar(30),
	seccion varchar(20)
);

INSERT INTO empleados
VALUES('22222222','Alberto Lopez','Sistemas'),
('23333333','Beatriz Garcia','Administracion'),
('23333333','Carlos Fuentes','Administracion');

ALTER TABLE empleados
ADD CONSTRAINT PK_empleados_documento
PRIMARY KEY (documento);

DELETE FROM empleados
WHERE nombre = 'Carlos Fuentes';/*Se tendrá que eliminar el campo repetido o actualizarlo*/

ALTER TABLE empleados
ADD CONSTRAINT PK_empleados_documento
PRIMARY KEY (documento);/*Ya que no hay campos repetidos se podrá agregar la PK*/

UPDATE empleados SET documento = '22222222'
WHERE documento = '23333333';/*Al intentar actualizar un campo para que se repita no es posible por la PK*/

ALTER TABLE empleados
ADD CONSTRAINT PK_empleados_nombre
PRIMARY KEY (nombre);/*No se podrá ejecutar ya que solo puede exisitir una PK por tabla*/

INSERT INTO empleados
VALUES(NULL,'Siro Lopez','RRHH');/*La restriccion no admite valores nulos*/

ALTER TABLE empleados
ADD CONSTRAINT DF_empleados_documento
DEFAULT '00000000'
FOR documento;/*Valor default por si se omite la inserción de documento*/

INSERT INTO empleados(nombre,seccion)
VALUES('Francisco Bosco','Sistemas');

SELECT* FROM empleados;

INSERT INTO empleados(nombre,seccion)
VALUES('Juan Cardenas','Sistemas');/*No se podrá insertar otro registro con el valor default
ya que la PK no permite documentos repetidos*/

EXEC sp_helpconstraint empleados;