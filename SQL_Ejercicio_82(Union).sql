IF OBJECT_ID('clientes') IS NOT NULL
	DROP TABLE clientes;
IF OBJECT_ID('proveedores') IS NOT NULL
	DROP TABLE proveedores;
IF OBJECT_ID('empleados') IS NOT NULL
	DROP TABLE empleados;

CREATE TABLE proveedores(
	codigo int identity,
	nombre varchar (30),
	domicilio varchar(30),
	primary key(codigo)
);
CREATE TABLE clientes(
	codigo int identity,
	nombre varchar (30),
	domicilio varchar(30),
	primary key(codigo)
);
CREATE TABLE empleados(
	documento char(8) not null,
	nombre varchar(20),
	apellido varchar(20),
	domicilio varchar(30),
	primary key(documento)
);

INSERT INTO proveedores
VALUES('Bebida cola','Colon 123'),
('Carnes Unica','Caseros 222'),
('Lacteos Blanca','San Martin 987');
INSERT INTO clientes
VALUES('Supermercado Lopez','Avellaneda 34'),
('Almacen Anita','Colon 987'),
('Garcia Juan','Sucre 345');
INSERT INTO empleados 
VALUES('23333333','Federico','Lopez','Colon 987'),
('28888888','Ana','Marquez','Sucre 333'),
('30111111','Luis','Perez','Caseros 956');

SELECT nombre, domicilio
FROM proveedores
UNION
SELECT nombre, domicilio
FROM clientes
UNION
SELECT (apellido+' '+nombre), domicilio
FROM empleados;

SELECT nombre, domicilio, 'proveedor' AS categoria
FROM proveedores
UNION
SELECT nombre, domicilio, 'cliente'
FROM clientes
UNION
SELECT (apellido+' '+nombre), domicilio , 'empleado'
FROM empleados
ORDER BY categoria;/*Como las tablas funcionan por separado entonces es posible crear la columna de categoria*/