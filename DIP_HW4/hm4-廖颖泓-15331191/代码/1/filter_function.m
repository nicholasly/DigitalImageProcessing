function H = filter_function(u, v, a, b, T)
    z = pi * (u * a + v * b) + eps;
    H = T ./ z .* sin(z) .* exp(-1j * z);