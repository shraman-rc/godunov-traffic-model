function [ ] = twolane_tv(fig_num)
%% High Resolution Reconstruction (2-lane)
    global x N t_end x_bound

    px0 = [init_riemann(0.25, 0.5, 1, N); init_riemann(0.5, 0.25, 1, N);];

    [t, p12] = ode45(@dpdt_2lane_2, [0, t_end], px0);
    p_1 = p12(:, 1:N);
    p_2 = p12(:, N+1:end);

    dx = (x_bound(2) - x_bound(1)) / N;
    
    % Compute TVs
    tv_1 = zeros(length(t), 1);
    for i = 1:length(t)
        tv_1(i) = sum(abs(gradient(p_1(i, :),dx))*dx);
    end
    
    tv_2 = zeros(length(t), 1);
    for i = 1:length(t)
        tv_2(i) = sum(abs(gradient(p_2(i, :),dx))*dx);
    end
    
    figure(fig_num); 
    h1 = plot(t, tv_1, 'b');
    hold on
    h2 = plot(t, tv_2, 'r');
    hold on;
    title('Total Variation over Time', ...
        'Interpreter', 'latex', 'FontSize', 14);
    xlabel('t', 'FontSize', 14);
    ylabel('TV', 'FontSize', 14);
    legend([h1, h2], {'Left Lane (i=1)', 'Right Lane (i=2)'});
    saveas(gcf,'plots/2lane_tv.png');

end

