IF OBJECT_ID('inscriptos') IS NOT NULL
	DROP TABLE inscriptos;
IF OBJECT_ID('socios') IS NOT NULL
	DROP TABLE socios;
IF OBJECT_ID('morosos') IS NOT NULL
	DROP TABLE morosos;

CREATE TABLE socios(
	documento char(8) not null,
	nombre varchar(30),
	domicilio varchar(30),
	constraint PK_socios primary key(documento)
);

CREATE TABLE inscriptos(
	numero int identity,
	documento char(8) not null,
	deporte varchar(20),
	matricula char(1),
	constraint FK_inscriptos_documento
	foreign key (documento)
	references socios(documento),
	constraint CK_inscriptos_matricula check (matricula in ('s','n')),
	constraint PK_inscriptos primary key(documento,deporte)
);
 
CREATE TABLE morosos(
	documento char(8) not null
);

INSERT INTO socios
VALUES('22222222','Ana Acosta','Avellaneda 800'),
('23333333','Bernardo Bustos','Bulnes 345'),
('24444444','Carlos Caseros','Colon 382'),
('25555555','Mariana Morales','Maipu 234');

INSERT INTO inscriptos
VALUES('22222222','tenis','s'),
('22222222','natacion','n'),
('23333333','tenis','n'),
('24444444','futbol','s'),
('24444444','natacion','s');

INSERT INTO morosos
VALUES('22222222'),
('23333333');

CREATE TRIGGER DIS_inscriptos_actualizar1
ON inscriptos
FOR UPDATE
AS
IF (SELECT COUNT(*) FROM deleted) > 1
BEGIN
RAISERROR('No puede actualizar más de un registro',16,1)
ROLLBACK TRANSACTION
END;

CREATE TRIGGER DIS_inscriptos_actualizar_matricula
ON inscriptos
FOR UPDATE
AS
IF UPDATE(matricula)
	IF (SELECT matricula FROM inserted) = 'n' AND (SELECT matricula FROM deleted) = 's'
	BEGIN
		RAISERROR('No puede colocar impaga una cuota paga.', 16, 1)
		ROLLBACK TRANSACTION
	END
ELSE
	IF (SELECT matricula FROM inserted) = 's' AND (SELECT matricula FROM deleted) = 'n'
		DELETE morosos
		FROM morosos
		JOIN deleted
		ON deleted.documento = morosos.documento
		WHERE morosos.documento = deleted.documento;

UPDATE inscriptos SET deporte = 'basquet' WHERE numero = 1;

UPDATE inscriptos SET deporte = 'basquet' WHERE numero BETWEEN 3 AND 4;
/*El trigger "dis_inscriptos_actualizar1" se activa y no permite la transacción. El trigger
"dis_inscriptos_actualizar_matricula" no llega a activarse.*/

UPDATE inscriptos SET matricula = 's' WHERE numero = 2;

SELECT* FROM inscriptos;/*Notamos que camibio la matricula de 'n' a 's'*/
SELECT* FROM morosos;/*Notamos que el trigger lo elimino de la tabla*/

UPDATE inscriptos SET matricula = 'n' WHERE numero = 2;
/*Ambos disparadores se activaron; "dis_inscriptos_actualizar_matricula" deshace la transacción.*/