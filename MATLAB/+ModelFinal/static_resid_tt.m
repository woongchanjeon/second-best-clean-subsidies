function T = static_resid_tt(T, y, x, params)
% function T = static_resid_tt(T, y, x, params)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T         [#temp variables by 1]  double   vector of temporary terms to be filled by function
%   y         [M_.endo_nbr by 1]      double   vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1]       double   vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1]     double   vector of parameter values in declaration order
%
% Output:
%   T         [#temp variables by 1]  double   vector of temporary terms
%

assert(length(T) >= 13);

T(1) = (1-params(9))^(1/params(7));
T(2) = x(1)^(-params(8));
T(3) = params(9)^(1/params(7))*x(2)^(-params(8))+T(1)*y(2)^params(8)*T(2);
T(4) = y(10)^params(4);
T(5) = y(9)^params(5);
T(6) = params(4)*y(10)^(params(4)-1);
T(7) = y(9)^(params(5)-1);
T(8) = x(2)^(-1);
T(9) = x(1)^(-1);
T(10) = y(1)/x(3)/x(2);
T(11) = T(10)^params(7);
T(12) = y(1)/x(4)/x(1);
T(13) = T(12)^params(7);

end
