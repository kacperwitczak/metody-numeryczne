load("filtr_dielektryczny.mat")
[err_norms_gs, time_gs, iterations_gs] = solve_Gauss_Seidel(A, b);
[err_norms_jacobi, time_jacobi, iterations_jacobi] = solve_Jacobi(A, b);
[time_direct, err_direct] = solve_direct(A, b);
time_gs
time_jacobi
time_direct
iterations_jacobi
iterations_gs
err_direct
min(err_norms_jacobi)
max(err_norms_jacobi)
min(err_norms_gs)
max(err_norms_gs)

plot_error_norms(err_norms_jacobi,err_norms_gs,iterations_jacobi,iterations_gs);