clc
close
clear

% changeCobraSolver('ibm_cplex', 'lp');

ListOfTissues = {'COAD'; 'BRCA'; 'LUAD'; 'LIHC'; 'LUSC'; 'UCEC'; 'HNSC'; 'STAD'; 'KIRC'; 'PRAD'; 'KICH'; 'THCA'; 'KIRP'};

MaxCardinality = 4;
for i = 1 : length(ListOfTissues)
    TargetTissue = ListOfTissues{i};
    SSDTs = FindSSDTs(TargetTissue, ListOfTissues, MaxCardinality);
    save([TargetTissue, '_SSDTs.mat'], 'SSDTs')
end