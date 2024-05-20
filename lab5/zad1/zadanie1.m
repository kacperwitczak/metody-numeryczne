function [V, original_Runge, original_sine, interpolated_Runge, interpolated_sine] = zadanie1()
% Rozmiar tablic komórkowych (cell arrays) V, interpolated_Runge, interpolated_sine: [1,4].
% V{i} zawiera macierz Vandermonde wyznaczoną dla liczby węzłów interpolacji równej N(i)
% original_Runge - wektor wierszowy zawierający wartości funkcji Runge dla wektora x_fine=linspace(-1, 1, 1000)
% original_sine - wektor wierszowy zawierający wartości funkcji sinus dla wektora x_fine
% interpolated_Runge{i} stanowi wierszowy wektor wartości funkcji interpolującej 
%       wyznaczonej dla funkcji Runge (wielomian stopnia N(i)-1) w punktach x_fine
% interpolated_sine{i} stanowi wierszowy wektor wartości funkcji interpolującej
%       wyznaczonej dla funkcji sinus (wielomian stopnia N(i)-1) w punktach x_fine
    N = 4:4:16;
    x_fine = linspace(-1, 1, 1000);
    original_Runge = runge(x_fine);

    subplot(2,1,1);
    plot(x_fine, original_Runge);
    hold on;
    for i = 1:length(N)
        V{i} = vandermonde_matrix(N(i));% macierz Vandermonde
        x_coarse = linspace(-1,1,N(i)); % węzły interpolacji
        y_coarse = runge(x_coarse)';% wartości funkcji interpolowanej w węzłach interpolacji
        c_runge = V{i} \ y_coarse; % współczynniki wielomianu interpolującego
        interpolated_Runge{i} = polyval(flipud(c_runge), x_fine); % interpolacja
        plot (x_fine, interpolated_Runge{i}, 'DisplayName', ['N = ', num2str(N(i))])
    end
    title("runge")
    xlabel('x')
    ylabel('y')
    legend('Location','Best')

    hold off

    original_sine = sin(2 * pi * x_fine);
    subplot(2,1,2);
    plot(x_fine, original_sine);
    hold on;
    for i = 1:length(N)
        x_coarse = linspace(-1,1,N(i));
        y_coarse = sin(2*pi*x_coarse)';
        c_sine = V{i} \ y_coarse;
        interpolated_sine{i} = polyval(flipud(c_sine), x_fine);
        plot (x_fine, interpolated_sine{i}, 'DisplayName', ['N = ', num2str(N(i))])
    end
    title("sine")
    xlabel('x')
    ylabel('y')
    legend('Location','Best')
    print -dpng zadanie1.png
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

function y = runge(x)
    y = 1 ./ (1 + 25 * (x.^2));
end