function xi = CEVPOP(newU, baseU, beta_var, gl_var, L0_var)
% Calculate CEV. baseU is Laissez-faire BGP utility. newU is utility with
% poliy. beta_var is discount factor. xi is fractional change in baseU
% needed to create indifference with newU. Assumes log preferences.
deltaU = newU - baseU;
xi = exp(deltaU*(1-beta_var*(1+gl_var))/L0_var);