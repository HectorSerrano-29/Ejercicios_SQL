IF OBJECT_ID('vehiculos') IS NOT NULL
	DROP TABLE vehiculos;

IF OBJECT_ID('RG_patente_patron') IS NOT NULL
	DROP RULE RG_patente_patron;
IF OBJECT_ID('RG_vehiculos_tipo') IS NOT NULL
	DROP RULE RG_vehiculos_tipo;
IF OBJECT_ID('RG_vehiculos_tipo2') IS NOT NULL
	DROP RULE RG_vehiculos_tipo2;/*Eliminamos las reglas si existen*/

CREATE TABLE vehiculos(
	patente char(6) not null,
	tipo char(1),--'a'=auto, 'm'=moto
	horallegada datetime not null,
	horasalida datetime
);

CREATE RULE RG_patente_patron
AS @patente LIKE '[A-Z][A-Z][A-Z][0-9][0-9][0-9]';/*Regla para la patente con un patron especifico*/

EXEC sp_bindrule RG_patente_patron,'vehiculos.patente';/*Se asocia la regla patente a la tabla vehiculos*/

INSERT INTO vehiculos
VALUES('FGHIJK','a','1990-02-01 18:00',null);/*No permite agregar el registro porque el campo patente
no cumple con la regla*/

CREATE RULE RG_vehiculos_tipo
AS @tipo IN ('a','m');/*Regla para el campo tipo*/

EXEC sp_bindrule RG_vehiculos_tipo, 'vehiculos.tipo';/*Se asocia la regla tipo a la tabla vehiculos*/

INSERT INTO vehiculos
VALUES('AAA111','c','2001-10-10 10:10',NULL);/*No se podrá ingresar el registro ya que el campo tipo
no cumple con la regla*/

CREATE RULERG_vehiculos_tipo2
AS @tipo IN ('a','c','m');/*Creacion de una nueva regla para tipo*/

EXEC sp_bindrule RG_vehiculos_tipo2, 'vehiculos.tipo';/*Se le otorga la nueva regla al campo tipo,
ahora se seguirá esta regla*/

INSERT INTO vehiculos
VALUES('AAA111','c','2001-10-10 10:10',NULL);/*Se podrá ingresar el registro ya que cumple con la nueva regla*/

DROP RULE RG_vehiculos_tipo2;

DROP RULE RG_vehiculos_tipo;/*Esta regla se puede eliminar ya que no está asociada*/

DROP RULE RG_patente_patron;/*No se podrán eliminar las reglas hasta que ya no estén asociadas*/

EXEC sp_unbindrule 'vehiculos.patente';/*Se desasocia la regla al campo patente*/

EXEC sp_helpconstraint vehiculos;/*Verificamos si aun está asociada*/

EXEC sp_help;/*Vemos que aun existe la regla*/

DROP RULE RG_patente_patron;/*Eliminamos la regla*/

EXEC sp_help;/*Vemos que se eliminó la regla*/