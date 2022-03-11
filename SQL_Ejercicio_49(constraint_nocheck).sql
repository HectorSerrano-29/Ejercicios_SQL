IF OBJECT_ID ('empleados') IS NOT NULL
DROP TABLE empleados;

CREATE TABLE empleados(
	documento varchar(8),
	nombre varchar(30),
	seccion varchar(20),
	sueldo decimal(6,2)
);

INSERT INTO empleados
VALUES ('22222222','Alberto Acosta','Sistemas',-10),
('33333333','Beatriz Benitez','Recursos',3000),
('34444444','Carlos Caseres','Contaduria',4000);

ALTER TABLE empleados
ADD CONSTRAINT CK_empleados_sueldoPositivo
CHECK (sueldo >= 0);/*No se puede agregar restrccion ya que ya existe un valor negativo almacenado*/

ALTER TABLE empleados
WITH NOCHECK /*Con la opcion NOCHECK podrá agregar la restriccion sin tomar en cuenta los registros anteriores*/
ADD CONSTRAINT CK_empleados_sueldoPositivo
CHECK (sueldo >= 0);

INSERT INTO empleados (sueldo)
VALUES (-1); /*No se agregara el valor ya que colocamos la restrccion de la linea 20-23*/

ALTER TABLE empleados
NOCHECK CONSTRAINT CK_empleados_sueldoPositivo/*Así se deshabilita una restricción*/

INSERT INTO empleados (sueldo)
VALUES (-1);/*Se podrá ingresar el valor ya que la CONSTRAINT se deshabilito*/

ALTER TABLE empleados
ADD CONSTRAINT CK_empleados_seccion_lista
CHECK (seccion IN ('Sistemas','Administracion','Contaduria'));/*No se podrá ya que hay un valor
ingresado anteriormente que no cumple con la restriccion*/

ALTER TABLE empleados
WITH NOCHECK/*Se podrá ingresar la restriccion ya que esta no toma en cuenta los registros anteriores*/
ADD CONSTRAINT CK_empleados_seccion_lista
CHECK (seccion IN ('Sistemas','Administracion','Contaduria'));

EXEC sp_helpconstraint empleados;

ALTER TABLE empleados
CHECK CONSTRAINT CK_empleados_sueldoPositivo;/*Así se activa nuevamente una CONSTRAINT*/

UPDATE empleados SET seccion = 'Recursos'
WHERE nombre = 'Carlos Caseres';/*No se podrá modificar ya que hay una restriccion con seccion*/

ALTER TABLE empleados
NOCHECK CONSTRAINT CK_empleados_seccion_lista;/*Desactivamos para poder cambiar de seccion al empleado*/

UPDATE empleados SET seccion = 'Recursos'
WHERE nombre = 'Carlos Caseres';/*Cambiamos de seccion al empleado, hay que recordar que desactivamos la 
restriccion de seccion*/