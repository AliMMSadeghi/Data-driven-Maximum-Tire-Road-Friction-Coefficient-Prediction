 function Fx=PACEJKA(Fz,R,V,gamma,mu_str,lambda,k_t)
 Fz0=8000;
%  k_t=20000;

 re=R-Fz/k_t;
 eps_V=0.1;
eps_x=eps;


g=9.81;
gama=gamma*pi/180;
Vsx=(1+lambda)*V;
omega=(V+Vsx)/re;

Vcx=max(re*omega,V);
%  k=-Vsx/(abs(Vcx));
% % pure slip
lambda_Fz0 = 1.0; % 1.0 nominal (rated) load
% lambda_mux = 1.0; % 1.0 peak friction coefficient (x)
lambda_mux=mu_str;
lambda_muy = 1.0; % 1.0 peak friction coefficient (y)
lambda_muV = 0.0; % 0.0 with slip speed decaying friction
lambda_KxKap = 1.0; % 1.0 brake slip stiffness
lambda_KyAlp = 1.0; % 1.0 cornering stiffness
lambda_Cx = 1.20; % 1.0 shape factor (x)
lambda_Cy = 1.0; % 1.0 shape factor (y)
lambda_Ex = 1.0; % 1.0 curvature factor (x)
lambda_Ey = 1.0; % 1.0 curvature factor (y)
lambda_Hx = 0.0; % 1.0 horizontal shift (x)
lambda_Hy = 0.0; % 1.0 horizontal shift (y)
lambda_Vx = 0.0; % 1.0 vertical shift (x)
lambda_Vy = 0.0; % 1.0 vertical shift (y)
lambda_KyGam = 1.0; % 1.0 camber force stiffness
lambda_KzGam = 1.0; % 1.0 camber torque stiffness
lambda_t = 1.0; % 1.0 pneumatic trail
lambda_Mr = 1.0; % 1.0 residual torque 
% combined slip
lambda_xAlp = 1.0; % 1.0 alpha influence on F_x(kappa)
lambda_yKap = 1.0; % 1.0 kappa influence on F_y(alpha)
lambda_VyKap = 1.0; % 1.0 kappa induces ply-steer F_y
lambda_s = 1.0; % 1.0 M_z moment arm of F_x
% other
lambda_Cz = 1.0;
lambda_Mx = 1.0;
lambda_My = 1.0;
lambda_MPhi = 1.0 ;

zeta1=1;
%--------------------------------------------------------------------------
% parameters for longitudinal force at pure longitudinal slip
%--------------------------------------------------------------------------
% shape factor
p_Cx1 = 1.485;
% peak value
p_Dx1 = 0.8210;
p_Dx2 = -0.37;
% curvature factors 




p_Ex1 = 0.344;
p_Ex2 = 0.095;
p_Ex3 = -0.020;
p_Ex4 = 0;
% horizontal shift
p_Hx1 = -0.002;
p_Hx2 = 0.002;
% slip stiffness
p_Kx1 = 10.51;
p_Kx2 = -30.9163;
p_Kx3 = 2.545;
% vertical shift
p_Vx1 = 0;
p_Vx2 = 0;
%--------------------------------------------------------------------------
% parameters for overturning couple
%--------------------------------------------------------------------------
q_sx1 = 0;
q_sx2 = 0;
q_sx3 = 0 ;
Vo=sqrt(g*R);% unloaded radius
Fz_prime_0=lambda_Fz0*Fz0;
Vs=re*omega-V;
dfz=(Fz-Fz_prime_0)/Fz_prime_0;
lambda_str_mux=(lambda_mux/(1+lambda_muV*(Vs-Vo)));
A_mu=10;
lambda_prime_mux=A_mu*lambda_str_mux/(1+(A_mu-1)* lambda_str_mux);
mux=(p_Dx1+p_Dx2*dfz)*lambda_str_mux;
Dx=mux*Fz*zeta1;%(>0)%
Cx=p_Cx1*lambda_Cx; %(>0)%
SHx=(p_Hx1+p_Hx2*dfz)*lambda_Hx;
Kx=lambda+SHx;


gama_str=sin(gama); % Camber  angle

Kxk=Fz*(p_Kx1+p_Kx2*dfz)*exp(p_Kx3*dfz)*lambda_KxKap; %(=Bx*Cx*Dx at kx=0)(=CFk)%
Bx=Kxk/(Cx*Dx+eps_x);



Ex=(p_Ex1+p_Ex2*dfz+p_Ex3*dfz^2)*(1-p_Ex4*sign(Kx))*lambda_Ex;



Svx=Fz*(p_Vx1+p_Vx2*dfz)*(abs(Vcx)/(eps_V)+abs(Vcx))*lambda_Vx*lambda_prime_mux*zeta1;

Fx=Dx*sin(Cx*atan(Bx*lambda-Ex*(Bx*lambda-atan(Bx*lambda))))+Svx;

