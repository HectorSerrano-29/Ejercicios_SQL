IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;

CREATE TABLE empleados(
	documento varchar(8),
	nombre varchar(30),
	fechanacimiento datetime,
	cantidadhijos tinyint,
	seccion varchar(20),
	sueldo decimal(6,2)
);

ALTER TABLE empleados
ADD CONSTRAINT CK_empleados_sueldo_positivo
CHECK (sueldo > 0);

INSERT INTO empleados
VALUES('22222222','Alberto Lopez','1965/10/05',1,'Sistemas',1000),
('33333333','Beatriz Garcia','1972/08/15',2,'Administracion',3000),
('34444444','Carlos Caseres','1980/10/05',0,'Contaduría',6000);

ALTER TABLE empleados
ADD CONSTRAINT CK_empleados_sueldoMaximo
CHECK (sueldo <= 5000);

DELETE FROM empleados
WHERE sueldo > 5000;

ALTER TABLE empleados
ADD CONSTRAINT CK_empleados_sueldo_maximo
CHECK (sueldo <= 5000);

ALTER TABLE empleados
ADD CONSTRAINT CK_fechaNacimiento
CHECK (fechanacimiento < getdate());

ALTER TABLE empleados
ADD CONSTRAINT CK_empleados_seccion_lista
CHECK (seccion IN ('Sistemas', 'Administracion', 'Contaduria'));

ALTER TABLE empleados
ADD CONSTRAINT CK_empleados_cantidadHijos
CHECK (cantidadhijos BETWEEN 0 AND 15);

EXEC sp_helpconstraint empleados;

INSERT INTO empleados (sueldo)
VALUES(-1);

INSERT INTO empleados (fechanacimiento)
VALUES('2023/02/25');

UPDATE empleados SET cantidadhijos = 21
WHERE documento = '22222222';

UPDATE empleados SET seccion = 'RRHH'
WHERE documento = '22222222';

ALTER TABLE empleados
ADD CONSTRAINT CK_empleados_seccion_letraInicial
CHECK (seccion LIKE '%B'); /*Ocurre error al intentar que en seccion empiece con B ya que se contradice en
el constraint anterior donde en seccion tiene cadenas que no empiezan con B*/