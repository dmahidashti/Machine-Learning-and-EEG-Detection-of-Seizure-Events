function [ent_mean,ent_var,rms_mean,rms_var]=BME772ProjectFeatDisp(EEG_bands,EEG_rms,EEG_std,EEG_entropy, x)
% The purpose of this function is to extract the mean and variance of RMS, Entropy and STD for
% EACH band of the signal

% Extracting the seperate bands
EEG_delta=EEG_bands.delta;
EEG_theta=EEG_bands.theta;
EEG_alpha=EEG_bands.alpha;
EEG_beta=EEG_bands.beta;

% Extracting the rms for the bands
EEG_delta_rms=EEG_rms.delta;
EEG_theta_rms=EEG_rms.theta;
EEG_alpha_rms=EEG_rms.alpha;
EEG_beta_rms=EEG_rms.beta;

% If function to allow/disallow graphing
if x=='Y'
figure;
subplot(2,2,1)
boxplot(EEG_delta_rms)
title('Delta RMS');
subplot(2,2,2)
boxplot(EEG_theta_rms)
title('Theta RMS');
subplot(2,2,3)
boxplot(EEG_alpha_rms)
title('Alpha RMS');
subplot(2,2,4)
boxplot(EEG_beta_rms)
title('Beta RMS');

else if x=='N'
        disp([' ']);   
else 
    disp(['Error: Boxplotting RMS']);
    end
end

% % Extracting the std for the bands
% EEG_delta_std=EEG_std.delta;
% EEG_theta_std=EEG_std.theta;
% EEG_alpha_std=EEG_std.alpha;
% EEG_beta_std=EEG_std.beta;
% 
% if x=='Y'
% figure;
% subplot(2,2,1)
% boxplot(EEG_delta_std)
% title('Delta STD');
% subplot(2,2,2)
% boxplot(EEG_theta_std)
% title('Theta STD');
% subplot(2,2,3)
% boxplot(EEG_alpha_std)
% title('Alpha STD');
% subplot(2,2,4)
% boxplot(EEG_beta_std)
% title('Beta STD');
% 
% else if x=='N'
%         disp([' ']);   
% else 
%     disp(['Error: Box plotting std']);
%     end
% end



% Extracting the entropy for the bands
EEG_delta_entropy=EEG_entropy.delta;
EEG_theta_entropy=EEG_entropy.theta;
EEG_alpha_entropy=EEG_entropy.alpha;
EEG_beta_entropy=EEG_entropy.beta;

% Entropy Mean
disp_ent_delta = mean(EEG_delta_entropy);
disp_ent_theta = mean(EEG_theta_entropy);
disp_ent_alpha = mean(EEG_alpha_entropy);
disp_ent_beta = mean(EEG_beta_entropy);
% Defining struct with all entropy mean values
ent_mean = struct('delta',disp_ent_delta,'theta',disp_ent_theta,'alpha',disp_ent_alpha,'beta',disp_ent_beta);

% Entropy Variance
disp_ent_delta_var = var(EEG_delta_entropy);
disp_ent_theta_var = var(EEG_theta_entropy);
disp_ent_alpha_var = var(EEG_alpha_entropy);
disp_ent_beta_var = var(EEG_beta_entropy);
% Defining struct with all entropy variance values
ent_var = struct('delta',disp_ent_delta_var,'theta',disp_ent_theta_var,'alpha',disp_ent_alpha_var,'beta',disp_ent_beta_var);

% Displaying Entropy Values
disp(['Mean Entropy']);
disp_ent=['Delta Entropy: ', num2str(disp_ent_delta),' Theta Entropy: ', num2str(disp_ent_theta),' Alpha Entropy: ', num2str(disp_ent_alpha),' Beta Entropy: ', num2str(disp_ent_beta)];
disp(disp_ent);
disp([' ']);
disp(['Variance Entropy']);
disp_ent_var=['Delta Entropy: ', num2str(disp_ent_delta_var),' Theta Entropy: ', num2str(disp_ent_theta_var),' Alpha Entropy: ', num2str(disp_ent_alpha_var),' Beta Entropy: ', num2str(disp_ent_beta_var)];
disp(disp_ent_var);
disp([' ']);

% RMS Mean
disp_rms_delta = mean(EEG_delta_rms);
disp_rms_theta = mean(EEG_theta_rms);
disp_rms_alpha = mean(EEG_alpha_rms);
disp_rms_beta = mean(EEG_beta_rms);
% Defining struct with all RMS mean values
rms_mean = struct('delta',disp_rms_delta,'theta',disp_rms_theta,'alpha',disp_rms_alpha,'beta',disp_rms_beta);

% RMS Variance
disp_rms_delta_var = var(EEG_delta_rms);
disp_rms_theta_var = var(EEG_theta_rms);
disp_rms_alpha_var = var(EEG_alpha_rms);
disp_rms_beta_var = var(EEG_beta_rms);

% Defining struct with all RMS variance values
rms_var = struct('delta',disp_rms_delta_var,'theta',disp_rms_theta_var,'alpha',disp_rms_alpha_var,'beta',disp_rms_beta_var);

% Displaying RMS Values
disp(['Mean RMS']);
disp_rms=['Delta RMS: ', num2str(disp_rms_delta),' Theta RMS: ', num2str(disp_rms_theta),' Alpha RMS: ', num2str(disp_rms_alpha),' Beta RMS: ', num2str(disp_rms_beta)];
disp(disp_rms);
disp([' ']);
disp(['Variance RMS']);
disp_rms_var=['Delta RMS: ', num2str(disp_rms_delta_var),' Theta RMS: ', num2str(disp_rms_theta_var),' Alpha RMS: ', num2str(disp_rms_alpha_var),' Beta RMS: ', num2str(disp_rms_beta_var)];
disp(disp_rms_var);
disp([' ']);

% This section is used only for analysis:

% disp(['RMS 25th, 50th and 75th Qunantiles:']);
% disp([' ']);
% disp_rms_delta=['Delta: 25th: ', num2str(prctile(EEG_delta_rms, 25)),' 50th: ', num2str(prctile(EEG_delta_rms, 50)), ' 75th: ', num2str(prctile(EEG_delta_rms, 75))];
% disp(disp_rms_delta);
% disp([' ']);
% disp_rms_theta=['Theta: 25th: ', num2str(prctile(EEG_theta_rms, 25)),' 50th: ', num2str(prctile(EEG_theta_rms, 50)), ' 75th: ', num2str(prctile(EEG_theta_rms, 75))];
% disp(disp_rms_theta);
% disp([' ']);
% disp_rms_alpha=['Alpha: 25th: ', num2str(prctile(EEG_alpha_rms, 25)),' 50th: ', num2str(prctile(EEG_alpha_rms, 50)), ' 75th: ', num2str(prctile(EEG_alpha_rms, 75))];
% disp(disp_rms_alpha);
% disp([' ']);
% disp_rms_beta=['Beta: 25th: ', num2str(prctile(EEG_beta_rms, 25)),' 50th: ', num2str(prctile(EEG_beta_rms, 50)), ' 75th: ', num2str(prctile(EEG_beta_rms, 75))];
% disp(disp_rms_beta);
% disp([' ']);


% disp_std_delta = mean(EEG_delta_std);
% disp_std_theta = mean(EEG_theta_std);
% disp_std_alpha = mean(EEG_alpha_std);
% disp_std_beta = mean(EEG_beta_std);
% disp_std_delta_var = var(EEG_delta_std);
% disp_std_theta_var = var(EEG_theta_std);
% disp_std_alpha_var = var(EEG_alpha_std);
% disp_std_beta_var = var(EEG_beta_std);
% 
% disp(['Mean STD']);
% disp_std=['Delta STD: ', num2str(disp_std_delta),' Theta STD: ', num2str(disp_std_theta),' Alpha STD: ', num2str(disp_std_alpha),' Beta STD: ', num2str(disp_std_beta)];
% disp(disp_std);
% disp([' ']);
% disp(['Variance STD']);
% disp_std_var=['Delta STD: ', num2str(disp_std_delta_var),' Theta STD: ', num2str(disp_std_theta_var),' Alpha STD: ', num2str(disp_std_alpha_var),' Beta STD: ', num2str(disp_std_beta_var)];
% disp(disp_std_var);
% disp([' ']);
% disp(['STD 25th, 50th and 75th Qunantiles:']);
% disp([' ']);
% disp_std_delta=['Delta: 25th: ', num2str(prctile(EEG_delta_std, 25)),' 50th: ', num2str(prctile(EEG_delta_std, 50)), ' 75th: ', num2str(prctile(EEG_delta_std, 75))];
% disp(disp_std_delta);
% disp([' ']);
% disp_std_theta=['Theta: 25th: ', num2str(prctile(EEG_theta_std, 25)),' 50th: ', num2str(prctile(EEG_theta_std, 50)), ' 75th: ', num2str(prctile(EEG_theta_std, 75))];
% disp(disp_std_theta);
% disp([' ']);
% disp_std_alpha=['Alpha: 25th: ', num2str(prctile(EEG_alpha_std, 25)),' 50th: ', num2str(prctile(EEG_alpha_std, 50)), ' 75th: ', num2str(prctile(EEG_alpha_std, 75))];
% disp(disp_std_alpha);
% disp([' ']);
% disp_std_beta=['Beta: 25th: ', num2str(prctile(EEG_beta_std, 25)),' 50th: ', num2str(prctile(EEG_beta_std, 50)), ' 75th: ', num2str(prctile(EEG_beta_std, 75))];
% disp(disp_std_beta);
% disp([' ']);

disp(['Feature displaying complete!']);
