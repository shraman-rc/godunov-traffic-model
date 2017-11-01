function [ ] = twolane_firstorder( fig_num )
%% Simple Godunov Scheme for 2-lane
    global x N t_end

    px0 = [init_riemann(0.25, 0.5, 1, N); init_riemann(0.5, 0.25, 1, N);];

    [~, p12] = ode45(@dpdt_2lane_1, [0, t_end], px0);
    p_1 = p12(:, 1:N);
    p_2 = p12(:, N+1:end);

    numplots = 16;
    step = length(p_1) / numplots;

    figure(fig_num); 
    h1 = plot(x, p_1(1:step:end, :), 'b');
    hold on
    h2 = plot(x, p_2(1:step:end, :), 'r');
    hold on;
    title('Evolution of $\rho_1$ and $\rho_2$ (First-Order Scheme)', ...
        'Interpreter', 'latex', 'FontSize', 14);
    xlabel('x', 'FontSize', 14);
    ylabel('\rho', 'FontSize', 14);
    legend([h1(1), h2(2)], {'Left Lane (i=1)', 'Right Lane (i=2)'});
    saveas(gcf,'plots/2lane_evolution.png');

end

