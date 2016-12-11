function beta = Ichimura_XL(X,Y,h,beta0)

[n,k]= size(X);

%%
    function value = Objfun(X,Y,beta,h)
        
        Xb = X*beta;

        Kernel = @(u) 3/4 * (1-u.^2).^2.*(abs(u)<=1); %use Epanechnikov Kernel
        G = zeros(n,1);

        for i=1:n
            dis = Xb - Xb(i);
            K = Kernel(dis/h);
            G(i) = K'* Y/sum(K);
        end
        
        Err = Y-G;
        value = (Err.')*Err;
        
    end

%set minimization options, set constrait tolerance to 1 for normalization of first coeff.
options=optimset('MaxFunEvals', 1000, 'MaxIter', 5000,'TolX',1e-10,'TolFun',1e-10, 'TolCon',1e-10);
con = [1,zeros(1,k-1)]; % Normalize the first coeff. to 1

%minimize function 'Objfun' w.r.t. beta, with starting value beta0,
%linear constraint set to con*beta=1 such that first coeff. is normalized to 1
%lower bound and upper bound of beta set to -inf and inf respectively
beta = fmincon(@(beta)Objfun(X,Y,beta,h), beta0, [], [],con, 1, -inf, inf,[],options); 


end



