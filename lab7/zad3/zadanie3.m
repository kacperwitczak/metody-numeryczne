function [integration_error, Nt, ft_5, integral_1000] = zadanie3()
    % Numeryczne całkowanie metodą prostokątów.
    % Nt - wektor zawierający liczby podprzedziałów całkowania
    % integration_error - integration_error(1,i) zawiera błąd całkowania wyznaczony
    %   dla liczby podprzedziałów równej Nt(i). Zakładając, że obliczona wartość całki
    %   dla Nt(i) liczby podprzedziałów całkowania wyniosła integration_result,
    %   to integration_error(1,i) = abs(integration_result - reference_value),
    %   gdzie reference_value jest wartością referencyjną całki.
    % ft_5 - gęstość funkcji prawdopodobieństwa dla n=5
    % integral_1000 - całka od 0 do 5 funkcji gęstości prawdopodobieństwa
    %   dla 1000 podprzedziałów całkowania

    reference_value = 0.0473612919396179; % wartość referencyjna całki

    Nt = 5:50:10^4;
    integration_error = [];

    for i=1:length(Nt)
        N = Nt(i);
        integration_result = integral_simpson(@f, N, 0, 5);
        integration_error(i) = abs(integration_result-reference_value);
    end

    ft_5 = f(5);
    integral_1000 = integral_simpson(@f, 1000, 0, 5);
    
    figure;
    loglog(Nt,integration_error);
    title("simpson integral");
    xlabel("Nt");
    ylabel("error");
    legend;

    print -dpng 'zadanie3.png';


end

function r = integral_simpson(func, N, a, b)
    r = 0;
    x = linspace(a, b, N+1);
    for i=1:N
        r = r + (func(x(i))+4*func((x(i)+x(i+1))/2)+func(x(i+1)));
    end
    dx = (b-a)/N;
    r = r * dx/6;
end

function y = f(t)
    stddev = 3;
    u = 10;
    y = 1/(stddev * sqrt(2*pi)) * exp(-(t-u)^2/(2*stddev^2));
end