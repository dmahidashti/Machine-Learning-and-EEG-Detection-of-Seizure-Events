function [T] = BME772ProjectTable(Features)

% This function is used to table all the array values, by renaming them
% according to the ML specifications. This setup can be cross refernced
% with the features file (excel file)

%Creating a table out of the array
T = array2table(Features);
%Renaming table variables so they can be recognized by the algorithm
T.Properties.VariableNames{'Features1'} = 'RMS_Delta';
T.Properties.VariableNames{'Features2'} = 'RMS_Theta';
T.Properties.VariableNames{'Features3'} = 'RMS_Alpha';
T.Properties.VariableNames{'Features4'} = 'RMS_Beta';
T.Properties.VariableNames{'Features5'} = 'RMS_Delta_var';
T.Properties.VariableNames{'Features6'} = 'RMS_Theta_var';
T.Properties.VariableNames{'Features7'} = 'RMS_Alpha_var';
T.Properties.VariableNames{'Features8'} = 'RMS_Beta_var';
T.Properties.VariableNames{'Features9'} = 'Ent_Delta';
T.Properties.VariableNames{'Features10'} = 'Ent_Theta';
T.Properties.VariableNames{'Features11'} = 'Ent_Alpha';
T.Properties.VariableNames{'Features12'} = 'Ent_Beta';
T.Properties.VariableNames{'Features13'} = 'Ent_Delta_var';
T.Properties.VariableNames{'Features14'} = 'Ent_Theta_var';
T.Properties.VariableNames{'Features15'} = 'Ent_Alpha_var';
T.Properties.VariableNames{'Features16'} = 'Ent_Beta_var';
%Displaying the table
disp(T)
disp(['Tabulation complete!']);