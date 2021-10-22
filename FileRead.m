function [recorddata, header, time, fs, M] = BME772ProjectFileRead(File_name, x)

[header, recorddata] = BME772Projectedfread(File_name);

%Processing data from edfread
header = struct2cell(header);
fs=header{19};
fs = fs(1,1);
%Finding the dimensions of the data file
[M,N] = size(recorddata);
%Defining time vector
time=(0:length(recorddata(1,:))-1)/fs;

if x=='Y'
%Plotting the original signal
figure;
plot(time, recorddata(1,:));
title('Original signal');
xlabel('Time(s)');
ylabel('Amplitude');
grid;
else if x=='N'
        disp([' ']);   
else 
    disp(['Error']);
    end
end
disp(['File Reading Finished!']);