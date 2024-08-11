--Triggers

--Funcionarios
CREATE TEMPORARY TABLE tb_funcionarios_auditoria (
	operacao	CHAR 		NOT NULL,
	usuario	    VARCHAR     NOT NULL,
	dt_hr	    TIMESTAMP	NOT NULL,
	LIKE farmacia.funcionario
);


CREATE OR REPLACE FUNCTION farmacia.fn_funcionarios_auditoria()
RETURNS trigger AS
$$
	BEGIN
    	IF(tg_op = 'DELETE') THEN
           	INSERT INTO tb_funcionarios_auditoria
            SELECT 'D', user, now(),OLD.*;
            RETURN OLD;
    	ELSIF(tg_op = 'UPDATE') THEN
           	INSERT INTO tb_funcionarios_auditoria
            SELECT 'A', user, now(),OLD.*;
           	INSERT INTO tb_funcionarios_auditoria
            SELECT 'A', user, now(),NEW.*;
            RETURN NEW;
    	ELSIF(tg_op = 'INSERT') THEN
           	INSERT INTO tb_funcionarios_auditoria
            SELECT 'I', user, now(),NEW.*;
            RETURN NEW;
        END IF;
        RETURN NULL;                   
    END
$$
LANGUAGE plpgsql;


CREATE TRIGGER tg_funcionarios_auditoria
AFTER INSERT OR UPDATE OR DELETE ON farmacia.funcionario
FOR EACH ROW EXECUTE PROCEDURE farmacia.fn_funcionarios_auditoria();


--Pacientes
CREATE TEMPORARY TABLE tb_pacientes_auditoria (
	operacao	CHAR 		NOT NULL,
	usuario	    VARCHAR     NOT NULL,
	dt_hr	    TIMESTAMP	NOT NULL,
	LIKE farmacia.paciente
);


CREATE OR REPLACE FUNCTION farmacia.fn_pacientes_auditoria()
RETURNS trigger AS
$$
	BEGIN
    	IF(tg_op = 'DELETE') THEN
           	INSERT INTO tb_pacientes_auditoria
            SELECT 'D', user, now(),OLD.*;
            RETURN OLD;
    	ELSIF(tg_op = 'UPDATE') THEN
           	INSERT INTO tb_pacientes_auditoria
            SELECT 'A', user, now(),OLD.*;
           	INSERT INTO tb_pacientes_auditoria
            SELECT 'A', user, now(),NEW.*;
            RETURN NEW;
    	ELSIF(tg_op = 'INSERT') THEN
           	INSERT INTO tb_pacientes_auditoria
            SELECT 'I', user, now(),NEW.*;
            RETURN NEW;
        END IF;
        RETURN NULL;                   
    END
$$
LANGUAGE plpgsql;


CREATE TRIGGER tg_pacientes_auditoria
AFTER INSERT OR UPDATE OR DELETE ON farmacia.paciente
FOR EACH ROW EXECUTE PROCEDURE farmacia.fn_pacientes_auditoria();


--Enfermidades
CREATE TEMPORARY TABLE tb_enfermidades_auditoria (
	operacao	CHAR 		NOT NULL,
	usuario	    VARCHAR     NOT NULL,
	dt_hr	    TIMESTAMP	NOT NULL,
	LIKE farmacia.enfermidades
);


CREATE OR REPLACE FUNCTION farmacia.fn_enfermidades_auditoria()
RETURNS trigger AS
$$
	BEGIN
    	IF(tg_op = 'DELETE') THEN
           	INSERT INTO tb_enfermidades_auditoria
            SELECT 'D', user, now(),OLD.*;
            RETURN OLD;
    	ELSIF(tg_op = 'UPDATE') THEN
           	INSERT INTO tb_enfermidades_auditoria
            SELECT 'A', user, now(),OLD.*;
           	INSERT INTO tb_enfermidades_auditoria
            SELECT 'A', user, now(),NEW.*;
            RETURN NEW;
    	ELSIF(tg_op = 'INSERT') THEN
           	INSERT INTO tb_enfermidades_auditoria
            SELECT 'I', user, now(),NEW.*;
            RETURN NEW;
        END IF;
        RETURN NULL;                   
    END
$$
LANGUAGE plpgsql;


CREATE TRIGGER tg_enfermidades_auditoria
AFTER INSERT OR UPDATE OR DELETE ON farmacia.enfermidades
FOR EACH ROW EXECUTE PROCEDURE farmacia.fn_enfermidades_auditoria();


--Medicamentos
CREATE TEMPORARY TABLE tb_medicamentos_auditoria (
	operacao	CHAR 		NOT NULL,
	usuario	    VARCHAR     NOT NULL,
	dt_hr	    TIMESTAMP	NOT NULL,
	LIKE farmacia.medicamentos
);


CREATE OR REPLACE FUNCTION farmacia.fn_medicamentos_auditoria()
RETURNS trigger AS
$$
	BEGIN
    	IF(tg_op = 'DELETE') THEN
           	INSERT INTO tb_medicamentos_auditoria
            SELECT 'D', user, now(),OLD.*;
            RETURN OLD;
    	ELSIF(tg_op = 'UPDATE') THEN
           	INSERT INTO tb_medicamentos_auditoria
            SELECT 'A', user, now(),OLD.*;
           	INSERT INTO tb_medicamentos_auditoria
            SELECT 'A', user, now(),NEW.*;
            RETURN NEW;
    	ELSIF(tg_op = 'INSERT') THEN
           	INSERT INTO tb_medicamentos_auditoria
            SELECT 'I', user, now(),NEW.*;
            RETURN NEW;
        END IF;
        RETURN NULL;                   
    END
$$
LANGUAGE plpgsql;


CREATE TRIGGER tg_medicamentos_auditoria
AFTER INSERT OR UPDATE OR DELETE ON farmacia.medicamentos
FOR EACH ROW EXECUTE PROCEDURE farmacia.fn_medicamentos_auditoria();


--Prognostico
CREATE TEMPORARY TABLE tb_prognostico_auditoria (
	operacao	CHAR 		NOT NULL,
	usuario	    VARCHAR     NOT NULL,
	dt_hr	    TIMESTAMP	NOT NULL,
	LIKE farmacia.prognostico
);


CREATE OR REPLACE FUNCTION farmacia.fn_prognostico_auditoria()
RETURNS trigger AS
$$
	BEGIN
    	IF(tg_op = 'DELETE') THEN
           	INSERT INTO tb_prognostico_auditoria
            SELECT 'D', user, now(),OLD.*;
            RETURN OLD;
    	ELSIF(tg_op = 'UPDATE') THEN
           	INSERT INTO tb_prognostico_auditoria
            SELECT 'A', user, now(),OLD.*;
           	INSERT INTO tb_prognostico_auditoria
            SELECT 'A', user, now(),NEW.*;
            RETURN NEW;
    	ELSIF(tg_op = 'INSERT') THEN
           	INSERT INTO tb_prognostico_auditoria
            SELECT 'I', user, now(),NEW.*;
            RETURN NEW;
        END IF;
        RETURN NULL;                   
    END
$$
LANGUAGE plpgsql;


CREATE TRIGGER tg_prognostico_auditoria
AFTER INSERT OR UPDATE OR DELETE ON farmacia.prognostico
FOR EACH ROW EXECUTE PROCEDURE farmacia.fn_prognostico_auditoria();


--Pacientes Prognostico
CREATE OR REPLACE FUNCTION farmacia.fn_paciente_prognostico()
RETURNS trigger AS
$$
	DECLARE
	 max_id farmacia.paciente.id_paciente%TYPE;
	BEGIN
		SELECT max(pac.id_paciente) FROM farmacia.paciente pac INTO max_id;
		INSERT INTO farmacia.prognostico(id_prognostico,id_paciente,enfermidade,medicamento)
		SELECT max(pac.id_paciente) AS id_prognostico, max(pac.id_paciente) AS id_paciente, pac.enfermidade, med.nome_med AS medicamento
		FROM farmacia.paciente pac
		INNER JOIN farmacia.medicamentos med
			ON (pac.enfermidade = med.tratamento_enf_1 OR pac.enfermidade = med.tratamento_enf_2)
		WHERE pac.id_paciente = max_id
		GROUP BY pac.enfermidade,
				med.nome_med;
		RETURN NEW;
	END
$$
LANGUAGE plpgsql;

CREATE TRIGGER tg_paciente_prognostico
AFTER INSERT ON farmacia.paciente
FOR EACH ROW EXECUTE PROCEDURE farmacia.fn_paciente_prognostico();

SELECT * FROM farmacia.paciente;

INSERT INTO farmacia.paciente(id_paciente,nome,cpf,endereco,enfermidade)
VALUES
(11,'Livia','124.634.684-05','Santa Marta','Herpes');

SELECT * FROM farmacia.prognostico;


