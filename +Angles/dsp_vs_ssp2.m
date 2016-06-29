%Taking dsp as 5% of half of step time
%In this code half time period consists of stance phase of walking cycle.
clc
clear all
close all
l1=93;
l2=93;
l3=33.5;
com_height=238;
hip_height=213.5;
T=0.9782;
step_time=T/2;
time_dsp1=0.05*step_time;
time_ssp=0.90*step_time;
time_dsp2=0.05*step_time;
pend_max_angle=8.93;

t=0:T/20:(T/2);
theta_stance1=90+(pend_max_angle*sin((pi/2)-((2*pi*t)/T)));
plot(t,theta_stance1,'g');
hold on
theta_stance2=90+pend_max_angle-(((4*pend_max_angle)/T)*t);
plot(t,theta_stance2,'r');
theta_stance=(theta_stance1+theta_stance2)/2;
plot(t,theta_stance,'b');
%% dsp1 stance leg hip trajectory angles
tdsp1=0:(time_dsp1/10):time_dsp1;
dsp1_stance_angles1=90+(pend_max_angle*sin((pi/2)-((2*pi*tdsp1)/T)));
dsp1_stance_angles2=90+pend_max_angle-(((4*pend_max_angle)/T)*tdsp1);
dsp1_stance_angles=(dsp1_stance_angles1+dsp1_stance_angles2)/2;
figure
plot(tdsp1,dsp1_stance_angles,'b');
hold on
axis([0 1 80 100]);
%% ssp stance  leg hip trajectory angles
tssp=time_dsp1:(time_ssp)/10:(time_ssp+time_dsp1);
ssp_stance_angles1=90+(pend_max_angle*sin((pi/2)-((2*pi*tssp)/T)));
ssp_stance_angles2=90+pend_max_angle-(((4*pend_max_angle)/T)*tssp);
ssp_stance_angles=(ssp_stance_angles1+ssp_stance_angles2)/2;
plot(tssp,ssp_stance_angles,'g');
axis([0 1 80 100]);
%%
%dsp2 stance leg hip trajectory angles
tdsp2=(time_ssp+time_dsp1):(time_dsp2/10):step_time;
dsp2_stance_angles1=90+(pend_max_angle*sin((pi/2)-((2*pi*tdsp2)/T)));
dsp2_stance_angles2=90+pend_max_angle-(((4*pend_max_angle)/T)*tdsp2);
dsp2_stance_angles=(dsp2_stance_angles1+dsp2_stance_angles2)/2;
plot(tdsp2,dsp2_stance_angles,'m');
hold off

%%
%code for generating the stance leg hip trajectory in dsp
x_hip_stance_dsp1=hip_height*cosd(dsp1_stance_angles);
z_hip_stance_dsp1=hip_height*sind(dsp1_stance_angles);%same for swing and stance
figure
plot(x_hip_stance_dsp1,z_hip_stance_dsp1);
xlabel('x_hip_stance');
ylabel('z_hip_stance');
title('stance hip trajectory');
hold on
%%
% code for generating the stance leg trajectory in ssp
x_hip_stance_ssp=hip_height*cosd(ssp_stance_angles);
z_hip_stance_ssp=hip_height*sind(ssp_stance_angles);
plot(x_hip_stance_ssp,z_hip_stance_ssp,'g');
%%
%code for generating the stance leg hip trajectory in dsp
x_hip_stance_dsp2=hip_height*cosd(dsp2_stance_angles);
z_hip_stance_dsp2=hip_height*sind(dsp2_stance_angles);%same for swing and stance
plot(x_hip_stance_dsp2,z_hip_stance_dsp2);
hold off
%%
% theta6 as a function of time
max_hip_dist=75-2*max(max(x_hip_stance_dsp1,x_hip_stance_ssp));
theta6max=asind(max_hip_dist/74);%maximum hip inclination
theta6_1=theta6max*sin(((2*pi*t)/T)-(pi/2));
theta6_2=-theta6max+((4*theta6max*t)/T);
theta6=(theta6_1+theta6_2)/2;
figure
title('theta6 angles');
plot(t,theta6);
hold on
plot(t,theta6_1,'r');
plot(t,theta6_2,'g');
hold off
%%
% swing leg hip trajectory angles for dsp and ssp
dsp1_theta6_1=theta6max*sin(((2*pi*tdsp1)/T)-(pi/2));
dsp1_theta6_2=-theta6max+((4*theta6max*tdsp1)/T);
dsp1_theta6=(dsp1_theta6_1+dsp1_theta6_2)/2;
figure
plot(tdsp1,dsp1_theta6,'b');
hold on
title('swing_angles_hip_traj');
ssp_theta6_1=theta6max*sin(((2*pi*tssp)/T)-(pi/2));
ssp_theta6_2=-theta6max+((4*theta6max*tssp)/T);
ssp_theta6=(ssp_theta6_1+ssp_theta6_2)/2;
plot(tssp,ssp_theta6,'g');
dsp2_theta6_1=theta6max*sin(((2*pi*tdsp2)/T)-(pi/2));
dsp2_theta6_2=-theta6max+((4*theta6max*tdsp2)/T);
dsp2_theta6=(dsp2_theta6_1+dsp2_theta6_2)/2;
plot(tdsp2,dsp2_theta6,'b');
hold off
%%
% swing leg hip trajectories for dsp and ssp phases
x_hip_swing_dsp1=x_hip_stance_dsp1+74*sind(dsp1_theta6);%hip of swing leg
z_hip_swing_dsp1=z_hip_stance_dsp1;
figure
plot(x_hip_swing_dsp1,z_hip_swing_dsp1);
hold on
x_hip_swing_ssp=x_hip_stance_ssp+74*sind(ssp_theta6);
z_hip_swing_ssp=z_hip_stance_ssp;
plot(x_hip_swing_ssp,z_hip_swing_ssp,'g');
x_hip_swing_dsp2=x_hip_stance_dsp2+74*sind(dsp2_theta6);%hip of swing leg
z_hip_swing_dsp2=z_hip_stance_dsp2;
plot(x_hip_swing_dsp2,z_hip_swing_dsp2);
axis equal
hold off
%%
