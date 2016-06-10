function [x,y]=gauss_func
step_length=150;
x=-(step_length)/2:step_length/10:step_length/2;
y=30*gaussmf(x,[25,0]);
end
