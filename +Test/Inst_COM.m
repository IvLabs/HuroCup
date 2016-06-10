% Last Edited 13th April,2016.
% Editor: Sapan Agrawal.
% Finds the instanteneous location of COM of Swayat2.
% Takes inputs: Inst location of COM of links , Mass matrix 
% Output: COM 

function [X,Y,Z] = Inst_COM(Mass_L, Mass_R, Trans_Left, Trans_Right)                                               %importing inst COM of Links
Mass_datasheet = xlsread('Mass_datasheet','E3:H23'); 
mi = Mass_datasheet(:,1);
xi = Mass_datasheet(1:9,2);
yi = Mass_datasheet(1:9,3);
zi = Mass_datasheet(1:9,4);
M = sum(mi); 

%% Filtering co-ordinates for Left and Right Leg separately.
for k=10:1:15
    xi(k)=Mass_L(1,:,k-9);
    yi(k)=Mass_L(2,:,k-9);
    zi(k)=Mass_L(3,:,k-9);
end
for k=16:1:21
    xi(k)=Mass_R(1,:,k-15);
    yi(k)=Mass_R(2,:,k-15);
    zi(k)=Mass_R(3,:,k-15);
end

%% Finding COM 
mixi = mi.*xi;
miyi = mi.*yi;
mizi = mi.*zi;

Sum_mixi = sum(mixi);
Sum_mizi = sum(mizi);
Sum_miyi = sum(miyi);

X = Sum_mixi/M;
Y = Sum_miyi/M;
Z = Sum_mizi/M;
COM = [X Y Z];

end