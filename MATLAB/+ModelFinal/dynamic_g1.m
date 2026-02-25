function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
% function g1 = dynamic_g1(T, y, x, params, steady_state, it_, T_flag)
%
% File created by Dynare Preprocessor from .mod file
%
% Inputs:
%   T             [#temp variables by 1]     double   vector of temporary terms to be filled by function
%   y             [#dynamic variables by 1]  double   vector of endogenous variables in the order stored
%                                                     in M_.lead_lag_incidence; see the Manual
%   x             [nperiods by M_.exo_nbr]   double   matrix of exogenous variables (in declaration order)
%                                                     for all simulation periods
%   steady_state  [M_.endo_nbr by 1]         double   vector of steady state values
%   params        [M_.param_nbr by 1]        double   vector of parameter values in declaration order
%   it_           scalar                     double   time period for exogenous variables for which
%                                                     to evaluate the model
%   T_flag        boolean                    boolean  flag saying whether or not to calculate temporary terms
%
% Output:
%   g1
%

if T_flag
    T = ModelFinal.dynamic_g1_tt(T, y, x, params, steady_state, it_);
end
g1 = zeros(18, 25);
g1(1,2)=1;
g1(1,22)=(-((1-params(9))*x(it_, 4)*T(24)*T(25)));
g1(1,23)=(-(T(25)*params(9)*x(it_, 3)*T(27)));
g1(1,24)=(-(T(25)*params(9)*x(it_, 2)*T(27)));
g1(1,25)=(-(T(25)*(1-params(9))*x(it_, 1)*T(24)));
g1(2,3)=1;
g1(2,22)=(-(T(3)*(1-params(9))/params(9)*(-x(it_, 2))/(x(it_, 1)*x(it_, 1))*T(26)));
g1(2,23)=(-(T(3)*(1-params(9))/params(9)*T(26)*1/x(it_, 1)));
g1(2,24)=(-(T(2)*1/x(it_, 4)*T(28)));
g1(2,25)=(-(T(2)*T(28)*(-x(it_, 3))/(x(it_, 4)*x(it_, 4))));
g1(3,3)=(-((-(1-y(7)))/((1+y(3))*(1+y(3)))));
g1(3,4)=1;
g1(3,7)=(-((-1)/(1+y(3))));
g1(4,3)=(-y(4));
g1(4,4)=(-y(3));
g1(4,5)=1;
g1(5,3)=(-(T(7)*T(5)*getPowerDeriv(y(3),params(8),1)*T(21)));
g1(5,6)=1;
g1(5,22)=(-(T(21)*T(6)*getPowerDeriv(x(it_, 1),(-params(8)),1)));
g1(5,23)=(-(T(21)*T(4)*getPowerDeriv(x(it_, 2),(-params(8)),1)));
g1(6,2)=(1+y(3))*params(5)*(-y(6))/(y(2)*y(2));
g1(6,3)=params(5)*y(6)/y(2);
g1(6,6)=(1+y(3))*params(5)*1/y(2);
g1(6,7)=1;
g1(7,7)=(-(T(9)*T(10)));
g1(7,8)=1;
g1(7,10)=(-(y(7)*T(9)*T(22)));
g1(7,1)=(-(y(7)*T(10)*T(23)));
g1(8,9)=1;
g1(8,10)=(-(T(11)*T(22)));
g1(8,1)=(-(T(10)*params(4)*getPowerDeriv(y(1),params(4)-1,1)));
g1(9,2)=1;
g1(9,10)=(-(params(5)*T(9)*getPowerDeriv(y(10),params(5)-1,1)));
g1(9,1)=(-(T(12)*params(5)*T(23)));
g1(10,8)=(-(1/(1+params(3))/(1+params(2))));
g1(10,1)=(-((1-params(10))/(1+params(3))/(1+params(2))));
g1(10,11)=1;
g1(10,12)=(-((-1)/(1+params(3))/(1+params(2))));
g1(11,20)=(-(y(12)*params(1)/(1+params(3))));
g1(11,12)=(-(params(1)*(1+y(20))/(1+params(3))));
g1(11,21)=1;
g1(12,4)=(-(T(9)*T(10)*T(13)));
g1(12,10)=(-(T(13)*y(4)*T(9)*T(22)));
g1(12,1)=(-(T(13)*y(4)*T(10)*T(23)));
g1(12,13)=1;
g1(12,23)=(-(y(4)*T(9)*T(10)*getPowerDeriv(x(it_, 2),(-1),1)));
g1(13,5)=(-(T(9)*T(10)*T(14)));
g1(13,10)=(-(T(14)*y(5)*T(9)*T(22)));
g1(13,1)=(-(T(14)*y(5)*T(10)*T(23)));
g1(13,14)=1;
g1(13,22)=(-(y(5)*T(9)*T(10)*getPowerDeriv(x(it_, 1),(-1),1)));
g1(14,8)=(-y(12))/(y(8)*y(8));
g1(14,12)=1/y(8);
g1(14,15)=1;
g1(15,1)=(-1);
g1(15,16)=1;
g1(16,2)=(-(params(9)*y(10)*1/x(it_, 3)/x(it_, 2)*T(19)));
g1(16,10)=(-(params(9)*T(16)));
g1(16,17)=1;
g1(16,23)=(-(params(9)*y(10)*T(19)*(-(y(2)/x(it_, 3)))/(x(it_, 2)*x(it_, 2))));
g1(16,24)=(-(params(9)*y(10)*T(19)*(-y(2))/(x(it_, 3)*x(it_, 3))/x(it_, 2)));
g1(17,2)=(-((1-params(9))*y(10)*1/x(it_, 4)/x(it_, 1)*T(20)));
g1(17,10)=(-((1-params(9))*T(18)));
g1(17,18)=1;
g1(17,22)=(-((1-params(9))*y(10)*T(20)*(-(y(2)/x(it_, 4)))/(x(it_, 1)*x(it_, 1))));
g1(17,25)=(-((1-params(9))*y(10)*T(20)*(-y(2))/(x(it_, 4)*x(it_, 4))/x(it_, 1)));
g1(18,4)=1;
g1(18,5)=1;
g1(18,7)=1;
g1(18,19)=1;

end
