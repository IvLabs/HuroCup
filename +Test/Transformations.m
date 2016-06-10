% Last Edited 13th April,2016.
% Editor: Sapan Agrawal.
% Gives transformation matrix for moving from i-1 to i frame.
% Finds the instanteneous location of COM of links.
% Takes inputs: DH parameters & Reference frame 
% Output is a 3D Matrix of dim 4x1x6 for 6 DOF Legs. 

function [Mass_L, Mass_R, Trans_Left, Trans_Right,C] = Transformations(angle)
t1l = 0;                                                     % left Hip Yaw
t2l = angle(1);                                       % left Hip Roll
t3l = angle(2);                                       % left Hip Pitch 
t4l = angle(3);                                       % Left Knee pitch
t5l = angle(4);                                       % Left ankle pitch
t6l = angle(5);                                       % Left ankle Roll
t1r = 0;                                                     % Right Hip Yaw
t2r = angle(6);                                       % Right Hip Yaw
t3r = angle(7);                                       % Right Hip Yaw
t4r = angle(8);                                       % Right Knee Pitch
t5r = angle(9);                                       % Right ankle pitch
t6r = angle(10);                                      % Right Ankle roll

DH_left_leg = xlsread('DH_parameters_COM','C5:E11');  
DH_right_leg = xlsread('DH_parameters_COM','C15:E21');

%% Import DH Parameters and World Ref
World_R = [[1,0,0,-3.5];[0,1,0,-36.55];[0,0,1,-154.4];[0,0,0,1]];          % Frame of Reference at Neck
ar = DH_right_leg(:,1);                                                    % alpha
Ar = DH_right_leg(:,2);                                                    % distance bet Z axes
dr = DH_right_leg(:,3);                                                    % distance bet X axes
th_r = [-pi/2,t1r,(pi/2)+t2r,t3r,t4r,t5r,t6r]'; 
%th_r = [-pi/2,0,(pi/2)+0,0,0,0,0]';

%% Transformation Matrix
Trans_R1 = [cos(th_r),-sin(th_r),zeros(7,1),Ar];
Trans_R2 = [sin(th_r).*cos(ar),cos(th_r).*cos(ar),-sin(ar),-sin(ar).*dr];
Trans_R3 = [sin(th_r).*sin(ar),cos(th_r).*sin(ar),cos(ar),cos(ar).*dr];
Trans_R4 = [zeros(7,1),zeros(7,1),zeros(7,1),ones(7,1)];

TR= [Trans_R1,Trans_R2,Trans_R3,Trans_R4];
for i=1:1:7
    tr(:,:,i)=[TR(i,1:4);TR(i,5:8);TR(i,9:12);TR(i,13:16)];                
end

%% Multilpying by Tranformation Matrix to move from one ref to another
Trans_Right(:,:,1) = World_R*tr(:,:,1);
Trans_Right(:,:,1) = Trans_Right(:,:,1)*tr(:,:,2);
for i=2:6
   Trans_Right(:,:,i) = Trans_Right(:,:,i-1)*tr(:,:,i+1);
end

%% Multiplying by COM wrt Local Frame to get wrt World Frame. 
Mass_trans_R = xlsread('DH_parameters_COM.xlsx','C34:F39');
Mass_trans_R = Mass_trans_R';
for i=1:1:6
    Mass_R(:,:,i)=Trans_Right(:,:,i)*Mass_trans_R(:,i);
end

%% Import DH Parameters and World Ref
World_L = [[1,0,0,-3.5];[0,1,0,36.55];[0,0,1,-154.4];[0,0,0,1]];
al = DH_left_leg(:,1);
Ar = DH_left_leg(:,2);
dr = DH_left_leg(:,3);
th_l =[-pi/2,t1l,(pi/2)+t2l,t3l,t4l,t5l,t6l]'; 
%th_l =[-pi/2,0,(pi/2)+0,0,0,0,0]';

%% Transformation Matrix
Trans_L1 = [cos(th_l),-sin(th_l),zeros(7,1),Ar];
Trans_L2 = [sin(th_l).*cos(al),cos(th_l).*cos(al),-sin(al),-sin(al).*dr];
Trans_L3 = [sin(th_l).*sin(al),cos(th_l).*sin(al),cos(al),cos(al).*dr];
Trans_L4 = [zeros(7,1),zeros(7,1),zeros(7,1),ones(7,1)];

TL= [Trans_L1,Trans_L2,Trans_L3,Trans_L4];
for i=1:1:7
    tl(:,:,i)=[TL(i,1:4);TL(i,5:8);TL(i,9:12);TL(i,13:16)];
end

%% Multilpying by Tranformation Matrix to move from one ref to another
Trans_Left(:,:,1) = World_L*tl(:,:,1);
Trans_Left(:,:,1) = Trans_Left(:,:,1)*tl(:,:,2);
for i=2:6
   Trans_Left(:,:,i) = Trans_Left(:,:,i-1)*tl(:,:,i+1);
end

%% Multiplying by  COM wrt Local Frame to get  wrt World Frame.
Mass_trans_L = xlsread('DH_parameters_COM.xlsx','C34:F39');
Mass_trans_L = Mass_trans_L';
for i=1:1:6
    Mass_L(:,:,i)=Trans_Left(:,:,i)*Mass_trans_L(:,i);
end
f = [31.5,-34.4,-1.5,1]';
C = Trans_Left(:,:,6)*f;
end