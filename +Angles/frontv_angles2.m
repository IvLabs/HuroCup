%%
%put values od dsp ssp dsp phase
lh=37;
l=240/1000;%mm to meter
g=9.8;
T=2*pi*sqrt(l/g);
leq=240;
thetamax=asind(lh/leq);
step_time=T/2;
tdsp1=0.05*step_time;%dsp1
tssp=0.90*step_time;%swing time
tdsp2=0.05*step_time;%dsp2
%% lateral angles for dsp1 phase of stance leg

t1=0:tdsp1/10:tdsp1;%dsp1 tp start of swing
theta_traj1=0*t1;
plot(t1,theta_traj1);
hold on;
%%
%lateral angles for ssp phase of stance leg

t2=tdsp1:tssp/10:tssp+tdsp1;%start of swing to end of swing 
theta_traj2=thetamax*sin(((t2-tdsp1)/(tssp))*pi)*(pi/180);
plot(t2,theta_traj2,'g');
hold on;
%%
%lateral angles for dsp2 phase of stance leg
t3=tdsp1+tssp:tdsp2/10:tdsp1+tssp+tdsp2;%dsp2
theta_traj3=0*t3;
plot(t3,theta_traj3);
hold on;
%plot(t,theta_traj);
%grid on;
%xlabel('time');
%ylabel('angles(degree)');
%t=0:T;
u=[t1' theta_traj1';t2' theta_traj2';t3' theta_traj3'];
t=u(:,1);
theta=u(:,2);
[t theta];
