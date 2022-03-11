IF OBJECT_ID('vehiculos') IS NOT NULL
	DROP TABLE vehiculos;

CREATE TABLE vehiculos(
	patente char(6) not null,
	tipo char(1),--'a'=auto, 'm'=moto
	horallegada datetime not null,
	horasalida datetime
);

ALTER TABLE vehiculos
ADD CONSTRAINT CK_vehiculos_tipo
CHECK (tipo IN('a','m'));

ALTER TABLE vehiculos
ADD CONSTRAINT DF_vehiculos_tipo
DEFAULT 'a'
FOR tipo;

ALTER TABLE vehiculos
ADD CONSTRAINT CK_vehiculos_patente_patron
CHECK (patente LIKE '[A-Z][A-Z][A-Z][0-9][0-9][0-9]');

ALTER TABLE vehiculos
ADD CONSTRAINT PK_vehiculos_patentellegada
PRIMARY KEY (patente, horallegada);

INSERT INTO vehiculos
VALUES('SDR456','a','2005/10/10 10:10',NULL);

INSERT INTO vehiculos
VALUES('SDR456','m','2005/10/10 10:10',NULL);/*No se podrá ingresar por el campo repetido de la PK*/

INSERT INTO vehiculos
VALUES('SDR456','m','2005/10/10 12:10',null);/*Aquí se ingresa un registro repitiendo la patante pero
no la hora de llegada*/

INSERT INTO vehiculos
VALUES('SDR111','m','2005/10/10 12:10',null);/*Aquí se ingresa un registro repitiendo la hora de llegada pero
no la patente*/

EXEC sp_helpconstraint vehiculos;/*Procedimiento para ver las restricciones deben de aparecer 4 filas*/

ALTER TABLE vehiculos
DROP DF_vehiculos_tipo /*Se elimina la restriccion default de tipo*/

EXEC sp_helpconstraint vehiculos;/*Procedimiento para ver las restricciones deben de aparecer 3 filas*/

ALTER TABLE vehiculos
DROP PK_vehiculos_patentellegada, CK_vehiculos_patente_patron;/*Se eliminan las restricciones PK y check*/

EXEC sp_helpconstraint vehiculos;/*Notamos que solo queda 1 restrccion, las ateriores se eliminaron*/

SELECT* FROM vehiculos;