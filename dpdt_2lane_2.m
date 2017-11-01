function dpdt = dpdt_2lane_2( ~,  p_bar_12 )
    global alpha
    p_bar_1 = p_bar_12(1:length(p_bar_12)/2);
    p_bar_2 = p_bar_12(length(p_bar_12)/2 + 1:end);
    
    % Compute source terms
    s_1 = alpha .* (p_bar_2 - p_bar_1);
    s_2 = alpha .* (p_bar_1 - p_bar_2);
    
    % Derive and combine
    dpdt = [dpdt_i(p_bar_1, s_1); dpdt_i(p_bar_2, s_2)];
end

function out = dpdt_i( p, s )
    global x_bound limitor
    dx = (x_bound(2) - x_bound(1)) / length(p);

    % Reconstruct near-interface solution values
    %   Note: These Dirichlet B.C.'s are derived from the
    %         Neumann B.C.'s which we explicitly enforce below
    p_i_minus_one = [p(1); p(1:end-1)];
    p_i_plus_one = [p(2:end); p(end)];
    p_i_plus_two = [p_i_plus_one(2:end); p(end)];
    r_L = (p_i_plus_one - p) ./ (p - p_i_minus_one);
    r_R = (p - p_i_plus_one) ./ (p_i_plus_one - p_i_plus_two);
    phi_L = limitor(r_L);
    phi_R = limitor(r_R);
    p_interface_L = p + 0.5 .* (p - p_i_minus_one) .* phi_L;
    p_interface_R = p_i_plus_one - 0.5 .* (p_i_plus_two - p_i_plus_one) .* phi_R;
    
    % Compute Godunov flux interpolation
    f_interface = godunov(p_interface_L, p_interface_R);
    f_interface = [f_interface(1); f_interface]; % only need left side since
                                                 % p_interface_L/R takes
                                                 % care of right side
    
    out = (f_interface(1:end-1) - f_interface(2:end)) ./ dx + s;
end