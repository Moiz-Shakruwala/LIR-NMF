clear

T = importdata('u.data');
user_id = T(:, 1);
movie_id = T(:, 2);
rating = T(:, 3);

A = zeros(943, 1682);
W = zeros(943, 1682);

for i=1:100000
    A(user_id(i), movie_id(i)) = rating(i);
    W(user_id(i), movie_id(i)) = 1;
end

A = A/5;
k = 20;

[U,V]=wnmf(A,W,k);
X = U*V;
err1 = (sumabs((X-A).*W)/sumabs(W));
disp(err1);

function[U,V]=wnmf(A,W,k)
    [n,m]= size(W);
    U = rand(n,k);
    V = rand(k,m);
    for it=1:500
        U = U.*(((W.*A)*(V'))./((W.*(U*V))*(V')));
        V = V.*(((U')*(W.*A))./((U')*(W.*(U*V))));
        Unorms = vecnorm(U);
        U = normc(U);
        for i=1:k
            V(i,:)= V(i,:)*Unorms(i);
        end
    end
end