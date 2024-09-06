clc
close
clear
% Load the COBRA model:
Tissues = {'COAD'; 'BRCA'; 'LUAD'; 'LIHC'; 'LUSC'; 'UCEC'; 'HNSC'; 'STAD'; 'KIRC'; 'PRAD'; 'KICH'; 'THCA'; 'KIRP'};
MaxCardinality = 1;
Mode = 'Gene';
forbiddenSets = [];
for i = 1 : length(Tissues)
    FileName = [Tissues{i}, '_CSM.mat'];
    load(FileName);
    model = model_control;
    LethalSets_control = RapidSL(model, MaxCardinality, 0.9, [], Mode);
    forbiddenSets = [forbiddenSets; LethalSets_control{1}];
end
eliList = unique(forbiddenSets);
save('EliList', 'eliList');