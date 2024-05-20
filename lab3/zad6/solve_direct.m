function [time_direct,err_norm] = solve_direct(A, b)
tic;
x = A\b;
time_direct = toc;
err_norm = norm(A*x - b);
end