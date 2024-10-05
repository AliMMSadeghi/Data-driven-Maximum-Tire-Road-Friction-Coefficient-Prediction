close all
clearvars
clc

%%
NAME=uigetfile(' .xls' );
NAME=NAME(1:end-4);
D=xlsread(NAME);

%%
Acc(:,:)=D(:,14:16);

Acc_x=Acc(:,1);
Acc_y=Acc(:,2);
Acc_z=Acc(:,3);

t=0.01*(0:length(Acc_x)-1);

%%
figure;

plot(t,Acc_x,'r-')
hold on
plot(t,Acc_y,'g-')
hold on
plot(t,Acc_z,'b-')
% hold off
% legend('Longitudinal','Lateral','Vertical')
grid on
xlabel('Time (sec)')
ylabel('Acceleration (g)')

%% Wavelet
nLevel=5;
TYPE = 'sym4';
% [Ax, Dx] = FilterUsingWavelet(Acc_x,nLevel,TYPE,'Acc_x');
% [Ay, Dy] = FilterUsingWavelet(Acc_y,nLevel,TYPE,'Acc_y');
[aAz, dAz] = FilterUsingWavelet(Acc_z,nLevel,TYPE,'Acc_z');
[adAz, ddAz] = FilterUsingWavelet(dAz{1},2,'sym8','dAz');
adAz{2}=adAz{2}(1:end-3);
%%
figure;
plot(adAz{2}) 
%%
% pause;

NumDetail = 5;
Feature = zeros(NumDetail+1,5);

for i=1:NumDetail+1
    
    if i==1
        Feature(1,1) = var(Acc_z); % Variance
        Feature(1,2) = (mean ( sqrt(abs(Acc_z)) ) )^2; % SRA
        Feature(1,3) = rms(Acc_z); % RMS
        Feature(1,4) = max(Acc_z); % Max
        
    elseif i==NumDetail+1
        
        Feature(NumDetail+1,1) = var(adAz{2}); % Variance
        Feature(NumDetail+1,2) = (mean ( sqrt(abs(adAz{2})) ) )^2; % SRA
        Feature(NumDetail+1,3) = rms(adAz{2}); % RMS
        Feature(NumDetail+1,4) = max(adAz{2}); % Max
        
    else
        Feature(i,1) = var(dAz{i}); % Variance
        Feature(i,2) = (mean ( sqrt(abs(dAz{i})) ) )^2; % SRA
        Feature(i,3) = rms(dAz{i}); % RMS
        Feature(i,4) = max(dAz{i}); % Max
    end
end

Energy =0;

for i=2:nLevel
    
   Energy = Energy + norm(dAz{i})^2 + norm(adAz{2})^2;
    
end

Feature(1,5) = Energy;
Feature  = Feature(1:25);
save([NAME '.mat'],'Feature');
