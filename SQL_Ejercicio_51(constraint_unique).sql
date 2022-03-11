IF OBJECT_ID('remis') IS NOT NULL
	DROP TABLE remis;

CREATE TABLE remis(
	numero tinyint identity,
	patente char(6),
	marca varchar(15),
	modelo char(4)
);

INSERT INTO remis
VALUES('ABC123','Renault clio','1990'),
('DEF456','Peugeot 504','1995'),
('DEF456','Fiat Duna','1998'),
('GHI789','Fiat Duna','1995'),
(null,'Fiat Duna','1995');/*Note que hay registros con patente repetida y uno con nula*/

ALTER TABLE remis
ADD CONSTRAINT UQ_remis_patente
UNIQUE(patente);/*No se podrá añadir la restriccion, primero se deben eliminar o modificar
los valores repetidos*/

DELETE FROM remis
WHERE numero=3; /*Se elimina la patente repetida*/

ALTER TABLE remis
ADD CONSTRAINT UQ_remis_patente
UNIQUE(patente);/*Se agrega la restriccion*/

INSERT INTO remis
VALUES('ABC123','Renault 11','1995');/*No permite repetir el campo*/

INSERT INTO remis
VALUES(null,'Renault 11','1995');/*No permite otro valor nulo porque ya hay uno*/

EXEC sp_helpconstraint remis;

SELECT* FROM remis;