function [a,b]=swingleg_angles2(hip_x,hip_z,foot_x,foot_z)
syms t1
syms t2
syms t3
l1=93;
l2=93;
l3=33.5;
sol=solve((-l2*sin(t1 + t2))-(l1*sin(t1))==-foot_x+hip_x,(93*cos(t1 + t2))+(93.0*cos(t1))==-foot_z+hip_z-l3,t1,t2);
a=vpa(sol.t1);
b=vpa(sol.t2);
end
