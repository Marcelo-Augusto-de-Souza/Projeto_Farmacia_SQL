CREATE OR REPLACE VIEW v_funcionarios AS
SELECT * FROM farmacia.funcionario ORDER BY id_funcionario;

CREATE OR REPLACE VIEW v_pacientes AS
SELECT * FROM farmacia.paciente ORDER BY farmacia.paciente.id_paciente;

CREATE OR REPLACE VIEW v_especificidades_medicamentos AS
SELECT med.nome_med AS medicamento, med.tratamento_enf_1 AS enfermidade_1, med.tratamento_enf_2 AS enfermidade_2
FROM farmacia.medicamentos med
INNER JOIN farmacia.enfermidades enf
	ON (med.tratamento_enf_1 = enf.enfermidade OR med.tratamento_enf_2 = enf.enfermidade)
ORDER BY med.nome_med;

CREATE OR REPLACE VIEW v_especificidades_enfermidades AS
SELECT enf.enfermidade AS enfermidade, enf.sintoma_1, enf.sintoma_2, enf.sintoma_3, med.nome_med AS medicamento
FROM farmacia.enfermidades enf
INNER JOIN farmacia.medicamentos med
	ON (enf.enfermidade = med.tratamento_enf_1 OR enf.enfermidade = med.tratamento_enf_2)
ORDER BY enf.enfermidade;

CREATE OR REPLACE VIEW v_classificacao_paciente AS
SELECT pac.nome, pac.id_paciente, pro.enfermidade, pro.medicamento
FROM farmacia.prognostico pro
INNER JOIN farmacia.paciente pac
	ON pac.id_paciente = pro.id_paciente
ORDER BY pac.id_paciente;