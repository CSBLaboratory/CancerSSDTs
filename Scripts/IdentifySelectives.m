% This script is used to iterate over a list of tissues and find
% strictly-selective synthetic lethal (SL) targets for each tissue using the
% FindSSDTs function.

clc 
close 
clear 

% Uncomment the line below to change the CobraSolver to 'ibm_cplex' with 'lp' as the solver
% changeCobraSolver('ibm_cplex', 'lp');

% Define a list of tissues to consider
ListOfTissues = {'COAD'; 'BRCA'; 'LUAD'; 'LIHC'; 'LUSC'; 'UCEC'; 'HNSC'; 'STAD'; 'KIRC'; 'PRAD'; 'KICH'; 'THCA'; 'KIRP'};

% Specify the maximum cardinality of SDL sets to consider
MaxCardinality = 4;

% Iterate over each tissue in the list
for i = 1 : length(ListOfTissues)
    TargetTissue = ListOfTissues{i}; % Select the current tissue as the target tissue
    % Call the FindSSDTs function to identify SDL targets for the current tissue
    SSDTs = FindSSDTs(TargetTissue, ListOfTissues, MaxCardinality);
    % Save the identified SDL targets for the current tissue to a .mat file
    save([TargetTissue, '_SSDTs.mat'], 'SSDTs')
end