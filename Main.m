
% EEG and Machine Learning: Seizure Detection

%% Clearing Commands

% DO NOT CLEAR AFTER ADDING ML ALGORITHMS!!
%close all
%clear all

% Use mean and variance of RMS and entropy and FF
% mean of the first and second order difference
% try ML with shortened signals

%% Reading Data

File = BME772ProjectFilePath();

%Note:
% Validation Set => Normal
% chb02_01 , chb02_02 , chb02_03 , chb02_04 , chb02_05
% Validation Set => Seizure
% chb11_82 , chb11_92 , chb11_99

%% File Paths

% prompt = 'Do you wants graphs? (Y/N)';
% x = input(prompt,'s');

% You can also manually select x => Y means graphs, N means no graphs
x = ['Y'];
% x = ['N'];

[recorddata, header, time, fs, M] = BME772ProjectFileRead(File.chb02_19, x);

%% Preprocessing and Feature Extraction

% In this section, we will call functions 
% Each function peforms a section of the preprocessing

EEG_noisy = recorddata;

% Removing noise
[EEG_averaged,EEG_bandpassed] = BME772ProjectDenoise(EEG_noisy, M, time, fs, x);

% Defining the separte signal bands
[EEG_bands,EEG_rms,EEG_std,EEG_entropy]=BME772ProjectBands(EEG_bandpassed,fs, x);

% Displaying Features
[ent_mean,ent_var,rms_mean,rms_var] = BME772ProjectFeatDisp(EEG_bands,EEG_rms,EEG_std,EEG_entropy, x);

%% Tabulating

%Creating array with all the features which will be used for ML testing
Features = [rms_mean.delta,rms_mean.theta,rms_mean.alpha,rms_mean.beta,rms_var.delta,rms_var.theta,rms_var.alpha,rms_var.beta,ent_mean.delta,ent_mean.theta,ent_mean.alpha,ent_mean.beta,ent_var.delta,ent_var.theta,ent_var.alpha,ent_var.beta];

%Create a table of the new features
[T] = BME772ProjectTable(Features);

%% ML Algorithms

% Running through Naieve Bayes ML Algorithm => Accuracy: 97.1% Training Set
yfit1 = NBTrainedModel.predictFcn(T);
%Displaying the answer
disp(['In Naieve Bayes ML Algorithm, Seizure Detected? ',yfit1]);

% Running through Coarse KNN ML Algorithm => Accuracy: 70.6% Training Set
yfit2 = trainedKNN.predictFcn(T);
%Displaying the answer
disp(['In Coarse KNN ML Algorithm, Seizure Detected? ',yfit2]);

% Running through Fine Tree Model ML Algorithm => Accuracy: 94.1% Training Set
 yfit3 = treeModel.predictFcn(T);
%Displaying the answer
 disp(['In Fine Tree Model ML Algorithm, Seizure Detected? ',yfit3]);
 
 % Running through SVM Model ML Algorithm => Accuracy: ????
 yfit4 = trainedModel.predictFcn(T);
%Displaying the answer
 disp(['In SVM Model ML Algorithm, Seizure Detected? ',yfit4]);

%% ML Efficacy Calculations

% In this section, the values (TP,..) were found manually
% NB Model
TP = 2;
TN = 5;
FP = 0;
FN = 1;
disp(['The efficacy rates for NB Model are:']);
BME772ProjectMLCalc(TP,TN,FP,FN)
% KNN Model
TP = 3;
TN = 0;
FP = 5;
FN = 0;
disp(['The efficacy rates for KNN Model are:']);
BME772ProjectMLCalc(TP,TN,FP,FN)
% Fine Tree Model
TP = 1;
TN = 4;
FP = 1;
FN = 2;
disp(['The efficacy rates for Fine Tree Model are:']);
BME772ProjectMLCalc(TP,TN,FP,FN)










