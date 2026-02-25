function m_out = calibratem(beta_in, Xi_in, C0_in, Y0_in, Zd0_in, eta0_in)
numerator = Xi_in*(1-beta_in)*Y0_in;
denominator = eta0_in*C0_in*Zd0_in;
m_out = numerator / denominator;