%% Developer: Partha Majumder
%%
clc
clear all
close all
format long g
disp('Executing the code **********===>')

%%
%[LB,UB,D,fobj] = Get_Functions_details('Ackley_F1');  % Fg=0
% [LB,UB,D,fobj] = Get_Functions_details('Beale_F2');   % Fg=0 
% [LB,UB,D,fobj] = Get_Functions_details('Bohachevsky_F3'); % Fg=0

% [LB,UB,D,fobj] = Get_Functions_details('Booth_F4');   % Fg=0;
% [LB,UB,D,fobj] = Get_Functions_details('BUKINN6_F5'); % Fg=0  
% [LB,UB,D,fobj] = Get_Functions_details('Colville_F6'); % Fg=0;  

% [LB,UB,D,fobj] = Get_Functions_details('Cross_In_Tray_F7');  % Fg=-2.06261;
% [LB,UB,D,fobj] = Get_Functions_details('DejongN5_1_F8');  % Fg=0
% [LB,UB,D,fobj] = Get_Functions_details('Dixonprice_F9'); % Fg=0;

% [LB,UB,D,fobj] = Get_Functions_details('Drop_Wave_F10');  % Fg=-1
% [LB,UB,D,fobj] = Get_Functions_details('EASOM1_F11');   % Fg=-1;
% [LB,UB,D,fobj] = Get_Functions_details('Eggholder_F12');  % Fg=-959.6407;

% [LB,UB,D,fobj] = Get_Functions_details('GoldsteinPrice_F13');   % Fg=3;
% [LB,UB,D,fobj] = Get_Functions_details('GoldsteinPrice_Scaled_F14');  % Fg=-3;
% [LB,UB,D,fobj] = Get_Functions_details('Griewank_F15');  % Fg=0

% [LB,UB,D,fobj] = Get_Functions_details('Hartmann_3D_F16');  % Fg=-3.67597355769227
% [LB,UB,D,fobj] = Get_Functions_details('Hartmann_4D_F17');  % F(g) = -3.135474
% [LB,UB,D,fobj] = Get_Functions_details('Hartmann_6D_F18');  % Fg=-3.04245773783059

%[LB,UB,D,fobj] = Get_Functions_details('Holder_Table_F19');  % Fg=-19.2085
% [LB,UB,D,fobj] = Get_Functions_details('Langermann_F20');  % Fg=-4.05404569816266;
% [LB,UB,D,fobj] = Get_Functions_details('Levy_F21');  %Fg=0;

% [LB,UB,D,fobj] = Get_Functions_details('LevyN13_F22');  % Fg=0;
% [LB,UB,D,fobj] = Get_Functions_details('Matyas_F23'); % Fg=0
% [LB,UB,D,fobj] = Get_Functions_details('Mccormick_F24'); % Fg=-1.9133; 

% [LB,UB,D,fobj] = Get_Functions_details('Michalewicz1_F25'); % Fg=-9.66015;
% 26:Combinatorial Optimization
% 27: Combinatorial Optimization

% [LB,UB,D,fobj] = Get_Functions_details('Powell_F28'); % Fg=0 
% [LB,UB,D,fobj] = Get_Functions_details('Sum_Power_F29'); % Fg=0;
% [LB,UB,D,fobj] = Get_Functions_details('Rastrigin1_F30'); % Fg=0


% [LB,UB,D,fobj] = Get_Functions_details('Rosenbrock1_F31'); % Fg=0
% [LB,UB,D,fobj] = Get_Functions_details('Rotted_hyper_ellipsoid_F32');  %Fg=0
% [LB,UB,D,fobj] = Get_Functions_details('SchafferN2_F33'); % Fg=0

% [LB,UB,D,fobj] = Get_Functions_details('SchafferN4_F34'); % Fg=0.292579
% [LB,UB,D,fobj] = Get_Functions_details('Schwef1_F35'); % Fg=0
% 36: Combinatorial Optimization



% [LB,UB,D,fobj] = Get_Functions_details('Shubert_F37'); % Fg=-186.7309
[LB,UB,D,fobj] = Get_Functions_details('Six_Hump_Camel_F38');  % Fg=-1.031628453486
% [LB,UB,D,fobj] = Get_Functions_details('Sphere1_F39'); % Fg=0;

% [LB,UB,D,fobj] = Get_Functions_details('Styblinski_Tang_F40');  % Fg=-39.16599*D
% [LB,UB,D,fobj] = Get_Functions_details('Sum_Square_Function_F41'); % Fg=0
% [LB,UB,D,fobj] = Get_Functions_details('Three_Hump_Camel_F42');  % Fg=0;

% [LB,UB,D,fobj] = Get_Functions_details('Trid_F43'); % Fg=-50; D=6; % Fg=-200; D=10;


%%
itmax=100; % Maximum numbef of iterations
N=100;
c1=2.05;
c2=2.05;
wmax=0.9;
wmin=0.4;
w=linspace(wmax,wmin,itmax); %% Linear variation of w 

if length(LB)==1
for kk=1:1:D
    lb(1:N,kk)=LB; 
    ub(1:N,kk)=UB;
end
end

if length(LB)~=1
for kk=1:1:D
    lb(1:N,kk)=LB(kk); 
    ub(1:N,kk)=UB(kk);
    
end
end

d=(ub-lb);
q=d/4;     
for kk=1:1:D
vmin(1:N,kk)=-q(1);
vmax(1:N,kk)=q(1);
end

x=lb+(ub-lb).*rand(N,D);
v=q.*rand(N,D);
for ii=1:1:N
F(ii) = fobj(x(ii,:),D);
end

[F_g_best,ii]=min(F);
g_best=x(ii,:);
P_best=x;  %% pi=xi
Fp_best=F;
brk_pt=100;

%% Tough part: Iteration::::::


for it=1:1:itmax
   v(1:N,1:D)=(w(it).*v(1:N,1:D))+(c1*rand*(P_best(1:N,1:D)-x(1:N,1:D)))+(c2*rand*(repmat(g_best,N,1)-x(1:N,1:D)));
   for kk=1:1:D
   v(:,kk)=min(v(:,kk),vmax(:,kk));
   v(:,kk)=max(v(:,kk),vmin(:,kk));
   end
   
    
   
   x(1:N,1:D)=x(1:N,1:D)+v(1:N,1:D);
   for kk=1:1:D
   x(:,kk)=min(x(:,kk),ub(:,kk));
   x(:,kk)=max(x(:,kk),lb(:,kk));
   end
   
    
   for ii=1:1:N
   F(ii) = fobj(x(ii,:),D);
   end
   
   [minF,ii]=min(F);
   if minF<= F_g_best
   F_g_best=minF; 
   g_best=x(ii,:); %% Imp
   end
   iip=find(F<=Fp_best);
   P_best(iip,:)=x(iip,:); 
   Fp_best(iip)=F(iip);
   F_g_best_k(it)=F_g_best;
   break_pt=101;
end
display('output Using Particle Swarm Optimization');
X_Sol=g_best
F_Val=F_g_best
itk=1:1:itmax;
plot(itk,F_g_best_k)
grid on
xlabel('Generation ');
ylabel('Fitness value');
display('Program Completed'); 
break_point=1;











