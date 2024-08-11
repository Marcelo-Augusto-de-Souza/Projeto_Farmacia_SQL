--Instituição: UFU
--Aluno: Marcelo Augusto de Souza Rosa


CREATE SCHEMA farmacia;

CREATE TABLE farmacia.funcionario(
	id_funcionario INTEGER,
	nome VARCHAR(32) CONSTRAINT nn_nome NOT NULL,
	cpf VARCHAR(14) CONSTRAINT nn_cpf NOT NULL,
	endereco VARCHAR(32) CONSTRAINT nn_enreco NOT NULL,
	cargo VARCHAR(32) CONSTRAINT nn_cargo NOT NULL,
	salario NUMERIC(7,2) CONSTRAINT nn_salario NOT NULL,
	CONSTRAINT pk_id_funcionario PRIMARY KEY(id_funcionario)
);

CREATE TABLE farmacia.paciente(
	id_paciente INTEGER,
	nome VARCHAR(32) CONSTRAINT nn_nome NOT NULL,
	cpf VARCHAR(14) CONSTRAINT nn_cpf NOT NULL,
	endereco VARCHAR(32) CONSTRAINT nn_enreco NOT NULL,
	enfermidade VARCHAR(32),
	CONSTRAINT pk_id_paciente PRIMARY KEY(id_paciente)
);

CREATE TABLE farmacia.enfermidades(
	id_enfermidade INTEGER,
	enfermidade VARCHAR(32) CONSTRAINT nn_nome_enfermidade NOT NULL,
	sintoma_1 VARCHAR(64) CONSTRAINT nn_sintoma_1 NOT NULL,
	sintoma_2 VARCHAR(64) CONSTRAINT nn_sintoma_2 NOT NULL,
	sintoma_3 VARCHAR(64) CONSTRAINT nn_sintoma_3 NOT NULL,
	CONSTRAINT pk_id_enfermidade PRIMARY KEY(id_enfermidade)
);

CREATE TABLE farmacia.medicamentos(
	id_med INTEGER,
	nome_med VARCHAR(32) CONSTRAINT nn_nome_med NOT NULL,
	estoque_med INTEGER  CONSTRAINT nn_estoque_med NOT NULL,
	tratamento_enf_1 VARCHAR(32) CONSTRAINT nn_tratamento_1 NOT NULL,
	tratamento_enf_2 VARCHAR(32),
	CONSTRAINT pk_id_med PRIMARY KEY(id_med)
);

CREATE TABLE farmacia.prognostico(
	id_prognostico INTEGER,
	id_paciente INTEGER,
	enfermidade VARCHAR(32) CONSTRAINT nn_enfermidade NOT NULL,
	medicamento VARCHAR(32) CONSTRAINT nn_medicamento_1 NOT NULL,
	CONSTRAINT pk_id_prognostico PRIMARY KEY(id_prognostico),
	CONSTRAINT fk_id_paciente FOREIGN KEY(id_paciente)
		REFERENCES farmacia.paciente(id_paciente)
);

INSERT INTO farmacia.funcionario(id_funcionario,nome,cpf,endereco,cargo,salario)
VALUES
(1,'Claudio','123.745.234-98','Alameida dos Santos','Propriétario',15000.00),
(2,'Marco','235.634.985-66','Bairro Teixeira','Gerente',8000.00),
(3,'Jhully','745.563.567-23','Avenida Brasil','Atendente',2000.00),
(4,'Marcelino','645.856.345-99','Cruz dos Campos','Estoquista',2000.00),
(5,'Livía','534.674.113-34','Alameida dos Santos','Estagiaria',800.00);


INSERT INTO farmacia.paciente(id_paciente,nome,cpf,endereco,enfermidade)
VALUES
(1,'Julio','592.768.739-69','Vila Média','Celulite'),
(2,'Murilo','741.683.602-56','Souza Cruz','Faringite Estreptocócica'),
(3,'Jaquie','147.134.752-95','Bairro Teixeira','Febre'),
(4,'Lucas','867.939.689-74','Fundinho','Febre'),
(5,'Vitoria','471.874.581-60','Cruz dos Campos','Resfriado'),
(6,'Abigail','418.790.134-14','Av João Augusto','Herpes'),
(7,'Janaina','248.346.558-42','Santa Marta','Catapora'),
(8,'Leonardo','561.355.775-59','Avenida Brasil','Malária'),
(9,'Milton','134.693.620-43','Souza Cruz','Tuberculose'),
(10,'Wellington','349.641.624-62','Souza Cruz','Faringite Estreptocócica');


INSERT INTO farmacia.enfermidades(id_enfermidade,enfermidade,sintoma_1,sintoma_2,sintoma_3)
VALUES
(1,'Celulite','Dor no local','Calor','Edema'),
(2,'Faringite Estreptocócica','Dor de garganta','Hiperemia','Exsudato faríngeo'),
(3,'Febre','Frio','Sudorese','Fraqueza'),
(4,'Resfriado','Inflamação','Espirros','Congestão nasal'),
(5,'Herpes','Lesões cutâneas','Dor','Bolhas na pele'),
(6,'Catapora','Cansaço','Perda de apetite','Lesões cutâneas'),
(7,'Malária','Tremores','Dor de cabeça','Calafrios'),
(8,'Tuberculose','Tosse seca','Fraqueza','Suor noturno');

INSERT INTO farmacia.medicamentos(id_med,nome_med,estoque_med,tratamento_enf_1,tratamento_enf_2)
VALUES
(1,'Amoxicilina',25,'Celulite','Faringite Estreptocócica'),
(2,'Paracetamol',10,'Febre','Resfriado'),
(3,'Aciclovir',20,'Herpes','Catapora'),
(4,'Hidroxicloroquina',35,'Malária',''),
(5,'Etambutol',30,'Tuberculose','');

INSERT INTO farmacia.prognostico(id_prognostico,id_paciente,enfermidade,medicamento)
VALUES
(1,1,'Celulite','Amoxicilina'),
(2,2,'Faringite Estreptocócica','Amoxicilina'),
(3,3,'Febre','Paracetamol'),
(4,4,'Febre','Paracetamol'),
(5,5,'Resfriado','Paracetamol'),
(6,6,'Herpes','Aciclovir'),
(7,7,'Catapora','Aciclovir'),
(8,8,'Malária','Hidroxicloroquina'),
(9,9,'Tuberculose','Etambutol'),
(10,10,'Faringite Estreptocócica','Amoxicilina');




