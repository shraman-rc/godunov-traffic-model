function [ ] = nlane_1_cfl(fig_num)
%% High Resolution Reconstruction (2-lane)
    global N t_end n_lanes x_bound
    
    n_lanes = 4;

    px0 = [init_riemann(0.25, 0.5, 1, N);
           init_riemann(0.5, 0.25, 2, N);
           init_riemann(0.25, 0.5, 3, N);
           init_riemann(0.5, 0.25, 4, N);];

    [t, p] = ode45(@dpdt_nlane, [0, t_end], px0);

    dx = (x_bound(2) - x_bound(1)) / N;
    dt = t(2:end) - t(1:end-1);
    
    % Compute CFLs
    cfl = zeros(n_lanes, length(t) - 1);
    for i = 1:n_lanes
        p_i = p(:, N*(i-1) + 1 : N*i);
        u_max = max(u(p_i), [], 2);
        u_max = u_max(1:end-1);
        cfl(i, :) = (u_max .* dt ./ dx)';
    end
    
    figure(fig_num); 
    plot(t(1:end-1), cfl);
    title('Evolution of CFL Number over Time', ...
        'Interpreter', 'latex', 'FontSize', 14);
    xlabel('t', 'FontSize', 14);
    ylabel('$\frac{u \Delta t}{\Delta x}$', 'Interpreter', 'latex', 'FontSize', 14);
    legend('i=1', 'i=2', 'i=3', 'i=4');
    saveas(gcf,'plots/nlane_1_cfl.png');

end

