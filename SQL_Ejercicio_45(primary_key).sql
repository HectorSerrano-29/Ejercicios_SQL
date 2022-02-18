IF OBJECT_ID('consultas') IS NOT NULL
	DROP TABLE consultas;

CREATE TABLE consultas(
	fechayhora datetime not null,
	medico varchar(30) not null,
	documento char(8) not null,
	paciente varchar(30),
	obrasocial varchar(30),
	primary key(fechayhora,medico)
);

INSERT INTO consultas
VALUES('2006/11/05 8:00','Lopez','12222222','Acosta Betina','PAMI'),
('2006/11/05 8:30','Lopez','23333333','Fuentes Carlos','PAMI');

INSERT INTO consultas
VALUES('2006/11/05 8:00','Perez','34444444','Garcia Marisa','IPAM'),
('2006/11/05 8:00','Duarte','45555555','Pereyra Luis','PAMI');

/*Aparecerá un error ya que se ingresará una misa hora, fecha y un mismo medico ya existente*/
INSERT INTO consultas
VALUES('2006/11/05 8:00','Perez','23333333','Fuentes Carlos','PAMI');

SELECT* FROM consultas;