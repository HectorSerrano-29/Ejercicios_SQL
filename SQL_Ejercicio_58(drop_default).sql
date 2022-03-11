IF OBJECT_ID('libros') IS NOT NULL
	DROP TABLE libros;

IF OBJECT_ID('VP_cero') IS NOT NULL
	DROP DEFAULT VP_cero;
IF OBJECT_ID('VP_desconocido') IS NOT NULL
	DROP DEFAULT VP_desconocido;
IF OBJECT_ID('RG_positivo') IS NOT NULL
	DROP RULE RG_positivo;/*Eliminamos los valores default y las reglas, si es que existen*/

CREATE TABLE libros(
	codigo int identity,
	titulo varchar(40) not null,
	autor varchar(30),
	editorial varchar(20),
	precio decimal(5,2),
	cantidad smallint
);

CREATE RULE RG_positivo
AS @valor >= 0;/*Regla para impedir valores negativos*/

EXEC sp_bindrule RG_positivo,'libros.precio';/*Asociamos la regla a precio de libros*/

EXEC sp_bindrule RG_positivo,'libros.cantidad';/*Asociamos la regla a cantidad de libros*/

CREATE DEFAULT VP_cero
AS 0;/*Creacion de un valor default que sea 0*/

EXEC sp_bindefault VP_cero,'libros.precio';/*Asociamos el default a precio en libros*/

EXEC sp_bindefault VP_cero,'libros.cantidad';/*Asociamos el default a cantidad en libros*/

CREATE DEFAULT VP_desconocido
AS 'Desconocido';/*Creamos otro valor default que sea 'Desconocido'*/

EXEC sp_bindefault VP_desconocido,'libros.autor';/*Asociamos el default a autor en libros*/

EXEC sp_bindefault VP_desconocido,'libros.editorial';/*Asociamos el default a editorial en libros*/

EXEC sp_help;/*Vemos las reglas y valores que hemos creado*/

EXEC sp_helpconstraint libros;/*Vemos los default y las reglas en libros deben de aparecer 6 filas*/

INSERT INTO libros (titulo)
VALUES('Aprenda PHP');
SELECT* FROM libros;/*Ingresamos un registro donde solo ingresemos el campo titulo y vemos
que se ingresaron los valores default que definimos en los otros campos*/

EXEC sp_unbindefault 'libros.precio';/*Desasociamos el valor default en precio de libros*/

INSERT INTO libros (titulo)
VALUES('Aprenda Java');
SELECT* FROM libros;/*Ingresamos un registro donde solo ingresemos el campo titulo y vemos
que en precio ahora se ingresa NULL*/

EXEC sp_helpconstraint libros;/*Vemos que ya no está asociado el valor default en el campo precio*/

EXEC sp_help VP_cero;/*Vemos que no está asociado pero aun sigue el valor default en la base de datos*/

DROP DEFAULT VP_cero;/*Vemos que no se pude eliminar ya que el valor default aun está asociado a otro campo*/

EXEC sp_unbindefault 'libros.cantidad';/*Quitamos la asociacion al campo cantidad*/

EXEC sp_helpconstraint libros;/*Vemos que ya no está asociado*/

EXEC sp_help VP_cero;/*Notamos que aun existe el valor default*/

DROP DEFAULT VP_cero;/*Ahora podemos eliminar el valor default de la base de datos ya que no tiene ninguna asociacion*/

EXEC sp_help VP_cero;/*Notamos que ya no está el valor default en la base de datos*/