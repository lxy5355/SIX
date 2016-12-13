clear all
n = 500;
k = 3;
error_terms = randn(n,1);
x_sim = randn(n, k)./100; 
beta_true =[1;5;2];
beta0 = [1;0;2]; %set initial value for minimization
y_sim = (x_sim*beta_true) + error_terms;
h = 20; 
%beta = KS_XL (x_sim,y_sim,h,beta0) %use ichimura estimator
beta = Ichimura_XL (x_sim,y_sim,h,beta0) %use klein spady estimator


%code for monte carlo
% n_sim = 10;
% coeff_save = NaN(k+1,n_sim);

% for ii=1:n_sim
%     coeff_save(1:k,ii) = Ichimura_XL(x_terms, y_sim,h,beta0);
% end
% disp (coeff_save)