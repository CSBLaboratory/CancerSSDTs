clc
close
clear

% Run CreateCSM.m to produce Context Specific Models
global Tissues MaxCardinality
Tissues = {'COAD'; 'LUAD'; 'LIHC'; 'BRCA'; 'LUSC'; 'UCEC'; 'HNSC'; 'STAD'; 'KIRC'; 'PRAD'; 'KICH'; 'THCA'; 'KIRP'};
MaxCardinality = 4;

CreateCSM;

FindForbidenGenes.m;

FindAllSLs.m

IdentifySelectives.m
