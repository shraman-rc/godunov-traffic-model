function [ ] = nlane_1(fig_num)
%% High Resolution Reconstruction (2-lane)
    global x N t_end n_lanes
    
    n_lanes = 4;

    px0 = [init_riemann(0.25, 0.5, 1, N);
           init_riemann(0.5, 0.25, 2, N);
           init_riemann(0.25, 0.5, 3, N);
           init_riemann(0.5, 0.25, 4, N);];

    [~, p] = ode45(@dpdt_nlane, [0, t_end], px0);
    p_1 = p(:, 1:N);
    p_2 = p(:, N+1:2*N);
    p_3 = p(:, 2*N+1:3*N);
    p_4 = p(:, 3*N+1:4*N);

    figure(fig_num);  
    subplot(4,1,1);
    h1 = plot(x, p_1(1, :), 'b');
    title('Initial condition for multi-Riemann problem', ...
        'Interpreter', 'latex', 'FontSize', 14);
    subplot(4,1,2);
    h2 = plot(x, p_2(1, :), 'r');
    subplot(4,1,3);
    h3 = plot(x, p_3(1, :), 'g');
    subplot(4,1,4);
    h4 = plot(x, p_4(1, :), 'c');
    xlabel('x', 'FontSize', 14);

    saveas(gcf,'plots/nlane_1_initial.png');
    
    close;
    
    numplots = 16;
    step = length(p_1) / numplots;

    figure(fig_num);  
    subplot(4,1,1);
    h1 = plot(x, p_1(1:step:end, :), 'b');
    title('Evolution of $\rho_i$ for $i \in [0,4]$', ...
        'Interpreter', 'latex', 'FontSize', 14);
    subplot(4,1,2);
    h2 = plot(x, p_2(1:step:end, :), 'r');
    subplot(4,1,3);
    h3 = plot(x, p_3(1:step:end, :), 'g');
    subplot(4,1,4);
    h4 = plot(x, p_4(1:step:end, :), 'c');
    xlabel('x', 'FontSize', 14);

    saveas(gcf,'plots/nlane_1_evolution.png');

end

