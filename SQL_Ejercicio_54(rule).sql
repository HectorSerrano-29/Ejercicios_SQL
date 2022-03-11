IF OBJECT_ID('vehiculos') IS NOT NULL
DROP TABLE vehiculos;

IF OBJECT_ID('RG_patente_patron') IS NOT NULL
	DROP RULE RG_patente_patron;
IF OBJECT_ID('RG_horallegada') IS NOT NULL
	DROP RULE RG_horallegada;
IF OBJECT_ID('RG_vehiculos_tipo') IS NOT NULL
	DROP RULE RG_vehiculos_tipo;
IF OBJECT_ID('RG_vehiculos_tipo2') IS NOT NULL
	DROP RULE RG_vehiculos_tipo2;
IF OBJECT_ID('RG_menor_fechaactual') IS NOT NULL
	DROP RULE RG_menor_fechaactual;/*Se eliminan todas las reglas*/

CREATE TABLE vehiculos(
	patente char(6) not null,
	tipo char(1),--'a'=auto, 'm'=moto
	horallegada datetime not null,
	horasalida datetime
);

 INSERT INTO vehiculos
 VALUES('AAA111','a','1990-02-01 08:10',null),
 ('BCD222','m','1990-02-01 08:10','1990-02-01 10:10'),
 ('BCD222','m','1990-02-01 12:00',null),
 ('CC1234','a','1990-02-01 12:00',null);

CREATE RULE RG_patente_patron
AS @patente LIKE '[A-Z][A-Z][A-Z][0-9][0-9][0-9]'; /*Se crea la regla para patente*/

EXEC sp_help;/*Verificar si se creo la regla en la columna Object_type aparece como rule*/

EXEC sp_helpconstraint vehiculos;/*Se verá que la regla no está asociada a ningun campo*/

EXEC sp_bindrule RG_patente_patron,'vehiculos.patente';/*Asociamos la regla a el campo patente de la tabla vehiculos*/
SELECT* FROM vehiculos;/*Se pude ver que un campo no cumple, pero los próximos que se agregen 
cumpliran la regla asociada*/

INSERT INTO vehiculos
VALUES('FGHIJK','a','1990-02-01 18:00',null);/*No se podrá ingresar el campo porque no cumple con la regla*/

CREATE RULE RG_vehiculos_tipo
AS @tipo IN ('a','m');/*Regla para que tipo solo pueda aceptar 'a' o 'm'*/

EXEC sp_bindrule RG_vehiculos_tipo, 'vehiculos.tipo';/*Se asocia la regla para tipo a la tabla vehiculos*/

UPDATE vehiculos SET tipo='c'
WHERE patente='AAA111';/*No se podrá actualizar ya que no cumple con la regla de tipo*/

CREATE RULE RG_vehiculos_tipo2
AS @tipo IN ('a','c','m');

EXEC sp_bindrule RG_vehiculos_tipo2, 'vehiculos.tipo';/*Al crear la nueva regla y asociarla al mismo campo,
se actualiza y ahora la regla tipo2 es la nueva regla a seguir para el campo*/

UPDATE vehiculos SET tipo='c'
WHERE patente='AAA111'; /*Ahora si se podrá hacer la actualización ya que cumple con la nueva regla*/

CREATE RULE RG_menor_fechaActual
AS @fecha <= getdate();/*Regla que acepta fechas menores o iguales a la actual*/

EXEC sp_bindrule RG_menor_fechaactual, 'vehiculos.horallegada';
EXEC sp_bindrule RG_menor_fechaactual, 'vehiculos.horasalida';/*Se asocia la regla a las horas de llegada y salida*/

INSERT INTO vehiculos
VALUES('NOP555','a','1990-02-01 10:10','1990-02-01 08:30');/*Registro donde la hora de llegada es posterior a la salida*/

ALTER TABLE vehiculos
ADD CONSTRAINT CK_vehiculos_llegada_salida
CHECK(horallegada <= horasalida);/*Restriccion para que la hora de llegada no sea mayor a la de salida
No permite agrega la restrccion ya que hay un registro que no cumple*/

DELETE FROM vehiculos
WHERE patente='NOP555';/*Eliminamos el registro que no cumple con la regla*/

ALTER TABLE vehiculos
ADD CONSTRAINT CK_vehiculos_llegada_salida
CHECK(horallegada <= horasalida);/*Establecemos la restriccion que no se implemento en las lineas 68-70*/

ALTER TABLE vehiculos
ADD CONSTRAINT DF_vehiculos_tipo
DEFAULT 'b'
FOR tipo;/*Note que esta restricción va contra la regla asociada al campo "tipo" que solamente permite los 
valores "a", "c" y "m". SQL Server no informa el conflicto hasta que no intenta ingresar el valor 
por defecto.*/

INSERT INTO vehiculos
VALUES('STU456',default,'1990-02-01 10:10','1990-02-01 15:30');/*No permite el valor default que declaramos
anteriormente ya que va en contra de la regla declarada para tipo*/

EXEC sp_helpconstraint vehiculos;/*Muestra 1 restricción "check", 1 restricción "default" y 4 reglas asociadas.*/