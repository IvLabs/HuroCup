solve_my
t=(pi/2-max_ankle_pitch):0.01:(pi/2+max_ankle_pitch);
H= 186;                 %hip height from ankle
x=H*cos(t);
z=H*sin(t);
plot(x,z)
axis([-50 50 0 200]);