function Selective_Sols = FindSSDTs(TargetTissue, ListOfTissues, MaxCardinality)

cd('..\Context_Specific_Models')
Controls = cell(length(ListOfTissues), 1);
grWT = zeros(length(ListOfTissues), 1);
for i = 1 : length(ListOfTissues)
    FileName = [ListOfTissues{i}, '_CSM.mat'];
    load(FileName);
    Controls{i,1} = model_control;
    sol = optimizeCbModel(model_control);
    grWT(i) = sol.f;
end

cd('..\All_Identified_Synthetic_Lethal_Non_Selective')
FileName = [TargetTissue, '_QGD.mat'];
load(FileName);
Trend = zeros(MaxCardinality, length(ListOfTissues));
Sols = cell(MaxCardinality, 1);
for k = 1 : MaxCardinality
    Sets = LethalSets_cancer{k};
    iSelective = false;
    Selective = false(length(Sets), length(ListOfTissues));
    for i = 1 : length(Sets)
        for j = 1 : length(Controls)
            testModel = deleteModelGenes(Controls{j}, Sets(i,:));
            sol = optimizeCbModel(testModel);
            if sol.f >= grWT(j)*0.9
                Selective(i, j) = true;
            else
                break
            end
        end
        %     Selective(i, :) = iSelective
    end
    Trend(k, :) = sum(Selective);
    Sols{k, 1} = Sets(sum(Selective, 2) == length(ListOfTissues), :);
    cd('../Scripts')
end
Selective_Sols = Sols;
for k = 1 : MaxCardinality
    Set = Sols{k, 1};
    Ommit = false(length(Set(:, 1)), 1);
    for i = 1 : length(Set(:, 1))
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