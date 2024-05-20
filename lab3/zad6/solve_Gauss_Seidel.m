function [err_norms,time,iterations] = solve_Gauss_Seidel(A, b)
[n, m] = size(A);
x = ones(n,1);

L = tril(A,-1);
U = triu(A,1);
D = diag(diag(A));

M = -(D+L)\U;
bm = (D+L)\b;


iterations = 1;
err_norms(iterations) = norm(A*x-b);
tic;
while err_norms(iterations) >= 1e-12 && iterations < 1000
    x = M*x + bm;
    iterations = iterations+1;
    err_norms(iterations) = norm(A*x-b);
end


time = toc;
end
