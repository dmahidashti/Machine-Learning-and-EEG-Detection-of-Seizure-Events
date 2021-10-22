function [EEG_bands,EEG_entropy,EEG_rms,EEG_std]=BME772ProjectBands(EEG_bandpassed,fs, x)

% In this fucntion, we will be defining the bands within the signal
%Useful Frequency Range is Alpha: 8-13 Hz, Beta: 13-22Hz, Delta: 0.5-4 Hz, Theta: 4-8 Hz

% Alpha: 8-13 Hz
[zA,pA,kA] = butter(6,[8 13]/fs,'bandpass');
[aA,bA] = zp2sos(zA,pA,kA);
falpha= dfilt.df2sos(aA,bA);

%freqz(falpha);
%title('Alpha Filter Magnitude and Phase Reponse');

% Beta: 13-22Hz
[zB,pB,kB] = butter(6,[13 22]/fs,'bandpass');
[aB,bB] = zp2sos(zB,pB,kB);
fbeta= dfilt.df2sos(aB,bB);

% Delta: 0.5-4 Hz
[zD,pD,kD] = butter(6,[0.5 4]/fs,'bandpass');
[aD,bD] = zp2sos(zD,pD,kD);
fdelta= dfilt.df2sos(aD,bD);

% Theta: 4-8 Hz
[zT,pT,kT] = butter(6,[4 8]/fs,'bandpass');
[aT,bT] = zp2sos(zT,pT,kT);
ftheta= dfilt.df2sos(aT,bT);


fA=falpha;
fB=fbeta;
fD=fdelta;
fT=ftheta;

Data = EEG_bandpassed;
time_general= [0:(1/fs):(length(Data)-1)/fs];%general time index

%Filtration 
DataFilterA=filter(fA,Data);
DataFilterB=filter(fB,Data);
DataFilterD=filter(fD,Data);
DataFilterT=filter(fT,Data);

% Rectification
DataRectFilterA = abs(DataFilterA);
DataRectFilterB = abs(DataFilterB);
DataRectFilterD = abs(DataFilterD);
DataRectFilterT = abs(DataFilterT);

%Smoothing out the bands
% Using Savitzky-Golay filter for fast and effective smoothing
DataSmoothA = smoothdata(DataRectFilterA,'sgolay', 15000);
DataSmoothB = smoothdata(DataRectFilterB,'sgolay', 15000);
DataSmoothD = smoothdata(DataRectFilterD,'sgolay', 15000);
DataSmoothT = smoothdata(DataRectFilterT,'sgolay', 15000);

%Normalize
DataNormA=normalize(DataSmoothA);
DataNormB=normalize(DataSmoothB);
DataNormD=normalize(DataSmoothD);
DataNormT=normalize(DataSmoothT);

%Time Indexes 
t1= [0:(1/fs):(length(DataNormA)-1)/fs];
t1 = t1';
t2= [0:(1/fs):(length(DataNormB)-1)/fs];
t2 = t2';
t3= [0:(1/fs):(length(DataNormD)-1)/fs];
t3 = t3';
t4= [0:(1/fs):(length(DataNormT)-1)/fs];
t4 = t4';

if x=='Y'
% Process Plots
figure;
hold on
subplot(4,1,1)
plot(t1,DataFilterA);
title('Denoised Alpha Band EEG')
xlabel('Time(sec)');
ylabel('Voltage(V)');
subplot(4,1,2)
plot(t1,DataRectFilterA);
title('Rectified Denoised Alpha Band EEG')
xlabel('Time(sec)');
ylabel('Voltage(V)');
subplot(4,1,3)
plot(t1,DataSmoothA);
title('Smoothed Rectified Denoised Alpha Band EEG')
xlabel('Time(sec)');
ylabel('Voltage(V)');
subplot(4,1,4)
plot(t1,DataNormA);
title('Normalized Smoothed Rectified Denoised Alpha Band EEG')
xlabel('Time(sec)');
ylabel('Voltage(V)');
hold off

%Plots
figure;
hold on;
subplot(4,1,1);
plot(t1,DataNormA,'-r');% Plotting Alpha Wave
xlabel('Time(sec)');
ylabel('Voltage(V)');
title('Alpha Wave');
grid;
subplot(4,1,2);
plot(t2,DataNormB,'-b');% Plotting Beta Wave
xlabel('Time(sec)');
ylabel('Voltage(V)');
title('Beta Wave');
grid;
subplot(4,1,3);
plot(t3,DataNormD,'-g');% Plotting Delta Wave
xlabel('Time(sec)');
ylabel('Voltage(V)');
title('Delta Wave');
grid;
subplot(4,1,4);
plot(t4,DataNormT,'-k');% Plotting Theta Wave
xlabel('Time(sec)');
ylabel('Voltage(V)');
title('Theta Wave');
grid;
hold off;
else if x=='N'
        disp([' ']);   
else 
    disp(['Error: Plotting in Bands']);
    end
end

EEG_bands=struct('alpha',DataNormA,'beta',DataNormB,'delta',DataNormD,'theta',DataNormT);

segment = 30;% This number can be changed, but 30 is most widely used and results in an acceptable resolution

%Segmenting Each Normalized Band
SegLenA =(length(DataNormA)/segment);
SegLenB =(length(DataNormB)/segment);
SegLenD =(length(DataNormD)/segment);
SegLenT =(length(DataNormT)/segment);

for i = 0:(segment-1) %Segment of Each Band
    DataSegA(i+1,:) = DataNormA(1+(SegLenA*i):(SegLenA*(i+1)));
    DataSegB(i+1,:) = DataNormB(1+(SegLenB*i):(SegLenB*(i+1)));
    DataSegD(i+1,:) = DataNormD(1+(SegLenD*i):(SegLenD*(i+1)));
    DataSegT(i+1,:) = DataNormT(1+(SegLenT*i):(SegLenT*(i+1)));
end

% Finding the Entropy of the bands
for i = 0:(segment-1)
    EntropyA(i+1,1) = entropy(DataSegA(i+1,:));
    EntropyB(i+1,1) = entropy(DataSegB(i+1,:));
    EntropyD(i+1,1) = entropy(DataSegD(i+1,:));
    EntropyT(i+1,1) = entropy(DataSegT(i+1,:));
end

EEG_entropy=struct('alpha',EntropyA,'beta',EntropyB,'delta',EntropyD,'theta',EntropyT);

% Finding RMS of the bands
for i = 0:(segment-1)
    rmsA(i+1,1) = rms(DataSegA(i+1,:));
    rmsB(i+1,1) = rms(DataSegB(i+1,:));
    rmsD(i+1,1) = rms(DataSegD(i+1,:));
    rmsT(i+1,1) = rms(DataSegT(i+1,:));
end

EEG_rms=struct('alpha',rmsA,'beta',rmsB,'delta',rmsD,'theta',rmsT);

% Finding STD of the bands
for i = 0:(segment-1)
    stdA(i+1,1) = std(DataSegA(i+1,:));
    stdB(i+1,1) = std(DataSegB(i+1,:));
    stdD(i+1,1) = std(DataSegD(i+1,:));
    stdT(i+1,1) = std(DataSegT(i+1,:));
end

EEG_std=struct('alpha',stdA,'beta',stdB,'delta',stdD,'theta',stdT);

disp(['Band Detection and Feature Extraction Complete!']);
 










