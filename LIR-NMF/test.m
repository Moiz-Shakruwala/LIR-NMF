clear

n=100;
m=3000;
k =20;

U1 = rand(n,k);
V1 = rand(k,m);
A = U1*V1;
A = A/max(A);
W = floor(rand(n,m)*2);
A1 = A.*W;

[U,V]=wnmf(A1,W,k);
X = U*V;

err = norm(X-A,'fro')/300000;
err1 = (sumabs((X-A).*W)/sumabs(W));
disp(err1);
disp(err);

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