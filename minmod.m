function phi = minmod ( r )
    phi = r;
    phi(r <= 0) = 0;
    phi(r >= 1) = 1;
    phi(~isfinite(r)) = 0;
end

