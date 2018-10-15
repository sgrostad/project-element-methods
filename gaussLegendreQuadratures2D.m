function integral = gaussLegendreQuadratures2D(f, Dx, Dy, N) 
    K = 1; %What is K?
    [ksi, omega] = getQuadratures(K, N);
    integral = 0;
    for i = 1:length(ksi)
       integral = integral + f(ksi(i))*omega(i);
    end
end

function [ksi, omega] = getQuadratures(K,N)
    switch N
        case 1
            a = 1/3;
            ksi = [a, a a];
            omega = K;
        case 3
            a = 1/2;
            ksi = [a, a, 0; 0, a, a; a, 0, a];
            b = 1/3 * K;
            omega = [b, b, b];
        case 4
            a = 1/3;
            b = 1/5;
            c = 3/5;
            ksi = [a, a, a; b, b, c; c, b, b; b, c, b];
            d = -9/16 * K;
            e = 25/48 * K;
            omega = [d, e, e, e];
        case 6
            a = 1/3;
            aip = (6 + sqrt(15)) / 21;
            aim = (6 - sqrt(15)) / 21;
            ksi = [a, a, a; aip, aip, 1-2*aip; 1-2*aip, aip, aip;...
                aip, 1-2*aip, aip; aim, aim, 1-2*aim; 1-2*aim, aim, aim;...
                aim, 1-2*aim, aim];
            b = 9/40 * K;
            bp = (155 + sqrt(15)) / 1200 * K;
            bm = (155 - sqrt(15)) / 1200 * K;
            omega = [b, bp, bp, bp, bm, bm, bm];
        otherwise
            error("N = %d, is not supported",N);
    end
end