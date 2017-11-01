function px0 = init_riemann( p_L, p_R, n_instances, n_pts )
    
    n_pts_single_riemann = floor(n_pts / n_instances);
    l_idxs = 1 : ceil(n_pts_single_riemann / 2);
    r_idxs = ceil(n_pts_single_riemann / 2) + 1 : n_pts_single_riemann;
    
    px0 = zeros(n_pts, 1);
    
    for i = 1:n_instances
        offset = n_pts_single_riemann * (i-1);
        px0(l_idxs + offset) = p_L;
        px0(r_idxs + offset) = p_R;
    end

    % Set remainder to p_R
    px0(n_instances * n_pts_single_riemann : end) = p_R;
end

