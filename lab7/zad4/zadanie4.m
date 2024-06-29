function [integration_error, Nt, ft_5, xr, yr, yrmax] = zadanie4()
    % Numeryczne całkowanie metodą Monte Carlo.
    %
    %   integration_error - wektor wierszowy. Każdy element integration_error(1,i)
    %       zawiera błąd całkowania obliczony dla liczby losowań równej Nt(1,i).
    %       Zakładając, że obliczona wartość całki dla Nt(1,i) próbek wynosi
    %       integration_result, błąd jest definiowany jako:
    %       integration_error(1,i) = abs(integration_result - reference_value),
    %       gdzie reference_value to wartość referencyjna całki.
    %
    %   Nt - wektor wierszowy zawierający liczby losowań, dla których obliczano
    %       wektor błędów całkowania integration_error.
    %
    %   ft_5 - gęstość funkcji prawdopodobieństwa dla n=5
    %
    %   [xr, yr] - tablice komórkowe zawierające informacje o wylosowanych punktach.
    %       Tablice te mają rozmiar [1, length(Nt)]. W komórkach xr{1,i} oraz yr{1,i}
    %       zawarte są współrzędne x oraz y wszystkich punktów zastosowanych
    %       do obliczenia całki przy losowaniu Nt(1,i) punktów.
    %
    %   yrmax - maksymalna dopuszczalna wartość współrzędnej y losowanych punktów
    
    reference_value = 0.0473612919396179; % wartość referencyjna całki

    ft_5 = f(5);

    Nt = 5:50:10^4;
    xr = cell(1, length(Nt));
    yr = cell(1, length(Nt));
    yrmax = ft_5;


    
    integration_error = [];
    for i=1:length(Nt)
        N = Nt(i);
        [integration_result, xri, yri] = integral_monte_carlo(@f, N, 0, 5, yrmax);
        xr{i} = xri;
        yr{i} = yri;
        integration_error(i) = abs(integration_result-reference_value);
    end

    figure;
    loglog(Nt,integration_error);
    title("monte carlo integral");
    xlabel("Nt");
    ylabel("error");
    legend;

    print -dpng 'zadanie4.png';
end

function [r, xr, yr] = integral_monte_carlo(func, N, a, b, yrmax)
    S = (b - a) * yrmax;
    xr = a + (b - a) * rand(1, N);
    yr = yrmax * rand(1, N);
    N1 = 0;
    for i=1:N
        if yr(1,i) <= func(xr(i))
            N1 = N1 + 1;
        end
    end
    r = (N1/N)*S;
end

function y = f(t)
    stddev = 3;
    u = 10;
    y = 1/(stddev * sqrt(2*pi)) * exp(-(t-u)^2/(2*stddev^2));
end