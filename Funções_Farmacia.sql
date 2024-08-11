--Funções
CREATE OR REPLACE FUNCTION fn_paciente(estado char,id_paciente_01 integer,doenca varchar[32])
RETURNS INTEGER AS
$$
	BEGIN
	IF(estado = 'S') THEN
		DELETE FROM farmacia.paciente WHERE farmacia.paciente.id_paciente = id_paciente_01;
		DELETE FROM farmacia.prognostico WHERE farmacia.prognostico.id_paciente = id_paciente_01;
		RETURN 1;
	ELSIF(estado = 'D') THEN
		SELECT * FROM farmacia.prognostico pro WHERE pro.id_paciente = id_paciente_01 ORDER BY pro.id_diagnostico;
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;
	END
$$
LANGUAGE plpgsql




CREATE OR REPLACE FUNCTION fn_estoque_med(id_medic integer)
RETURNS INTEGER AS
$$
	DECLARE
		t_estoque farmacia.medicamentos.estoque_med%TYPE;
	BEGIN
	SELECT med.estoque_med FROM farmacia.medicamentos med INTO t_estoque WHERE med.id_med = id_medic;
	IF t_estoque < 10 THEN
		UPDATE farmacia.medicamentos SET estoque_med = 50 WHERE farmacia.medicamentos.id_med = id_medic;
		RETURN 1;
	ELSE 
		RETURN 0;
	END IF;
	END
$$
LANGUAGE plpgsql

SELECT * FROM farmacia.medicamentos
SELECT fn_estoque_med(2);

UPDATE farmacia.medicamentos SET estoque_med = 5 WHERE farmacia.medicamentos.id_med = 2;







