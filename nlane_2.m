function [ ] = nlane_1(fig_num)
%% High Resolution Reconstruction (2-lane)
    global x N t_end n_lanes alpha
    
    n_lanes = 4;

    px0 = [init_riemann(0.4, 0.5, 1, N);
           init_riemann(0.2, 0.2, 2, N);
           init_riemann(0.2, 0.2, 3, N);
           init_riemann(0.5, 0.4, 4, N);];

    % Solve with small alpha
    alpha = 0.05
    [~, p] = ode45(@dpdt_nlane, [0, t_end], px0);
    p_1_small = p(:, 1:N);
    p_2_small = p(:, N+1:2*N);
    p_3_small = p(:, 2*N+1:3*N);
    p_4_small = p(:, 3*N+1:4*N);
    
     % Solve with big alpha
    alpha = 0.5
    [~, p] = ode45(@dpdt_nlane, [0, t_end], px0);
    p_1_big = p(:, 1:N);
    p_2_big = p(:, N+1:2*N);
    p_3_big = p(:, 2*N+1:3*N);
    p_4_big = p(:, 3*N+1:4*N);

    figure(fig_num);  
    subplot(4,1,1);
    h1 = plot(x, p_1_small(1, :), 'b');
    title('Initial condition for dense/sparse situation', ...
        'Interpreter', 'latex', 'FontSize', 14);
    subplot(4,1,2);
    h2 = plot(x, p_2_small(1, :), 'r');
    subplot(4,1,3);
    h3 = plot(x, p_3_small(1, :), 'g');
    subplot(4,1,4);
    h4 = plot(x, p_4_small(1, :), 'c');
    xlabel('x', 'FontSize', 14);

    saveas(gcf,'plots/nlane_2_initial.png');
    
    close;
    
    numplots = 16;
    step = length(p_1_small) / numplots;

    figure(fig_num);  
    subplot(4,1,1);
    h1 = plot(x, p_1_small(1:step:end, :), 'b');
    title('Evolution of $\rho_i$ with $\alpha = 0.05$', ...
        'Interpreter', 'latex', 'FontSize', 14);
    subplot(4,1,2);
    h2 = plot(x, p_2_small(1:step:end, :), 'r');
    subplot(4,1,3);
    h3 = plot(x, p_3_small(1:step:end, :), 'g');
    subplot(4,1,4);
    h4 = plot(x, p_4_small(1:step:end, :), 'c');
    xlabel('x', 'FontSize', 14);

    saveas(gcf,'plots/nlane_2_alpha_small.png');
    
    close;
    
    step = length(p_1_big) / numplots;
    
    figure(fig_num);  
    subplot(4,1,1);
    h1 = plot(x, p_1_big(1:step:end, :), 'b');
    title('Evolution of $\rho_i$ with $\alpha = 0.5$', ...
        'Interpreter', 'latex', 'FontSize', 14);
    subplot(4,1,2);
    h2 = plot(x, p_2_big(1:step:end, :), 'r');
    subplot(4,1,3);
    h3 = plot(x, p_3_big(1:step:end, :), 'g');
    subplot(4,1,4);
    h4 = plot(x, p_4_big(1:step:end, :), 'c');
    xlabel('x', 'FontSize', 14);

    saveas(gcf,'plots/nlane_2_alpha_big.png');
    
    % ...

end

