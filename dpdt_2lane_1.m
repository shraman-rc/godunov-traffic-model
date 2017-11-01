function dpdt = dpdt_2lane_1( ~,  p_bar_12 )
    global x_bound alpha
    p_bar_1 = p_bar_12(1:length(p_bar_12)/2);
    p_bar_2 = p_bar_12(length(p_bar_12)/2 + 1:end);
    N = length(p_bar_1); % num cells
    
    dx = (x_bound(2) - x_bound(1)) / N;
    
    % Compute fluxes for lane 1
    f_interface_1 = godunov(p_bar_1(1:end-1), p_bar_1(2:end));
    f_interface_1 = [f_interface_1(1); f_interface_1; f_interface_1(end)];
    
    % Compute fluxes for lane 2
    f_interface_2 = godunov(p_bar_2(1:end-1), p_bar_2(2:end));
    f_interface_2 = [f_interface_2(1); f_interface_2; f_interface_2(end)];
    
    % Compute source terms
    s_1 = alpha .* (p_bar_2 - p_bar_1);
    s_2 = alpha .* (p_bar_1 - p_bar_2);
    
    % Derive and combine
    dpdt_1 = (f_interface_1(1:end-1) - f_interface_1(2:end)) ./ dx + s_1;
    dpdt_2 = (f_interface_2(1:end-1) - f_interface_2(2:end)) ./ dx + s_2;
    
    % Combine
    dpdt = [dpdt_1; dpdt_2];
end