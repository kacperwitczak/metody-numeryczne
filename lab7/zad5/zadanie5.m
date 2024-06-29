function [lake_volume, x, y, z, zmin] = zadanie5()
    % Funkcja zadanie5 wyznacza objętość jeziora metodą Monte Carlo.
    %
    %   lake_volume - objętość jeziora wyznaczona metodą Monte Carlo
    %
    %   x - wektor wierszowy, który zawiera współrzędne x wszystkich punktów
    %       wylosowanych w tej funkcji w celu wyznaczenia obliczanej całki.
    %
    %   y - wektor wierszowy, który zawiera współrzędne y wszystkich punktów
    %       wylosowanych w tej funkcji w celu wyznaczenia obliczanej całki.
    %
    %   z - wektor wierszowy, który zawiera współrzędne z wszystkich punktów
    %       wylosowanych w tej funkcji w celu wyznaczenia obliczanej całki.
    %
    %   zmin - minimalna dopuszczalna wartość współrzędnej z losowanych punktów
    N = 1e6;
    zmin = -45;
    x_range = 100;
    y_range = 100;
    x = x_range*rand(1,N); % [m]
    y = y_range*rand(1,N); % [m]
    z = zmin*rand(1,N);
    
    V = abs(x_range*y_range*zmin);

    N1=0;
    for i=1:N
        if z(i) >= get_lake_depth(x(i),y(i))
            N1 = N1+1;
        end
    end

    lake_volume = (N1/N)*V;

end