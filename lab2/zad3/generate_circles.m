function [circles, index_number, circle_areas] = generate_circles(a, r_max, n_max)
    index_number = 193609;
    L1 = 9;
    circles = zeros(3, n_max);
    circles_counter = 1;

    for i = 1:n_max
        x = a * rand();
        y = a * rand();
        r = r_max * rand();
        correct = false;

        while ~correct
            correct = true;
            for j = 1:circles_counter
                r_ = circles(1, j);
                x_ = circles(2, j);
                y_ = circles(3, j);
                dist = sqrt((x_ - x)^2 + (y_ - y)^2);

                if ~(dist > (r + r_) && (x + r) < a && (x - r) > 0 && (y + r) < a && (y - r) > 0)
                    correct = false;
                    break;
                end
            end

            if ~correct
                x = a * rand();
                y = a * rand();
                r = r_max * rand();
            end
        end

        circles(1, i) = r;
        circles(2, i) = x;
        circles(3, i) = y;
        circles_counter = circles_counter + 1;
    end
    
    areas = zeros(1,n_max);
    for i = 1:n_max
        areas(i) = pi*circles(1,i)^2;
    end
    circle_areas = cumsum(areas);
end
