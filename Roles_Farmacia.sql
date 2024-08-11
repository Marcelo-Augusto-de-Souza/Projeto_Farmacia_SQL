CREATE ROLE Proprietario;
CREATE ROLE Gerente;
CREATE ROLE Atendente;
CREATE ROLE Estoquista;
CREATE ROLE Estagiario;

REVOKE ALL ON 
farmacia.funcionario, farmacia.paciente, farmacia.enfermidades, farmacia.medicamentos, farmacia.prognostico
FROM GROUP PUBLIC;

GRANT ALL ON 
farmacia.funcionario, farmacia.paciente, farmacia.enfermidades, farmacia.medicamentos, farmacia.prognostico
TO GROUP Proprietario;

GRANT ALL ON 
farmacia.funcionario, farmacia.paciente, farmacia.enfermidades, farmacia.medicamentos, farmacia.prognostico
TO GROUP Gerente;

GRANT UPDATE, SELECT ON
farmacia.funcionario, farmacia.paciente, farmacia.enfermidades, farmacia.medicamentos, farmacia.prognostico
TO GROUP Atendente;

GRANT UPDATE, SELECT ON
farmacia.funcionario, farmacia.paciente, farmacia.enfermidades, farmacia.medicamentos, farmacia.prognostico
TO GROUP Estoquista;

GRANT SELECT ON
farmacia.funcionario, farmacia.paciente, farmacia.enfermidades, farmacia.medicamentos, farmacia.prognostico
TO GROUP Estagiario;