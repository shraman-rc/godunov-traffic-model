function phi = superbee ( r )
    phi = r;
    phi(r <= 0) = 0;
    phi(0 < r & r <= 0.5) = 2 .* r(0 < r & r <= 0.5);
    phi(0.5 < r & r <= 1) = 1;
    phi(2 < r) = 2;
    
    phi(~isfinite(r)) = 0;
end