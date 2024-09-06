clc
close
clear
% Load the COBRA model:
Tissues = {'COAD'; 'BRCA'; 'LUAD'; 'LIHC'; 'LUSC'; 'UCEC'; 'HNSC'; 'STAD'; 'KIRC'; 'PRAD'; 'KICH'; 'THCA'; 'KIRP'};
load EliList.mat
MaxCardinality = 4;
Mode = 'Gene';

for i = 1 : length(Tissues)
    FileName = [Tissues{i}, '_CSM.mat'];
    load(FileName);
    model = model_cancer;
    LethalSets_cancer = RapidSL(model, MaxCardinality, 0.5, eliList, Mode);
    save([Tissues{i}, '_SLs.mat'], 'model_cancer', 'model_control', 'models_keep_consensus', 'LethalSets_cancer', 'Mode', 'MaxCardinality');
end