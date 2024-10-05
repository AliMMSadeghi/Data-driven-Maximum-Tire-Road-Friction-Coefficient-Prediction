close all
clearvars
clc

NAME='coarse-output_2020-12-18_15-21-19';
D=xlsread([NAME '.xls']);

%% Calibration

D(:,14)=D(:,14) -0.0470-0.04;
D(:,15)=D(:,15) +0.0680-0.02;
D(:,16)=D(:,16) -.02+0.005;

%%
Acc(:,:)=D(:,14:16);

Acc_x=Acc(:,1);
Acc_y=Acc(:,2);
Acc_z=Acc(:,3);

%%
lon=D(:,28)*pi/180;
lat=D(:,27)*pi/180;

for J=1:length(lon)-2
    
    if abs(10000*lat(J+1))<abs(lat(J)) || abs(lat(J+1)/10000)>abs(lat(J))
        J
        [Acc_x(J) Acc_x(J+1)]
        D(J+1,:)=[];
        Acc_x(J+1)=[];
        
        Acc_y(J+1)=[];
        Acc_z(J+1)=[];
        
        lon(J+1)=[];
        lat(J+1)=[];

    end
    
end

V_GPS=D(:,29)/3.6;
R_earth=6371000; % Radius of curvature on the Earth
x = R_earth.* cos(lat).* cos(lon);
y = R_earth.* cos(lat).* sin(lon);
z = R_earth.*sin(lat);
% t=0.005*(0:length(x)-1);
t=0.01*(0:length(x)-1);

x=x-x(1);
y=y-y(1);

%% Wavelet
nLevel=5;
TYPE = 'sym4';
% [Ax, Dx] = FilterUsingWavelet(Acc_x,nLevel,TYPE,'Acc_x');
% [Ay, Dy] = FilterUsingWavelet(Acc_y,nLevel,TYPE,'Acc_y');
[aAz, dAz] = FilterUsingWavelet(Acc_z,nLevel,TYPE,'Acc_z');
[adAz, ddAz] = FilterUsingWavelet(dAz{5},2,TYPE,'dAz');

%%
figure;
% subplot(3,1,[1 2])
% plot(x,y,'b-')
% xlabel('x (m)')
% ylabel('y (m)')
% title([num2str(NAME(end-18:end-9)), '  ', num2str(NAME(end-7:end))])
% grid minor
% axis equal
% 
% hold on

% subplot(3,1,[1 2])
% plot(x,y,'r*')
% hold on

% subplot(3,1,3)
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

% legend('Longitudinal','Lateral','Vertical')
grid on
xlabel('Time (sec)')
ylabel('Acceleration (g)')

%% Data Segmentation

while true
    answer = questdlg('Would you like to continue removing data?', ...
        'Check', ...
        'Yes','No','Yes');
    % Handle response
    switch answer
        case 'Yes'
            disp('Data removing continues.')
            clear tp ls le
            close all
            figure;
            
            plot(t,Az{1},'b-')
            hold on
            plot(t,Ax{3},'r-')
            hold on
            plot(t,Ay{3},'g-')
            grid minor
            
            [tp ,xp]=ginput(2);
            ls=find(floor(t*10)==floor(10*tp(1)));
            le=find(floor(t*10)==floor(10*tp(2)));
            
            D(ls(1):le(1),:)=[];
            t= 0:0.01:(size(D,1)-1)/100;
            
            for i=1:nLevel
                Ax{i}(ls(1):le(1),:)=[];
                Dx{i}(ls(1):le(1),:)=[];
                Ay{i}(ls(1):le(1),:)=[];
                Dy{i}(ls(1):le(1),:)=[];
                Az{i}(ls(1):le(1),:)=[];
                Dz{i}(ls(1):le(1),:)=[];
            end
            
            Acc_x(ls(1):le(1),:)=[];
            Acc_y(ls(1):le(1),:)=[];
            Acc_z(ls(1):le(1),:)=[];
            close all

        case 'No'
            disp('Data removing is finished.')
            break
    end
    
    figure;
    plot(t,Az{3},'b-')
    hold on
    plot(t,Ax{3},'r-')
    hold on
    plot(t,Ay{3},'g-')
    
end

%%
figure
plot(t,Acc_z,'b-')
hold on
plot(t,Acc_x,'r-')
hold on
plot(t,Acc_y,'g-')

label1=[{'time'}, {'ax1'}, {'ay1'},	{'az1'}, {'gyro x1'}, {'gyro y1'}, {'gyro z1'},	{'ax2'}, {'ay2'}, {'az2'}, {'gyrox2'}, {'gyroy2'}, {'gyroz2'}, {'ax3'}, {'ay3'}, {'az3'}, {'gyro x3'}, {'gyro y3'}, {'gyro z3'}, {'ABS1'}, {'ABS2'}, {'ABS3'}, {'ABS4'}, {'turn'}, {'ADC1'}	, {'ADC2'}, {'lat'}, {'long'}, {'speed'} , {'Turn'}];

Data=D;
Datac=num2cell(Data);
Label=label1;
xlswrite(['ALI-F,L-RMS_MainPhase-East_',NAME,'.xls'],[Label;Datac])