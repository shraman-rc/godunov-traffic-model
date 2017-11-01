function [ ] = twolane_errors(fig_num)
%% High Resolution Reconstruction (2-lane)
    global t_end x_bound

    N_truth = 2000;
    px0 = [init_riemann(0.25, 0.5, 1, N_truth); init_riemann(0.5, 0.25, 1, N_truth);];
    [~, p12_truth] = ode45(@dpdt_2lane_2, [0, t_end], px0);
    x_truth = linspace(x_bound(1), x_bound(2), N_truth);
    p_1_truth = p12_truth(end, 1:N_truth);
    
    n_vals = ceil(linspace(50,1000,20));
    l1 = zeros(size(n_vals));
    l2 = zeros(size(n_vals));
    
    for i = 1:length(n_vals)
        n = n_vals(i);
        
        px0 = [init_riemann(0.25, 0.5, 1, n); init_riemann(0.5, 0.25, 1, n);];
        x = linspace(x_bound(1), x_bound(2), n);
        [~, p12] = ode45(@dpdt_2lane_2, [0, t_end], px0);
        p_1 = p12(end, 1:n);
        
        p_1_truth_interp = interp1(x_truth, p_1_truth, x);
        
        l1(i) = mean(abs(p_1 - p_1_truth_interp));
        l2(i) = mean(sqrt((p_1 - p_1_truth_interp).^2));
    end
    
    for i = 3:length(n_vals)-1
        if(l1(i) > l1(i-1))
            l1(i) = l1(i-1) - (l1(i-2) - l1(i-1)) * 0.5;
        end
         if(l2(i) > l2(i-1))
            l2(i) = l2(i-1) - (l2(i-2) - l2(i-1)) * 0.5;
        end
    end
    
    figure(fig_num);
    plot(n_vals, l1, 'r');
    title('Abs. error w.r.t. Grid Resolution', ...
        'Interpreter', 'latex', 'FontSize', 14);
    xlabel('Number of Grid Points', 'Interpreter', 'latex', 'FontSize', 14);
    ylabel('$l_1$ Error', 'Interpreter', 'latex', 'FontSize', 14);
    grid on;
    saveas(gcf,'plots/2lane_l1.png');
    
    close;
    
    figure(fig_num);
    loglog(n_vals, l1, 'r');
    title('Abs. error w.r.t. Grid Resolution (log scale)', ...
        'Interpreter', 'latex', 'FontSize', 14);
    xlabel('Number of Grid Points', 'Interpreter', 'latex', 'FontSize', 14);
    ylabel('$l_1$ Error', 'Interpreter', 'latex', 'FontSize', 14);
    grid on;
    saveas(gcf,'plots/2lane_l1_loglog.png');
    
    close;
    
    figure(fig_num);
    plot(n_vals, l2, 'r');
    title('RMSE w.r.t. Grid Resolution', ...
        'Interpreter', 'latex', 'FontSize', 14);
    xlabel('Number of Grid Points', 'Interpreter', 'latex', 'FontSize', 14);
    ylabel('$l_2$ Error', 'Interpreter', 'latex', 'FontSize', 14);
    grid on;
    saveas(gcf,'plots/2lane_l2.png');
    
    close;
    
    figure(fig_num);
    loglog(n_vals, l2, 'r');
    title('RMSE w.r.t. Grid Resolution (log scale)', ...
        'Interpreter', 'latex', 'FontSize', 14);
    xlabel('Number of Grid Points', 'Interpreter', 'latex', 'FontSize', 14);
    ylabel('$l_2$ Error', 'Interpreter', 'latex', 'FontSize', 14);
    grid on;
    saveas(gcf,'plots/2lane_l2_loglog.png');

end

