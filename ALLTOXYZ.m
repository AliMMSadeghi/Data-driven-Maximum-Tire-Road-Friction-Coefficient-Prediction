close all
clearvars
clc

% NAME='1_Braking_shahrvand_Abs_on_output_2020-11-27_09-23-20';

NAME='coarse-output_2020-12-18_15-21-19';
D=xlsread([NAME '.xls']);

%% Calibration

% % IMU1
D(:,2) = D(:,2) - 0.086 ; % Ax
D(:,3) = D(:,3) + 0.021 ; % Ay
D(:,4) = D(:,4) - 0.025 ; % Az

% D(:,2) = D(:,2) - 0.06 ; % Ax
% D(:,3) = D(:,3) + 0.06 ; % Ay
% D(:,4) = D(:,4) - 0.01 ; % Az

% % IMU2
D(:,8) = D(:,8) - 0.052; % Ax
D(:,9) = D(:,9) + 0.01; % Ay
D(:,10)= D(:,10)+0.01;% Az

% D(:,8) = D(:,8) - 0.046; % Ax
% D(:,9) = D(:,9) + 0.045; % Ay
% D(:,10)= D(:,10);% Az
% % 
% % IMU3

D(:,14) = D(:,14) - 0.078; % Ax
D(:,15) = D(:,15) + 0.042 ; % Ay
D(:,16) = D(:,16) - 0.017; % Az
% 
% D(:,14) = D(:,14) - 0.055; % Ax
% D(:,15) = D(:,15) + 0.058 ; % Ay
% D(:,16) = D(:,16) - 0.02; % Az


%%
Acc(:,:)=D(:,14:16);


Acc_x=Acc(:,1);
Acc_y=Acc(:,2);
Acc_z=Acc(:,3);

lon=D(:,28)*pi/180;
lat=D(:,27)*pi/180;

for J=1:length(lon)-2
    
    if abs(10000*lat(J+1))<abs(lat(J)) || abs(lat(J+1)/10000)>abs(lat(J))
        J;
        [Acc_x(J) Acc_x(J+1)];
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

%%%%

% K = find(abs(Acc_x-(min(Acc_x)))<0.0001); % Find the index where abs(Acc_x) is maximum
% Mu = MuEstimation(min(Acc_x)*9.81 , V_GPS(K))

% Acc_x=lowpass(Acc_x,50,100);
% Acc_y=lowpass(Acc_y,40,100);
% Acc_z=lowpass(Acc_z,40,100);
% min(Acc_x)*9.81
Acc_xm = movmean(Acc_x,70);
figure;
plot(t,Acc_x,'g-','linewidth',2)
hold on;
plot(t,Acc_xm,'b-','linewidth',1.5)
legend('Standard','Filtered')
min(Acc_xm)
K = find(abs(Acc_xm-(min(Acc_xm)))<0.00001)
% Min_Acc = mean(Acc_x(K-35:K+35));
Mu = MuEstimation(Acc_xm(K)*9.81,V_GPS(K))

figure;
% subplot(3,1,[1 2])
% plot(x,y,'b-')
% xlabel('x (m)')
% ylabel('y (m)')
% title([num2str(NAME(end-18:end-9)), '  ', num2str(NAME(end-7:end))])
% grid minor
% axis equal

hold on
% pause;
% for i=1:100:length(x)
% subplot(3,1,[1 2])
% plot(x(i),y(i),'r*')
% hold on

% subplot(3,1,3)
plot(t,Acc_x,'r-')
hold on 
plot(t,Acc_y,'g-')
hold on 
plot(t,Acc_z,'b-')
hold off 
% legend('Longitudinal','Lateral','Vertical')
grid minor
xlabel('Time (sec)')
ylabel('Acceleration (g)')

% line([t(i) t(i)],[-1 2],'Color','k','LineStyle','-')
% pause(1);
hold off
% end
legend('Longitudinal','Lateral','Vertical')
grid on
xlabel('Time (sec)')
ylabel('Acceleration (g)')
x=[t',x];
y=[t',y];
V_GPS=[t',V_GPS];
Acc_x=[t',Acc_x];
Acc_y=[t',Acc_y];
Acc_z=[t',Acc_z];
lat_GPS=[t',lat*180/pi];
lon_GPS=[t',lon*180/pi];
global lat_GPS0 lon_GPS0
lat_GPS0=lat(1)*180/pi;
lon_GPS0=lon(1)*180/pi;
% global R
% R=0;
% global X_lim_min X_lim_max Y_lim_min Y_lim_max
% X_lim_min=-500;
% X_lim_max=+500;
% Y_lim_min=-500;
% Y_lim_max=+500;
global X Y
X=0;
Y=0;

T = D(:,1)-D(1,1);

% figure
% subplot(3,1,3)
% plot(Acc_x(:,1),Acc_x(:,2),'r')
% hold on 
% plot(Acc_y(:,1),Acc_y(:,2),'g')
% hold on 
% plot(Acc_z(:,1),Acc_z(:,2),'b')
% legend('Longitudinal','Lateral','Vertical')
% grid on
% xlabel('Time (sec)')
% ylabel('Acceleration (g)')
