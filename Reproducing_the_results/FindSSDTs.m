function Selective_Sols = FindSSDTs(TargetTissue, ListOfTissues, MaxCardinality)
% This function, FindSSDTs, identifies strictly-selective synthetic 
% lethal (SL) targets for a given tissue. It considers 
% the growth rate of all normal tissues to ensure minimal side effects.
%
% Inputs:
% - TargetTissue: The tissue for which strictly-selective SLs are to be
% found (string)
% - ListOfTissues: A cell array containing names of all tissues to be considered
% - MaxCardinality: Maximum cardinality of SL sets


% Change directory to access context-specific models
% cd('..\Context_Specific_Models')

% Initialize variables
Controls = cell(length(ListOfTissues), 1);
grWT = zeros(length(ListOfTissues), 1);

% Load control models for all tissues and calculate growth rates
for i = 1 : length(ListOfTissues)
    FileName = [ListOfTissues{i}, '_CSM.mat'];
    load(FileName);
    Controls{i,1} = model_control;
    sol = optimizeCbModel(model_control);
    grWT(i) = sol.f;
end

% % Change directory to access SL sets
% cd('..\All_Identified_Synthetic_Lethal_Non_Selective')

% Load data for the target tissue
FileName = [TargetTissue, '_SLs.mat'];
load(FileName);

% Initialize variables for tracking trends and solutions
Trend = zeros(MaxCardinality, length(ListOfTissues));
Sols = cell(MaxCardinality, 1);

% Iterate over different cardinalities of SDL sets
for k = 1 : MaxCardinality
    Sets = LethalSets_cancer{k};
    % Initialize variables for selective SDL targets
    Selective = false(length(Sets), length(ListOfTissues));
    for i = 1 : length(Sets)
        % Iterate over control tissues to compare growth rates
        for j = 1 : length(Controls)
            testModel = deleteModelGenes(Controls{j}, Sets(i,:));
            sol = optimizeCbModel(testModel);
            % Check if growth rate meets criteria for selectivity
            if sol.f >= grWT(j) * 0.9
                Selective(i, j) = true;
            else
                break
            end
        end
    end
    % Update trends and solutions based on selectivity
    Trend(k, :) = sum(Selective);
    Sols{k, 1} = Sets(sum(Selective, 2) == length(ListOfTissues), :);
%     cd('../Scripts')
end

% Store final selective SDL solutions
Selective_Sols = Sols;

% Post-processing to ensure uniqueness of solutions
for k = 1 : MaxCardinality
    Set = Sols{k, 1};
    Ommit = false(length(Set(:, 1)), 1);
    for i = 1 : length(Set(:, 1))
        Unq = cell(length(Set(1, :)), 1);
        for j = 1 : length(Set(1, :))
            Cur = Set{i, j};
            Cur = {Cur(1:find(Cur == '.')-1)};
            Unq(j) = Cur; 
            Set(i, j) = Cur;
        end
        Unqi = unique(Unq);
        if length(Unqi) ~= length(Unq)
            Ommit(i) = true;
            Sols{length(Unqi)}(end + 1, :) = Unqi;
        end 
    end
    Set(Ommit, :) = [];
    Sols{k, 1} = Set;
end