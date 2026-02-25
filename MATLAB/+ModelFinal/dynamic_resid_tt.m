function T = dynamic_resid_tt(T, y, x, params, steady_state, it_)
% function T = dynamic_resid_tt(T, y, x, params, steady_state, it_)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double  vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double  vector of endogenous variables in the order stored
%                                                    in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double  matrix of exogenous variables (in declaration order)
%                                                    for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double  vector of steady state values
%   params        [M_.param_nbr by 1]        double  vector of parameter values in declaration order
%   it_           scalar                     double  time period for exogenous variables for which
%                                                    to evaluate the model
%
% Output:
%   T           [#temp variables by 1]       double  vector of temporary terms
%

assert(length(T) >= 18);

T(1) = params(9)*(x(it_, 3)*x(it_, 2))^(1-params(7))+(1-params(9))*(x(it_, 4)*x(it_, 1))^(1-params(7));
T(2) = (1-params(9))/params(9)*(x(it_, 2)/x(it_, 1))^(params(7)-1);
T(3) = (x(it_, 3)/x(it_, 4))^params(7);
T(4) = params(9)^(1/params(7));
T(5) = (1-params(9))^(1/params(7));
T(6) = T(5)*y(3)^params(8);
T(7) = x(it_, 1)^(-params(8));
T(8) = T(4)*x(it_, 2)^(-params(8))+T(6)*T(7);
T(9) = y(1)^params(4);
T(10) = y(10)^params(5);
T(11) = params(4)*y(1)^(params(4)-1);
T(12) = y(10)^(params(5)-1);
T(13) = x(it_, 2)^(-1);
T(14) = x(it_, 1)^(-1);
T(15) = y(2)/x(it_, 3)/x(it_, 2);
T(16) = T(15)^params(7);
T(17) = y(2)/x(it_, 4)/x(it_, 1);
T(18) = T(17)^params(7);

end
