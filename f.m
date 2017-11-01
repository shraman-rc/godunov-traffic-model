function out = f(p)
    global u_0 p_0
    out = u_0 .* (p - (p.^2) ./ p_0);
end
