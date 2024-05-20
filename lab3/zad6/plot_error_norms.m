function plot_error_norms(err_norms_Jacobi,err_norms_Gauss_Seidel,iterations_Jacobi,iterations_Gauss_Seidel)
subplot(2,1,1);
plot(1:iterations_Jacobi, err_norms_Jacobi, 'color','red');

xlabel("iterations");
ylabel("error norm");
title("Jacobi error norms")

subplot(2,1,2);
plot(1:iterations_Gauss_Seidel, err_norms_Gauss_Seidel, 'color','red');
xlabel("iterations");
ylabel("error norm");
title("Gauss_Seidel error norms")


print -dpng zadanie6.png
end
