function T = dynamic_g1_tt(T, y, x, params, steady_state, it_)
% function T = dynamic_g1_tt(T, y, x, params, steady_state, it_)
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

assert(length(T) >= 28);

T = ModelFinal.dynamic_resid_tt(T, y, x, params, steady_state, it_);

T(19) = getPowerDeriv(T(15),params(7),1);
T(20) = getPowerDeriv(T(17),params(7),1);
T(21) = getPowerDeriv(T(8),(-1)/params(8),1);
T(22) = getPowerDeriv(y(10),params(5),1);
T(23) = getPowerDeriv(y(1),params(4),1);
T(24) = getPowerDeriv(x(it_, 4)*x(it_, 1),1-params(7),1);
T(25) = getPowerDeriv(T(1),1/(1-params(7)),1);
T(26) = getPowerDeriv(x(it_, 2)/x(it_, 1),params(7)-1,1);
T(27) = getPowerDeriv(x(it_, 3)*x(it_, 2),1-params(7),1);
T(28) = getPowerDeriv(x(it_, 3)/x(it_, 4),params(7),1);

end
