function plot_circles(a, circles, index_number)
[rows, cols] = size(circles)
for i= 1:cols
    axis([0 a 0 a]);
    axis equal
    hold on
    plot_circle(circles(1,i), circles(2, i), circles(3, i));
    hold off
    pause(0.1)
end
end
