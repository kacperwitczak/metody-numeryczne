function [nodes_Chebyshev, V, V2, original_Runge, interpolated_Runge, interpolated_Runge_Chebyshev] = zadanie2()
% nodes_Chebyshev - wektor wierszowy zawierający N=16 węzłów Czebyszewa drugiego rodzaju
% V - macierz Vandermonde obliczona dla 16 węzłów interpolacji rozmieszczonych równomiernie w przedziale [-1,1]
% V2 - macierz Vandermonde obliczona dla węzłów interpolacji zdefiniowanych w wektorze nodes_Chebyshev
% original_Runge - wektor wierszowy zawierający wartości funkcji Runge dla wektora x_fine=linspace(-1, 1, 1000)
% interpolated_Runge - wektor wierszowy wartości funkcji interpolującej określonej dla równomiernie rozmieszczonych węzłów interpolacji
% interpolated_Runge_Chebyshev - wektor wierszowy wartości funkcji interpolującej wyznaczonej
%       przy zastosowaniu 16 węzłów Czebyszewa zawartych w nodes_Chebyshev 
    N = 16;
    x_fine = linspace(-1, 1, 1000);
    nodes_Chebyshev = get_Chebyshev_nodes(N);

    V = vandermonde_matrix(N);
    V2 = vandermonde2_matrix(nodes_Chebyshev);
    x_coarse = linspace(-1,1,N);
    y_coarse = runge(x_coarse)';
    y_coarse_Chebyshev = runge(nodes_Chebyshev)';
    original_Runge = runge(x_fine);
    c_runge = V \ y_coarse;
    interpolated_Runge = polyval(flipud(c_runge), x_fine);
    c_runge_Chebyshev = V2 \ y_coarse_Chebyshev;
    interpolated_Runge_Chebyshev = polyval(flipud(c_runge_Chebyshev), x_fine);
    subplot(2,1,1)
    plot(x_fine, original_Runge,'DisplayName', 'Oryginalne Runge');
    hold on
    plot(x_fine, interpolated_Runge,'DisplayName', 'Interpolacja Runge');
    plot(x_coarse, y_coarse, 'o','DisplayName', 'Węzły');
    title('Interpolacja z rokładem równomiernym węzłów');
    xlabel('x');
    ylabel('y');
    legend('Location', 'Best');
    hold off


    subplot(2,1,2)
    plot(x_fine, original_Runge,'DisplayName', 'Oryginalne Runge');
    hold on
    plot(x_fine, interpolated_Runge_Chebyshev,'DisplayName', 'Interpolacja Runge Chebyshev');
    plot(nodes_Chebyshev, y_coarse_Chebyshev, 'o','DisplayName', 'Węzły Chebyshev');
    title('Interpolacja z rokładem Chebyshev drugiego stopnia');
    xlabel('x');
    ylabel('y');
    legend('Location', 'Best');

    print -dpng zadanie2.png
    hold off

end

function V = vandermonde_matrix(N)
    % Generuje macierz Vandermonde dla N równomiernie rozmieszczonych w przedziale [-1, 1] węzłów interpolacji
    x_coarse = linspace(-1,1,N);
    V = zeros(N, N);
    for i = 1:N
        for j = 1:N
            V(i,j) = x_coarse(i).^(j-1);
        end
    end
end

function V = vandermonde2_matrix(nodes)
    [~,N] = size(nodes);
    V = zeros(N, N);
    for i = 1:N
        for j = 1:N
            V(i,j) = nodes(i).^(j-1);
        end
    end
end

function nodes = get_Chebyshev_nodes(N)
    % oblicza N węzłów Czebyszewa drugiego rodzaju
    nodes = zeros(1,N);
    for i = 1:N
        nodes(i) = cos((i-1)*pi/(N-1));
    end
end

function y = runge(x)
    y = 1 ./ (1 + 25 * (x.^2));
end