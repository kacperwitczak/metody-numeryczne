a = 1;
b = 50;
ytolerance = 1e-12;
max_iterations = 100;
[omega_bisection, y_bisection, iterations_bisection, xtab_bisection, xdif_bisection] = bisection_method(a,b,max_iterations, ytolerance, @(omega)impedance_magnitude(omega));
[omega_secant, y_secant, iterations_secant, xtab_secant, xdif_secant] = secant_method(a,b,max_iterations, ytolerance, @(omega)impedance_magnitude(omega));

figure;

subplot(2,1,1);
plot(1:size(xtab_bisection,1), xtab_bisection);
hold on;
plot(1:size(xtab_secant,1), xtab_secant);
xlabel('iteracja');
ylabel('x');
title('przyblizenie w kolejnych iteracjach');
legend('bisekcja', 'sieczne');

subplot(2,1,2);
semilogy(1:size(xdif_bisection,1), xdif_bisection);
hold on;
semilogy(1:size(xdif_secant,1), xdif_secant);
xlabel('iteracje');
ylabel('roznica');
title('roznice pomiedzy przyblizeniami');
legend('bisekcja', 'sieczne');

print -dpng zadanie4.png

function [xsolution,ysolution,iterations,xtab,xdif] = bisection_method(a,b,max_iterations,ytolerance,fun)
% a - lewa granica przedziału poszukiwań miejsca zerowego
% b - prawa granica przedziału poszukiwań miejsca zerowego
% max_iterations - maksymalna liczba iteracji działania metody bisekcji
% ytolerance - wartość abs(fun(xsolution)) powinna być mniejsza niż ytolerance
% fun - nazwa funkcji, której miejsce zerowe będzie wyznaczane
%
% xsolution - obliczone miejsce zerowe
% ysolution - wartość fun(xsolution)
% iterations - liczba iteracji wykonana w celu wyznaczenia xsolution
% xtab - wektor z kolejnymi kandydatami na miejsce zerowe, począwszy od xtab(1)= (a+b)/2
% xdiff - wektor wartości bezwzględnych z różnic pomiędzy i-tym oraz (i+1)-ym elementem wektora xtab; xdiff(1) = abs(xtab(2)-xtab(1));

xsolution = [];
ysolution = [];
iterations = 0;
xtab = [];
xdif = [];

l = a;
r = b;

while iterations < max_iterations
    iterations = iterations+1;
    c = (l+r)/2;
    xtab(iterations,1) = c;
    if iterations > 1
        xdif(iterations-1,1) = abs(xtab(iterations-1,1)-xtab(iterations,1));
    end
    ysolution = fun(c);
    xsolution = c;
    if abs(ysolution) < ytolerance || abs(l-r) < 1e-12
        break
    else
        if fun(l)*fun(c) < 0
            r = c;
        else
            l = c;
        end
    end
end


end

function impedance_delta = impedance_magnitude(omega)
if omega <= 0
    error("DZIELENIE PRZEZ ZERO");
end

R = 525;
C = 7e-5;
L = 3;
M = 75; % docelowa wartość modułu impedancji


Z = 1/sqrt(1/(R^2) + ((omega*C) - 1/(omega*L))^2);


impedance_delta = Z - M;

end

function [xsolution,ysolution,iterations,xtab,xdif] = secant_method(a,b,max_iterations,ytolerance,fun)
% a - lewa granica przedziału poszukiwań miejsca zerowego (x0=a)
% b - prawa granica przedziału poszukiwań miejsca zerowego (x1=b)
% max_iterations - maksymalna liczba iteracji działania metody siecznych
% ytolerance - wartość abs(fun(xsolution)) powinna być mniejsza niż ytolerance
% fun - nazwa funkcji, której miejsce zerowe będzie wyznaczane
%
% xsolution - obliczone miejsce zerowe
% ysolution - wartość fun(xsolution)
% iterations - liczba iteracji wykonana w celu wyznaczenia xsolution
% xtab - wektor z kolejnymi kandydatami na miejsce zerowe, począwszy od x2
% xdiff - wektor wartości bezwzględnych z różnic pomiędzy i-tym oraz (i+1)-ym elementem wektora xtab; xdiff(1) = abs(xtab(2)-xtab(1));

xsolution = [];
ysolution = [];
iterations = 0;
xtab = [];
xdif = [];

l = a;
r = b;

while iterations < max_iterations
    iterations = iterations+1;
    c = r - (fun(r)*(r-l))/(fun(r)-fun(l));
    xtab(iterations,1) = c;
    if iterations > 1
        xdif(iterations-1,1) = abs(xtab(iterations-1,1)-xtab(iterations,1));
    end
    ysolution = fun(c);
    xsolution = c;
    if abs(ysolution) < ytolerance
        break
    end

    l = r;
    r = c;
end

end


