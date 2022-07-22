clear
T = readtable('jester-data-1.xls');
T = T{:,2:end};
A = T(1:3000,:)';

[n,m] = size(A);
W = ones(n,m);

for i = 1:n
    for j = 1:m
        if A(i,j)==99
            W(i,j)=0;
        end
    end
end

A = (A+10)/20;
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