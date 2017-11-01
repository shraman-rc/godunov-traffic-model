function f_out = godunov(p_L, p_R)
    f_L = f(p_L);
    f_R = f(p_R);
    f_max = f(0.5);
    f_out = zeros(length(p_L), 1);
    
    % Case 1: p_L, p_R < 0.5:
    %   p(x) moves right, use f_L
    % Case 2: p_L <= 0.5, p_R >= 0.5:
    %   discontinuity preserved, use f_L since p(0) = p_L
    % Case 3: p_L >= 0.5, p_R <= 0.5:
    %   discontinuity disperses in opposite directions,
    %   use stationary point f_max
    % Case 4: p_L, p_R > 0.5:
    %   p(x) moves left, use f_R
    
    % Case 1 & 2
    f_out(p_L <= 0.5) = f_L(p_L <= 0.5);
    % Case 3
    f_out(p_L >= 0.5 & p_R <= 0.5) = f_max;
    % Case 4
    f_out(p_L > 0.5 & p_R > 0.5) = f_R(p_L > 0.5 & p_R > 0.5);
end