global u_0 p_0 alpha x t_end limitor N x_bound

u_0 = 1;
p_0 = 1;
alpha = 0.1;
N = 300;
t_end = 1;
limitor = @vanLeer;
x_bound = [-1, 1];
x = linspace(x_bound(1), x_bound(2), N);
    
%twolane_firstorder(1);
%twolane_vanLeer(2);
%twolane_cfl(3);
%twolane_tv(4);
%twolane_errors(5);

%nlane_1(6);
%nlane_1_cfl(7);
%nlane_1_tv(8);
%nlane_1_errors(9);

%nlane_2(10);