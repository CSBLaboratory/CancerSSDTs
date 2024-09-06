clc
close
clear

changeCobraSolver('ibm_cplex');
% Run CreateCSM.m to produce Context Specific Models
global Tissues MaxCardinality
Tissues = {'COAD'; 'BRCA'; 'LUAD'; 'LIHC'; 'LUSC'; 'UCEC'; 'HNSC'; 'STAD'; 'KIRC'; 'PRAD'; 'KICH'; 'THCA'; 'KIRP'};
MaxCardinality = 4;

CreateCSM

FindForbidenGenes;

FindAllSLs

IdentifySelectives
