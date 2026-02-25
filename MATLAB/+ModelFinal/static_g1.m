function g1 = static_g1(T, y, x, params, T_flag)
% function g1 = static_g1(T, y, x, params, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%                                              to evaluate the model
%   T_flag    boolean                 boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   g1
%

if T_flag
    T = ModelFinal.static_g1_tt(T, y, x, params);
end
g1 = zeros(18, 18);
g1(1,1)=1;
g1(2,2)=1;
g1(3,2)=(-((-(1-y(6)))/((1+y(2))*(1+y(2)))));
g1(3,3)=1;
g1(3,6)=(-((-1)/(1+y(2))));
g1(4,2)=(-y(3));
g1(4,3)=(-y(2));
g1(4,4)=1;
g1(5,2)=(-(T(2)*T(1)*getPowerDeriv(y(2),params(8),1)*getPowerDeriv(T(3),(-1)/params(8),1)));
g1(5,5)=1;
g1(6,1)=(1+y(2))*params(5)*(-y(5))/(y(1)*y(1));
g1(6,2)=params(5)*y(5)/y(1);
g1(6,5)=(1+y(2))*params(5)*1/y(1);
g1(6,6)=1;
g1(7,6)=(-(T(4)*T(5)));
g1(7,7)=1;
g1(7,9)=(-(y(6)*T(4)*T(14)));
g1(7,10)=(-(y(6)*T(5)*T(15)));
g1(8,8)=1;
g1(8,9)=(-(T(6)*T(14)));
g1(8,10)=(-(T(5)*params(4)*getPowerDeriv(y(10),params(4)-1,1)));
g1(9,1)=1;
g1(9,9)=(-(params(5)*T(4)*getPowerDeriv(y(9),params(5)-1,1)));
g1(9,10)=(-(T(7)*params(5)*T(15)));
g1(10,7)=(-(1/(1+params(3))/(1+params(2))));
g1(10,10)=1-(1-params(10))/(1+params(3))/(1+params(2));
g1(10,11)=(-((-1)/(1+params(3))/(1+params(2))));
g1(11,8)=(-(y(11)*params(1)/(1+params(3))));
g1(11,11)=1-params(1)*(1+y(8))/(1+params(3));
g1(12,3)=(-(T(4)*T(5)*T(8)));
g1(12,9)=(-(T(8)*y(3)*T(4)*T(14)));
g1(12,10)=(-(T(8)*y(3)*T(5)*T(15)));
g1(12,12)=1;
g1(13,4)=(-(T(4)*T(5)*T(9)));
g1(13,9)=(-(T(9)*y(4)*T(4)*T(14)));
g1(13,10)=(-(T(9)*y(4)*T(5)*T(15)));
g1(13,13)=1;
g1(14,7)=(-y(11))/(y(7)*y(7));
g1(14,11)=1/y(7);
g1(14,14)=1;
g1(15,10)=(-1);
g1(15,15)=1;
g1(16,1)=(-(params(9)*y(9)*1/x(3)/x(2)*getPowerDeriv(T(10),params(7),1)));
g1(16,9)=(-(params(9)*T(11)));
g1(16,16)=1;
g1(17,1)=(-((1-params(9))*y(9)*1/x(4)/x(1)*getPowerDeriv(T(12),params(7),1)));
g1(17,9)=(-((1-params(9))*T(13)));
g1(17,17)=1;
g1(18,3)=1;
g1(18,4)=1;
g1(18,6)=1;
g1(18,18)=1;
if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
end
end
