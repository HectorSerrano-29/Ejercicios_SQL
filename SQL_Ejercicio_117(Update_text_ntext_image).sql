IF OBJECT_ID('alumnos') IS NOT NULL
	DROP TABLE alumnos;

CREATE TABLE alumnos (
	documento char(8),
	nombre varchar(30),
	nota decimal(4,2),
	concepto text,
	constraint PK_alumnos
	primary key(documento)
);

INSERT INTO alumnos
VALUES('22222222','Ana Acosta',3,'Participativo. Generoso'),
('23333333','Carlos Caseres',7,'Poco participativo'),
('24444444','Diego Duarte',8,'Buen compañero'),
('25555555','Fabiola Fuentes',2,null);

SELECT* FROM alumnos;

DECLARE @puntero binary(16)
SELECT @puntero = textptr (concepto)
FROM alumnos
WHERE documento = '23333333'
IF (textvalid('alumnos.concepto',@puntero) = 1)
UPDATETEXT alumnos.concepto @puntero 5 NULL 'comunicativo'
ELSE
SELECT 'Puntero inválido';

DECLARE @puntero binary(16)
SELECT @puntero = textptr (concepto)
FROM alumnos
WHERE documento = '23333333'
 
READTEXT alumnos.concepto @puntero 0 0;

DECLARE @puntero binary(16)
SELECT @puntero = textptr (concepto)
FROM alumnos
WHERE documento='25555555'
IF (textvalid('alumnos.concepto',@puntero) = 1)
UPDATETEXT alumnos.concepto @puntero 0 0 'Muy comunicativo'
ELSE
SELECT 'Puntero inválido';

DECLARE @puntero binary(16)
SELECT @puntero = textptr (concepto)
FROM alumnos
WHERE documento='24444444'
UPDATETEXT alumnos.concepto @puntero 20 0 ' y estudioso';

DECLARE @puntero binary(16)
SELECT @puntero = textptr (concepto)
FROM alumnos
WHERE documento = '24444444'
IF (textvalid('alumnos.concepto',@puntero) = 1)
UPDATETEXT alumnos.concepto @puntero 5 0 'alumno y '
ELSE
SELECT'Puntero inválido';

DECLARE @puntero binary(16)
SELECT @puntero = textptr (concepto)
FROM alumnos
WHERE documento = '24444444'
 
READTEXT alumnos.concepto @puntero 0 0;

IF OBJECT_ID('reprobados') IS NOT NULL
DROP TABLE reprobados;

CREATE TABLE reprobados(
	documento char(8) not null,
	concepto text
);

INSERT INTO reprobados VALUES('22222222',''),
('25555555','');

DECLARE @puntero1 binary(16)
SELECT @puntero1 = textptr(concepto)
FROM alumnos
WHERE documento = '22222222'

DECLARE @puntero2 binary(16)
SELECT @puntero2 = textptr(concepto)
FROM reprobados
WHERE documento = '22222222'

IF (textvalid('alumnos.concepto',@puntero1) = 1) 
IF (textvalid('reprobados.concepto',@puntero2) = 1)
UPDATETEXT reprobados.concepto @puntero2 0 null alumnos.concepto @puntero1
ELSE SELECT 'Puntero a la tabla reprobados inválido'
ELSE SELECT 'Puntero a la tabla alumnos inválido';

DECLARE @puntero binary(16)
SELECT @puntero = textptr(concepto)
FROM reprobados
WHERE documento = '22222222'
READTEXT reprobados.concepto @puntero 0 0;

DECLARE @puntero1 binary(16)
SELECT @puntero1 = textptr(concepto)
FROM alumnos
WHERE documento = '25555555'

DECLARE @puntero2 binary(16)
SELECT @puntero2 = textptr(concepto)
FROM reprobados
WHERE documento = '25555555'

IF(textvalid('alumnos.concepto',@puntero1) = 1) 
IF (textvalid('reprobados.concepto',@puntero2) = 1)
UPDATETEXT reprobados.concepto @puntero2 0 NULL alumnos.concepto @puntero1
ELSE SELECT 'Puntero de "reprobados" inválido'
ELSE SELECT 'Puntero de "alumnos" inválido';

DECLARE @puntero1 binary(16)
SELECT @puntero1 = textptr(concepto)
FROM alumnos
WHERE documento = '23333333'

DECLARE @puntero2 binary(16)
SELECT @puntero2 = textptr(concepto)
FROM reprobados
WHERE documento = '23333333'

IF (textvalid('alumnos.concepto',@puntero1) = 1) 
IF (textvalid('reprobados.concepto',@puntero2) = 1)
UPDATETEXT reprobados.concepto @puntero2 0 NULL
alumnos.concepto @puntero1
ELSE SELECT 'Puntero de "reprobados" inválido'
ELSE SELECT 'Puntero de "alumnos" inválido';