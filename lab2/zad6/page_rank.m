function [numer_indeksu, Edges, I, B, A, b, r] = page_rank()
    N = 8;
    d = 0.85;
    numer_indeksu = 193609;
    Edges = [[1,1,2,2,2,3,3,3,4,4,5,5,6,6,7,8,7], 
        [4,6,3,4,5,5,6,7,5,6,4,6,4,7,6,1,8]];
    I = speye(N);
    B = sparse(Edges(2,:), Edges(1,:), 1,N,N);
    A = spdiags(ones(1,N)./sum(B).',0,N,N)
    b = (1-d)/N * ones(N, 1);
    M = I - d*B*A;
    r = M \ b;
end