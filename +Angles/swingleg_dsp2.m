% EDITOR: A Shalini
% edited on 4/15/2016
%Gives the matrix of angles named "angles_legs" angles of both stance and
%swing leg 
% angles order
%first five angles : stance leg
% Column number: angle
%            1 : hip_roll
%            2 : hip_pitch
%            3 : knee_pitch
%            4 : ankle_pitch
%            5 : ankle_roll
%second five angles : swing leg
%            6 : hip_roll
%            7 : hip_pitch
%            8 : knee_pitch
%            9 : ankle_pitch
%           10 : ankle_roll
%This code gives 11 set of angles in dsp1 phase and 11 set of angles in ssp phase
%and 11 set of angles in dsp2 phase
%%
clc
clear all
close all
dsp_vs_ssp2
frontv_angles2
step_length=150;
var_stance=1;
var_swing=1;
%%
% angles of swing leg in its dsp1 phase
x_foot_swing_dsp1=(-step_length)/2;
z_foot_swing_dsp1=30*gaussmf(x_foot_swing_dsp1,[25,0]);
for k=1:11
[a,b]=swingleg_angles2(x_hip_swing_dsp1(1,k),z_hip_swing_dsp1(1,k),x_foot_swing_dsp1,z_foot_swing_dsp1-0.3333);
swing_dsp1_angles(k,1)=a(1,1);
swing_dsp1_angles(k,2)=b(1,1);
swing_dsp1_angles(k,3)=-(swing_dsp1_angles(k,1)+swing_dsp1_angles(k,2));
swing_dsp1_angles(k,4)=a(2,1);
swing_dsp1_angles(k,5)=b(2,1);
swing_dsp1_angles(k,6)=-(swing_dsp1_angles(k,4)+swing_dsp1_angles(k,5));
end

%% plotting dsp1 phase of swing leg after applying forward kinematics
for k=1:11
p1=swing_dsp1_angles(k,4);
p2=swing_dsp1_angles(k,5);
angles_legs(var_swing,7)=p1;
angles_legs(var_swing,8)=p2;
angles_legs(var_swing,9)=-(p1+p2);
var_swing=var_swing+1;
coord_motor(k,1:2)=[0,0];
coord_motor(k,3:4)=([-93*sin(p1),93*cos(p1)]);
coord_motor(k,5:6)=([((-93*sin(p1))-(93*sin(p1+p2))),((93*cos(p1))+(93*cos(p1+p2)))]);
end
figure
for k=1:11
x=[coord_motor(k,1),coord_motor(k,3),coord_motor(k,5),coord_motor(k,5)];
y=[coord_motor(k,2),coord_motor(k,4),coord_motor(k,6),coord_motor(k,6)+33.5];
x=x_hip_swing_dsp1(1,k)-x;
y=z_hip_swing_dsp1(1,k)-y;
plot(x,y);
hold on
end
axis equal
%%
%angles of stance leg in its dsp1 phase
%x_hip_stance_dsp1
%z_hip_stance_dsp1
x_foot_stance_dsp1=0;
z_foot_stance_dsp1=0;
for k=1:11
[a,b]=swingleg_angles2(x_hip_stance_dsp1(1,k),z_hip_stance_dsp1(1,k),x_foot_stance_dsp1,z_foot_stance_dsp1);
stance_dsp1_angles(k,1)=a(1,1);
stance_dsp1_angles(k,2)=b(1,1);
stance_dsp1_angles(k,3)=-(stance_dsp1_angles(k,1)+stance_dsp1_angles(k,2));
stance_dsp1_angles(k,4)=a(2,1);
stance_dsp1_angles(k,5)=b(2,1);
stance_dsp1_angles(k,6)=-(stance_dsp1_angles(k,4)+stance_dsp1_angles(k,5));
end
%%
%plotting dsp1 phase of stance leg after applying forward kinematics
for k=1:11
p1=stance_dsp1_angles(k,1);
p2=stance_dsp1_angles(k,2);
angles_legs(var_stance,2)=p1;
angles_legs(var_stance,3)=p2;
angles_legs(var_stance,4)=-(p1+p2);
var_stance=var_stance+1;
coord_motor(k,1:2)=[0,0];
coord_motor(k,3:4)=([-93*sin(p1),93*cos(p1)]);
coord_motor(k,5:6)=([((-93*sin(p1))-(93*sin(p1+p2))),((93*cos(p1))+(93*cos(p1+p2)))]);
end
%figure
for k=1:11
x=[coord_motor(k,1),coord_motor(k,3),coord_motor(k,5),coord_motor(k,5)];
y=[coord_motor(k,2),coord_motor(k,4),coord_motor(k,6),coord_motor(k,6)+33.5];
x=x_hip_stance_dsp1(1,k)-x;
y=z_hip_stance_dsp1(1,k)-y;
plot(x,y,'g');
hold on
end
axis equal
%%
%angles for the swing leg in its ssp phase
[x_foot_swing_ssp,z_foot_swing_ssp]=gauss_func;
for k=1:11
[a,b]=swingleg_angles2(x_hip_swing_ssp(1,k),z_hip_swing_ssp(1,k),x_foot_swing_ssp(1,k),z_foot_swing_ssp(1,k));
swing_ssp_angles(k,1)=a(1,1);
swing_ssp_angles(k,2)=b(1,1);
swing_ssp_angles(k,3)=-(swing_ssp_angles(k,1)+swing_ssp_angles(k,2));
swing_ssp_angles(k,4)=a(2,1);
swing_ssp_angles(k,5)=b(2,1);
swing_ssp_angles(k,6)=-(swing_ssp_angles(k,4)+swing_ssp_angles(k,5));
end

%%
%plotting ssp phase of swing leg after applying forward kinematics

for k=1:11
    if (swing_ssp_angles(k,1)>swing_ssp_angles(k,4))
p1=swing_ssp_angles(k,1);
p2=swing_ssp_angles(k,2);
  else
p1=swing_ssp_angles(k,4);
p2=swing_ssp_angles(k,5);
    end      
angles_legs(var_swing,7)=p1;
angles_legs(var_swing,8)=p2;
angles_legs(var_swing,9)=-(p1+p2);
var_swing=var_swing+1;
coord_motor(k,1:2)=[0,0];
coord_motor(k,3:4)=([-93*sin(p1),93*cos(p1)]);
coord_motor(k,5:6)=([((-93*sin(p1))-(93*sin(p1+p2))),((93*cos(p1))+(93*cos(p1+p2)))]);
end
%figure
for k=1:11
x=[coord_motor(k,1),coord_motor(k,3),coord_motor(k,5),coord_motor(k,5)];
y=[coord_motor(k,2),coord_motor(k,4),coord_motor(k,6),coord_motor(k,6)+33.5];
x=x_hip_swing_ssp(1,k)-x;
y=z_hip_swing_ssp(1,k)-y;
plot(x,y,'c');
hold on
end
axis equal
%%
%angles of stance leg in its ssp phase
%x_hip_stance_ssp
%z_hip_stance_ssp
x_foot_stance_ssp=0;
z_foot_stance_ssp=0;
for k=1:11
[a,b]=swingleg_angles2(x_hip_stance_ssp(1,k),z_hip_stance_ssp(1,k),x_foot_stance_ssp,z_foot_stance_ssp);
stance_ssp_angles(k,1)=a(1,1);
stance_ssp_angles(k,2)=b(1,1);
stance_ssp_angles(k,3)=-(stance_ssp_angles(k,1)+stance_ssp_angles(k,2));
stance_ssp_angles(k,4)=a(2,1);
stance_ssp_angles(k,5)=b(2,1);
stance_ssp_angles(k,6)=-(stance_ssp_angles(k,4)+stance_ssp_angles(k,5));
end
%%

%plotting ssp phase of stance leg after applying forward kinematics
for k=1:11
    if stance_ssp_angles(k,4)>0
p1=stance_ssp_angles(k,4);
p2=stance_ssp_angles(k,5);
  else
p1=stance_ssp_angles(k,1);
p2=stance_ssp_angles(k,2);
    end      
angles_legs(var_stance,2)=p1;
angles_legs(var_stance,3)=p2;
angles_legs(var_stance,4)=-(p1+p2);
var_stance=var_stance+1;
coord_motor(k,1:2)=[0,0];
coord_motor(k,3:4)=([-93*sin(p1),93*cos(p1)]);
coord_motor(k,5:6)=([((-93*sin(p1))-(93*sin(p1+p2))),((93*cos(p1))+(93*cos(p1+p2)))]);
end
%figure
for k=1:11
x=[coord_motor(k,1),coord_motor(k,3),coord_motor(k,5),coord_motor(k,5)];
y=[coord_motor(k,2),coord_motor(k,4),coord_motor(k,6),coord_motor(k,6)+33.5];
x=x_hip_stance_ssp(1,k)-x;
y=z_hip_stance_ssp(1,k)-y;
plot(x,y,'m');
hold on
end
axis equal
%%
% angles of swing leg in its dsp2 phase
x_foot_swing_dsp2=(step_length)/2;
z_foot_swing_dsp2=30*gaussmf(x_foot_swing_dsp2,[25,0]);
for k=1:11
[a,b]=swingleg_angles2(x_hip_swing_dsp2(1,k),z_hip_swing_dsp2(1,k),x_foot_swing_dsp2,z_foot_swing_dsp2-0.3333);
swing_dsp2_angles(k,1)=a(1,1);
swing_dsp2_angles(k,2)=b(1,1);
swing_dsp2_angles(k,3)=-(swing_dsp2_angles(k,1)+swing_dsp2_angles(k,2));
swing_dsp2_angles(k,4)=a(2,1);
swing_dsp2_angles(k,5)=b(2,1);
swing_dsp2_angles(k,6)=-(swing_dsp2_angles(k,4)+swing_dsp2_angles(k,5));
end
%%
%plotting dsp2 phase of swing leg after applying forward kinematics
for k=1:11
p1=swing_dsp2_angles(k,1);
p2=swing_dsp2_angles(k,2);
angles_legs(var_swing,7)=p1;
angles_legs(var_swing,8)=p2;
angles_legs(var_swing,9)=-(p1+p2);
var_swing=var_swing+1;
coord_motor(k,1:2)=[0,0];
coord_motor(k,3:4)=([-93*sin(p1),93*cos(p1)]);
coord_motor(k,5:6)=([((-93*sin(p1))-(93*sin(p1+p2))),((93*cos(p1))+(93*cos(p1+p2)))]);
end
for k=1:11
x=[coord_motor(k,1),coord_motor(k,3),coord_motor(k,5),coord_motor(k,5)];
y=[coord_motor(k,2),coord_motor(k,4),coord_motor(k,6),coord_motor(k,6)+33.5];
x=x_hip_swing_dsp2(1,k)-x;
y=z_hip_swing_dsp2(1,k)-y;
plot(x,y);
hold on
end
axis equal
%%
%angles of stance leg in its dsp2 phase
x_hip_stance_dsp2
z_hip_stance_dsp2
x_foot_stance_dsp2=0;
z_foot_stance_dsp2=0;
for k=1:11
[a,b]=swingleg_angles2(x_hip_stance_dsp2(1,k),z_hip_stance_dsp2(1,k),x_foot_stance_dsp2,z_foot_stance_dsp2);
stance_dsp2_angles(k,1)=a(1,1);
stance_dsp2_angles(k,2)=b(1,1);
stance_dsp2_angles(k,3)=-(stance_dsp2_angles(k,1)+stance_dsp2_angles(k,2));
stance_dsp2_angles(k,4)=a(2,1);
stance_dsp2_angles(k,5)=b(2,1);
stance_dsp2_angles(k,6)=-(stance_dsp2_angles(k,4)+stance_dsp2_angles(k,5));
end
%%
%plotting dsp2 phase of stance leg after applying forward kinematics
for k=1:11
p1=stance_dsp2_angles(k,4);
p2=stance_dsp2_angles(k,5);
angles_legs(var_stance,2)=p1;
angles_legs(var_stance,3)=p2;
angles_legs(var_stance,4)=-(p1+p2);
var_stance=var_stance+1;
coord_motor(k,1:2)=[0,0];
coord_motor(k,3:4)=([-93*sin(p1),93*cos(p1)]);
coord_motor(k,5:6)=([((-93*sin(p1))-(93*sin(p1+p2))),((93*cos(p1))+(93*cos(p1+p2)))]);
end
%figure
for k=1:11
x=[coord_motor(k,1),coord_motor(k,3),coord_motor(k,5),coord_motor(k,5)];
y=[coord_motor(k,2),coord_motor(k,4),coord_motor(k,6),coord_motor(k,6)+33.5];
x=x_hip_stance_dsp2(1,k)-x;
y=z_hip_stance_dsp2(1,k)-y;
plot(x,y,'g');
end
hold off
axis equal
%%
%swing leg lateral angles
angles_legs(:,6)=0;  
angles_legs(:,10)=0;
%stance leg lateral angles
angles_legs(:,1)=theta;
angles_legs(:,5)=-theta;