%%% mean speed 
vS = 250/3.6;
%%% Time vector (at stations)
t1 = 45*60;
t2 = 105*60;
t3 = 144*60;
t4 = 198*60;
dt = 4*60;
tid_vect = [0 t1 t1+dt t2 t2+dt t3 t3+dt t4];
%%% Milestone vector
x1 = t1*vS;
x2 = x1+(t2-t1)*vS;
x3 = x2+(t3-t2)*vS;
x4 = x3+(t4-t3)*vS;
x_vect = [0 x1 x2 x3 x4];
lambda_vect = [1 1 1 1]*0.125;
tid_array = 0;
x_array = 0;
txm = 0;
xxm = 0;
for n=1:4
    
    tx = tid_vect(2*n);
    xx = x_vect(1+n);
    lambda = lambda_vect(n);
    
    t_a1 = linspace(txm,tx,5);
    x_a1 = linspace(xxm,xx,5);
    
    x_a1(2) = xxm + (xx-xxm)*lambda;
    x_a1(3) = xxm + (xx-xxm)*0.6;
    x_a1(4) = xx - (xx-xxm)*lambda;
    coeff = polyfit(t_a1,x_a1,4);
  
    %tid_array = horzcat(tid_array, t_a1(2:end));
    %x_array = horzcat(x_array, x_a1(2:end));
    tid_array = horzcat(tid_array, [t_a1(2:end) t_a1(end)+dt]);
    x_array = horzcat(x_array, [x_a1(2:end) x_a1(end)]);
    txm = tx(end);
    xxm = xx(end);
    
    v_n1 = diff(x_array)./diff(tid_array);
    v_n1 = [0 v_n1];   
    f_n1 = 10e3*diff(v_n1)./diff(tid_array);
    f_n1 = [0 f_n1];
    p_n1 = f_n1.*v_n1;
    
end
