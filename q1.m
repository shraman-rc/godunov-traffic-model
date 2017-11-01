%% Part 1: Simple Godunov Scheme

global u_0 p_0 x_bound
u_0 = 1;
p_0 = 1;
x_bound = [-1, 1];
N = 300;
t_end = 1;

x = linspace(x_bound(1), x_bound(2), N);

% Part 1a)
p_l = 0.25;
p_r = 0.5;
px0_a = zeros(N, 1);
px0_a(1:ceil(N/2)) = p_l;
px0_a(ceil(N/2)+1:end) = p_r;

[t_a, p_a] = ode45(@dpdt_1, [0, t_end], px0_a);

figure(1); 
plot(x, p_a(1,:));
hold on;
plot(x, p_a(end,:));
title('Numerical $\rho(x,t=\{0,1\})$ w/ $\rho_r = 0.5, \rho_l = 0.25$ (First-Order Scheme)', ...
    'Interpreter', 'latex', 'FontSize', 10);
xlabel('x', 'FontSize', 10);
ylabel('\rho', 'FontSize', 10);

% Part 1b)
p_l = 0.5;
p_r = 0.25;
px0_b = zeros(N, 1);
px0_b(1:ceil(N/2)) = p_l;
px0_b(ceil(N/2)+1:end) = p_r;

[t_b, p_b] = ode45(@dpdt_1, [0, t_end], px0_b);

figure(2);
plot(x, p_b(1,:));
hold on;
plot(x, p_b(end,:));
title('Numerical $\rho(x,t=\{0,1\})$ w/ $\rho_r = 0.25, \rho_l = 0.5$ (First-Order Scheme)', ...
    'Interpreter', 'latex', 'FontSize', 10);
xlabel('x', 'FontSize', 10);
ylabel('\rho', 'FontSize', 10);

% Characteristics
figure(3);
contourf(x, t_a, p_a, 10);
title('Characteristic plot for $\rho$ w/ $\rho_r = 0.5, \rho_l = 0.25$', ...
    'Interpreter', 'latex', 'FontSize', 10);
xlabel('x', 'FontSize', 10);
ylabel('t', 'FontSize', 10);
zlabel('\rho', 'FontSize', 10);
colorbar;

figure(4);
contourf(x, t_b, p_b, 10);
title('Characteristic plot for $\rho$ w/ $\rho_r = 0.25, \rho_l = 0.5$', ...
    'Interpreter', 'latex', 'FontSize', 10);
xlabel('x', 'FontSize', 10);
ylabel('t', 'FontSize', 10);
zlabel('\rho', 'FontSize', 10);
colorbar;

%% Part 2: High Resolution Reconstruction
global limitor

% van Leer
limitor = @vanLeer;

% vanLeer - Case 1(a)
[~, p_a_rec] = ode45(@dpdt_1, [0, t_end], px0_a);

figure(5);
plot(x, p_a_rec(1,:));
hold on;
plot(x, p_a_rec);
title('Numerical $\rho(x,t=\{0,1\})$ w/ $\rho_r = 0.5, \rho_l = 0.25$ (vanLeer Scheme)', ...
    'Interpreter', 'latex', 'FontSize', 10);
xlabel('x', 'FontSize', 10);
ylabel('\rho', 'FontSize', 10);

% vanLeer - Case (b)
[~, p_b_rec] = ode45(@dpdt_1, [0, t_end], px0_b);

figure(6); 
plot(x, p_b_rec(1,:));
hold on;
plot(x, p_b_rec);
title('Numerical $\rho(x,t=\{0,1\})$ w/ $\rho_r = 0.25, \rho_l = 0.5$ (vanLeer Scheme)', ...
    'Interpreter', 'latex', 'FontSize', 10);
xlabel('x', 'FontSize', 10);
ylabel('\rho', 'FontSize', 10);

% MinMod
limitor = @minmod;

% MinMod - Case 1(a)
[~, p_a_rec] = ode45(@dpdt_1, [0, t_end], px0_a);

figure(7);
plot(x, p_a_rec(1,:));
hold on;
plot(x, p_a_rec);
title('Numerical $\rho(x,t=\{0,1\})$ w/ $\rho_r = 0.5, \rho_l = 0.25$ (MinMod Scheme)', ...
    'Interpreter', 'latex', 'FontSize', 10);
xlabel('x', 'FontSize', 10);
ylabel('\rho', 'FontSize', 10);

% MinMod - Case (b)
[~, p_b_rec] = ode45(@dpdt_1, [0, t_end], px0_b);

figure(8); 
plot(x, p_b_rec(1,:));
hold on;
plot(x, p_b_rec);
title('Numerical $\rho(x,t=\{0,1\})$ w/ $\rho_r = 0.25, \rho_l = 0.5$ (MinMod Scheme)', ...
    'Interpreter', 'latex', 'FontSize', 10);
xlabel('x', 'FontSize', 10);
ylabel('\rho', 'FontSize', 10);