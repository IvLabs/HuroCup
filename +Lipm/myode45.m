function dy = myode45(t,y)
L = 194.15;               % height of COM from ankle. 
dy = zeros(2,1);
dy(1) = y(2);
dy(2) = -(9.8100*1000/L)*sin(y(1));
end

