
function Mu = MuEstimation(Ax,Vx)

g = 9.81;
Lf = 0.95;
Lr = 1.53;
L = Lf + Lr;
h = 0.36; % CG height
ha = 0.62;
m=1275; % kg

Da = 0.3556; % Aerodynamics overall coefficient
fR = 0.01; % Rolling resistance coefficient
Fr = fR*m*g;

% Longitudinal Braking Force
Fx = (m*abs(Ax) - abs(Fr) - abs(Da*Vx^2)); % When braking, both front and rear axles are engaged

% Tire Normal Force
Fzf = (m*g*Lr - m*Ax*h - ha*Da*Vx^2)/L; % Front Tire
% Fzr = (m*g*Lf + m*Ax*h + ha*Da*Vx^2)/L;
Mu = Fx/Fzf;

end