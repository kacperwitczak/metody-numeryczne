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