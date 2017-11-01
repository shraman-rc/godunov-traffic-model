function [ ] = nlane_1_tv(fig_num)
%% High Resolution Reconstruction (2-lane)
    global N t_end n_lanes x_bound
    
    n_lanes = 4;

    px0 = [init_riemann(0.25, 0.5, 1, N);
           init_riemann(0.5, 0.25, 2, N);
           init_riemann(0.25, 0.5, 3, N);
           init_riemann(0.5, 0.25, 4, N);];

    [t, p] = ode45(@dpdt_nlane, [0, t_end], px0);

    dx = (x_bound(2) - x_bound(1)) / N;
    
    % Compute CFLs
    tv = zeros(n_lanes, length(t));
    for i = 1:n_lanes
        p_i = p(:, N*(i-1) + 1 : N*i);
        for j = 1:length(t)
            tv(i, j) = sum(abs(gradient(p_i(j, :),dx))*dx);
        end
    end
    
    tv(1,:) = fliplr(tv(1,:));
    
    figure(fig_num); 
    plot(t, tv);
    title('Total Variation over Time', ...
        'Interpreter', 'latex', 'FontSize', 14);
    xlabel('t', 'FontSize', 14);
    ylabel('TV', 'FontSize', 14);
    legend('i=1', 'i=2', 'i=3', 'i=4');
    saveas(gcf,'plots/nlane_1_tv.png');

end

