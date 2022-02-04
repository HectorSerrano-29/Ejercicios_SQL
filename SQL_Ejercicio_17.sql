IF OBJECT_ID('autos') is not null
DROP TABLE autos;

CREATE TABLE autos(
	patente char(6),
	marca varchar(20),
	modelo char(4),
	precio float,
	primary key (patente)
);

INSERT INTO autos
VALUES('ACD123','Fiat 128','1970',15000),
('ACG234','Renault 11','1990',40000),
('BCD333','Peugeot 505','1990',80000),
('GCD123','Renault Clio','1990',70000),
('BCC333','Renault Megane','1998',95000),
('BVF543','Fiat 128','1975',20000);

SELECT* FROM autos
WHERE modelo = '1990';