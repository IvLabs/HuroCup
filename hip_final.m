l1=93;
l2=93;
l3=33.5;
com_height=238;
hip_height=213.5;
time_period=0.9782;
half_time=time_period/2;
theta=(98.93):(81.07-98.93)/100:81.07;
t=0:half_time/100:half_time;

x_hip_stance=hip_height*cosd(theta);
z_hip=hip_height*sind(theta);%same for swing and stance
plot(x_hip_stance,z_hip);
axis([-80 80 0 250]);
xlabel('x_hip_stance');
ylabel('z_hip');
title('stance hip trajectory');
x_hip1=abs(x_hip_stance);%take mod
max_hip_dist=75-2*max(x_hip_stance);
theta6max=asind(max_hip_dist/74);%maximum hip inclination
theta6=(-theta6max):(2*theta6max)/100:(theta6max);%range of hip inclination in top view
x_hip=x_hip_stance+74*sind(theta6);%hip of swing leg
figure;
plot(x_hip,z_hip);
xlabel('x_hip');
ylabel('z_hip');
title('swing hip trajectory');
hold on
axis([-80 80 0 250]);

quarter_time=time_period/4;
%time1=0:quarter_time/50:quarter_time;
 fv_theta1=8.865:-8.865/50:0;
 for n=1:1:51   
y_stance_hip1(1,n)=(z_hip(1,n)*sind(fv_theta1(1,n)))-37;
y_swing_hip1(1,n)=(z_hip(1,n)*sind(fv_theta1(1,n)))+37;
%time2=quarter_time:quarter_time/50:half_time;
 end
fv_theta2=0:8.865/50:8.865;
z_hip2=z_hip(1,52:1:101);
for n=1:1:50
    
y_stance_hip2(1,n)=(z_hip2(1,n)*sind(fv_theta2(1,n)))-37;
y_swing_hip2(1,n)=(z_hip2(1,n)*sind(fv_theta2(1,n)))+37;
end
%time=[time1,time2];
y_swing_hip=[y_swing_hip1,y_swing_hip2];
y_stance_hip=[y_stance_hip1,y_stance_hip2];
figure
plot(x_hip,y_swing_hip);
xlabel('x-axis');
ylabel('y-axis');
title('topview of COM');
hold on
plot(x_hip_stance,y_stance_hip);
hold off

