% Last Edited 16th April,2016.
% Editor: Sapan Agrawal.
% Gives COM trajectory wrt Stance Foot N frame.
% Takes inputs: Angles and no. of interpolations. 
% Output: Projection of COM on surface. 

angles_legs = xlsread('Angle Matrix','A1:J43');
p=33;
X=zeros(1,p);
Y=zeros(1,p);
Z=zeros(1,p);
XC=zeros(1,p);
YC=zeros(1,p);
ZC=zeros(1,p);
angle=zeros(1,10,p);

for i=1:p
    angle(:,:,i)= angles_legs(i,:);
    [Mass_L, Mass_R, Trans_Left, Trans_Right,D] = Transformations(angle(:,:,i)); 
    [X(i), Y(i), Z(i)] = Inst_COM(Mass_L, Mass_R,Trans_Left, Trans_Right);
    XC(i)=X(i)-D(1);
    YC(i)=Y(i)-D(2);
    ZC(i)=Z(i)-D(3); 
    foot(:,:,i) = Trans_Left(:,:,6)*[0 0 0 1]'; 
    XF(i)=abs(XC(i)-X(i));
end

%% Finding Height of COM from foot
Foot_L = [33.5 10.6 -1.5 1]';       %Left Foot centre wrt Local Frame
Foot_L = Trans_Left(:,:,6)*Foot_L;

Foot_R = [33.5 -10.3 -1.5 1]';      %Right Foot centre wrt Local Frame
Foot_R = Trans_Right(:,:,6)*Foot_R;

H_L = Z - Foot_L(3);                %Height of COM from Left foot
H_R = Z - Foot_R(3);                %Height of COM from Right foot
Zc = max(H_L,H_R);                  

%%% Finding height of Hip
Hp = -154.4 - min(Foot_L(3),Foot_R(3));   

%% Calculating torque on motor
foot = Trans_Left(:,:,6)*[0 0 0 1]'; 
i=1:p;
figure;
plot(XC,YC)
figure;
plot(XC,ZC)
axis([-50 50 0 400]);