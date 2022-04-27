IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;

CREATE TABLE empleados(
	documento char(8) not null,
	nombre varchar(10),
	domicilio varchar(30),
	ciudad varchar(20) default 'Buenos Aires'
);

ALTER TABLE empleados
ADD legajo int identity
CONSTRAINT PK_empleados_legajo PRIMARY KEY;

sp_columns empleados;

EXEC sp_helpconstraint empleados;

ALTER TABLE empleados
ADD hijos tinyint
CONSTRAINT CK_empleados_hijos CHECK (hijos <= 30)

INSERT INTO empleados
VALUES('22222222','Juan Lopez','Colon 123','Cordoba',2),
('23333333','Ana Garcia','Sucre 435','Cordoba',3);

ALTER TABLE empleados
ADD sueldo DECIMAL(6,2) NOT NULL
CONSTRAINT CK_empleados_sueldo CHECK (sueldo >= 0)
/*No lo permite porque no damos un valor por defecto para dicho campo no nulo y los registros 
existentes necesitan cargar un valor.*/

ALTER TABLE empleados
ADD sueldo DECIMAL(6,2) NOT NULL
CONSTRAINT CK_empleados_sueldo CHECK (sueldo >= 0)
CONSTRAINT DF_empleados_sueldo DEFAULT 0;/*Se agrega el valor por defecto para que cargue este valor
a los registros existentes*/

SELECT * FROM empleados;

EXEC sp_columns empleados;

EXEC sp_helpconstraint empleados;