function phi = vanLeer ( r )
    phi = (2 .* r) ./ (1 + r);
    phi(r <= 0) = 0;
    phi(~isfinite(r)) = 0;
end

