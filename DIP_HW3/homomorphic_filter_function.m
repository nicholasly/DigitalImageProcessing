% ¶ÔÊýÆµÓòÂË²¨Æ÷
function  H = homomorphic_filter_function(u, v, P, Q, gammaH, gammaL, C, D0)
    D = ((u - P / 2)^2 + (v - Q / 2)^2)^(1/2);
    H =  (gammaH - gammaL) * (1 - exp(-C * ((D ^ 2)/(D0 ^ 2)))) + gammaL;