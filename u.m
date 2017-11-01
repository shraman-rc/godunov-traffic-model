function out = u(p)
    global u_0 p_0
    out = u_0 .* (1 - p ./ p_0);
end
