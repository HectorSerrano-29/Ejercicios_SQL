IF OBJECT_ID('cuentas') is not null
DROP TABLE cuentas;

CREATE TABLE cuentas(
	numero int not null,
	documento char(8) not null,
	nombre varchar(30),
	saldo money,
	primary key (numero)
);

INSERT INTO cuentas(numero,documento,nombre,saldo)
VALUES('1234','25666777','Pedro Perez',500000.60),
('2234','27888999','Juan Lopez',-250000),
('3344','27888999','Juan Lopez',4000.50),
('3346','32111222','Susana Molina',1000);

SELECT* FROM cuentas
WHERE saldo > 4000;

SELECT numero,saldo FROM cuentas
WHERE nombre='Juan Lopez';

SELECT* FROM cuentas
WHERE saldo < 0;

SELECT* FROM cuentas
WHERE numero >= 3000;