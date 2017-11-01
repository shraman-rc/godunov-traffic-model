function [ ] = twolane_cfl(fig_num)
%% High Resolution Reconstruction (2-lane)
    global x N t_end x_bound

    px0 = [init_riemann(0.25, 0.5, 1, N); init_riemann(0.5, 0.25, 1, N);];

    [t, p12] = ode45(@dpdt_2lane_2, [0, t_end], px0);
    p_1 = p12(:, 1:N);
    p_2 = p12(:, N+1:end);

    dx = (x_bound(2) - x_bound(1)) / N;
    dt = t(2:end) - t(1:end-1);
    
    % Compute CFLs
    u_max_1 = max(u(p_1), [], 2);
    u_max_1 = u_max_1(1:end-1);
    cfl_1 = u_max_1 .* dt ./ dx;
    
    u_max_2 = max(u(p_2), [], 2);
    u_max_2 = u_max_2(1:end-1);
    cfl_2 = u_max_2 .* dt ./ dx;
    
    figure(fig_num); 
    h1 = plot(t(1:end-1), cfl_1, 'b');
    hold on
    h2 = plot(t(1:end-1), cfl_2, 'r');
    hold on;
    title('Evolution of CFL Number over Time', ...
        'Interpreter', 'latex', 'FontSize', 14);
    xlabel('t', 'FontSize', 14);
    ylabel('$\frac{u \Delta t}{\Delta x}$', 'Interpreter', 'latex', 'FontSize', 14);
    legend([h1, h2], {'Left Lane (i=1)', 'Right Lane (i=2)'});
    saveas(gcf,'plots/2lane_cfl.png');

end

