clc
clearvars 
close all
NAME=uigetfile(' .xls' );
D=xlsread(NAME);
NAME=NAME(1:end-4);

%%  Calibration

% % IMU1
% D(:,2) = D(:,2) - 0.086 ; % Ax
% D(:,3) = D(:,3) + 0.021 ; % Ay
% D(:,4) = D(:,4) - 0.025 ; % Az

D(:,2) = D(:,2) - 0.06 ; % Ax
D(:,3) = D(:,3) + 0.06 ; % Ay
D(:,4) = D(:,4) - 0.01 ; % Az

% % IMU2
% D(:,8) = D(:,8) - 0.052; % Ax
% D(:,9) = D(:,9) + 0.01; % Ay
% D(:,10)= D(:,10)+0.01;% Az

D(:,8) = D(:,8) - 0.046; % Ax
D(:,9) = D(:,9) + 0.045; % Ay
D(:,10)= D(:,10);% Az
% 
% % IMU3

% D(:,14) = D(:,14) - 0.078; % Ax
% D(:,15) = D(:,15) + 0.042 ; % Ay
% D(:,16) = D(:,16) - 0.017; % Az

D(:,14) = D(:,14) - 0.055; % Ax
D(:,15) = D(:,15) + 0.058 ; % Ay
D(:,16) = D(:,16) - 0.02; % Az

%%
i=0;
t=D(:,1+i);
t=t-t(1);
i=i+1;
accx1=D(:,1+i);
i=i+1;
accy1=D(:,1+i);
i=i+1;
accz1=D(:,1+i);
i=i+1;
gyrox1=D(:,1+i);
i=i+1;
gyroy1=D(:,1+i);
i=i+1;
gyroz1=D(:,1+i);
i=i+1;
accx2=D(:,1+i);
i=i+1;
accy2=D(:,1+i);
i=i+1;
accz2=D(:,1+i);
i=i+1;
gyrox2=D(:,1+i);
i=i+1;
gyroy2=D(:,1+i);
i=i+1;
gyroz2=D(:,1+i);
i=i+1;
accx3=D(:,1+i);
i=i+1;
accy3=D(:,1+i);
i=i+1;
accz3=D(:,1+i);
i=i+1;
gyrox3=D(:,1+i);
i=i+1;
gyroy3=D(:,1+i);
i=i+1;
gyroz3=D(:,1+i);

i=i+1;
RPM1=D(:,1+i);

i=i+1;
RPM2=D(:,1+i);

i=i+1;
RPM3=D(:,1+i);

i=i+1;
RPM4=D(:,1+i);

i=i+1;
turn=D(:,1+i);

i=i+1;
accDC1=D(:,1+i);
i=i+1;
accDC2=D(:,1+i);
i=i+1;
lacct=D(:,1+i);
i=i+1;
lng=D(:,1+i);
i=i+1;
flow=D(:,1+i);
i=i+1;
sp=D(:,1+i);

close 

%%
i=1;
IMU1.accxt=[t,D(:,1+i)]; % Unfiltered
i=i+1;
IMU1.accyt=[t,D(:,1+i)]; % Unfiltered
i=i+1;
IMU1.acczt=[t,D(:,1+i)]; % Unfiltered
i=i+1;
IMU1.gyroxt=[t,D(:,1+i)];
i=i+1;
IMU1.gyroyt=[t,D(:,1+i)];
i=i+1;
IMU1.gyrozt=[t,D(:,1+i)];
i=i+1;
IMU2.accxt=[t,D(:,1+i)];
i=i+1;
IMU2.accyt=[t,D(:,1+i)];
i=i+1;
IMU2.acczt=[t,D(:,1+i)];
i=i+1;
IMU2.gyroxt=[t,D(:,1+i)];
i=i+1;
IMU2.gyroyt=[t,D(:,1+i)];
i=i+1;
IMU2.gyrozt=[t,D(:,1+i)];
i=i+1;
IMU3.accxt=[t,D(:,1+i)];
i=i+1;
IMU3.accyt=[t,D(:,1+i)];
i=i+1;
IMU3.acczt=[t,D(:,1+i)];
i=i+1;
IMU3.gyroxt=[t,D(:,1+i)];
i=i+1;
IMU3.gyroyt=[t,D(:,1+i)];
i=i+1;
IMU3.gyrozt=[t,D(:,1+i)];

i=i+1;
omega.w1t=[t,D(:,1+i)];

i=i+1;
omega.w2t=[t,D(:,1+i)];

i=i+1;
omega.w3t=[t,D(:,1+i)];

i=i+1;
omega.w4t=[t,D(:,1+i)];

i=i+1;
turnt=[t,D(:,1+i)-D(1,1+i)]; % Steering wheel angle

i=i+1;
accDC1t=[t,D(:,1+i)];
i=i+1;
aDC2t=[t,D(:,1+i)];
i=i+1;
lat=[t,D(:,1+i)];
i=i+1;
lngt=[t,D(:,1+i)];
i=i+1;
flowt=[t,D(:,1+i)];
i=i+1;
GPS.vt=[t,D(:,1+i)-D(1,1+i)];

out = sim('VELO1.slx');
clear t
t=out.V_W.time;
D=[out.V_W.time,out.Turn.data,out.acc.data,out.gyro.data,out.RPW.data,...
    out.V_W.data,out.V_Wp.data,out.lambda.data,out.grade.data(:)];
Fx = out.Fx.data;
Fzf = out.Fzf.data;
% plot(out.V_W.time,out.acc.data)
figure 
plot(out.V_W.time,out.acc.data(:,1))
[tp ,xp]=ginput(2);
ls=find(floor(t*10)==floor(10*tp(1)));
le=find(floor(t*10)==floor(10*tp(2)));

D=D(ls(1):le(1),:);

Fx = Fx(ls(1):le(1));
Fzf = Fzf(ls(1):le(1));
LL = out.lambda.data;
LL = LL(ls(1):le(1));

Mu = max(abs(Fx))./max(abs(Fzf))

t=t(ls(1):le(1))-t(ls(1));
j=1;
D(:,j)=D(:,j)-D(1,j);
j=2;
D(:,j)=D(:,j)-D(1,j);
j=3;
% D(:,j)=D(:,j)-D(1,j);
% j=4;
% D(:,j)=D(:,j)-D(1,j);
% j=6;
% D(:,j)=D(:,j)-D(1,j);
j=7;
D(:,j)=D(:,j)-D(1,j);
j=8;
D(:,j)=D(:,j)-D(1,j);
j=9;
D(:,j)=D(:,j)-D(1,j);
j=10;
D(:,j)=D(:,j)-D(1,j);
j=11;
D(:,j)=D(:,j)-D(1,j);


%%
% figure
% plot(D(:,1),D(:,21))

label1=[{'Time (sec)'},{'Steering Agle (deg)'},{'Acc x (m/gs2)'},{'Acc y (m/gs2)'},{'Acc z (m/gs2)'},...
    {'gyro x (rad/s)'},{'gyro y(rad/s)'},{'gyro z(rad/s)'}...
   {'roll (rad)'},{'pitch (rad)'},{'yaw (rad)'}...
    {'wheel speed FL (km/h)'},{'wheel speed FR (km/h)'},{'wheel speed RL (km/h)'},{'wheel speed RR (km/h)'}...
     {'wheel speedp FL (km/h)'},{'wheel speedp FR (km/h)'},{'wheel speedp RL (km/h)'},{'wheel speedp RR (km/h)'}...
    ,{'Slip ratio (%)'},{'Road grade (%)'}];



Data=D;
Datac=num2cell(Data);
Label=label1;
% xlswrite([NAME,'_',num2str(ls(1)),'_',num2str(le(1)),'.xls'],[Label;Datac])
set(0, 'DefaultAxesFontSize',12)
set(0,'DefaultAxesFontWeight','normal');
set(0,'DefaultAxesFontName','times new roman')
set(0, 'DefaultLineLineWidth', 2);

figure
plot(D(:,1),D(:,3),'r')
hold on 
plot(D(:,1),D(:,4),'g')
hold on 
% plot(D(:,1),0.98*D(:,5)-1,'b')
plot(D(:,1),D(:,5)-1,'b')
legend('Longitudinal','Lateral','Vertical')
grid on
xlabel('Time (sec)')
ylabel('Acceleration (g)')

figure
plot(D(:,1),D(:,3),'r')
hold on 
plot(D(:,1),D(:,4),'g')
hold on 
plot(D(:,1),D(:,5),'b')
% plot(D(:,1),0.9*D(:,5),'b')
legend('Longitudinal','Lateral','Vertical')
% ylim([-0.1 1.1])
grid on
xlabel('Time (sec)')
ylabel('Acceleration (g)')
% saveas(gcf,[NAME,'_ acc_',num2str(ls(1)),'_',num2str(le(1)),'.fig'])

figure;
subplot(3,1,1)
plot(D(:,1),D(:,3),'r')
subplot(3,1,[2 3])
plot(t,Fx,'b-');
hold on
plot(t,Fzf,'r-');
legend('F_x','F_{zf}')
