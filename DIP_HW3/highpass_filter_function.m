function H = highpass_filter_function(u, v, P, Q, D0)
    D = ((u - P / 2)^2 + (v - Q / 2)^2)^(1/2);
    H = 1 / (1 + (D0 / D)^2);