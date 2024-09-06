clc
close
clear
% Load the COBRA model:
global Tissues
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