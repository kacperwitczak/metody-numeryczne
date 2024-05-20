function [A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Gauss_Seidel(N)
% A - macierz z równania macierzowego A * x = b
% b - wektor prawej strony równania macierzowego A * x = b
% M - macierz pomocnicza opisana w instrukcji do Laboratorium 3
% bm - wektor pomocniczy opisany w instrukcji do Laboratorium 3
% x - rozwiązanie równania macierzowego
% err_norm - norma błędu rezydualnego rozwiązania x; err_norm = norm(A*x-b)
% time - czas wyznaczenia rozwiązania x
% iterations - liczba iteracji wykonana w procesie iteracyjnym metody Jacobiego
% index_number - Twój numer indeksu
index_number = 193609;
L1 = 9;
[A, b] = generate_matrix(N, L1);
x = ones(N,1);

L = tril(A,-1);
U = triu(A,1);
D = diag(diag(A));

M = -(D+L)\U;
bm = (D+L)\b;


iterations = 0;
err_norm = norm(A*x-b);
tic;
while err_norm >= 1e-12 && iterations < 1000
    x = M*x + bm;
    iterations = iterations+1;
    err_norm = norm(A*x-b);
    disp(err_norm);
end


time = toc;
end
