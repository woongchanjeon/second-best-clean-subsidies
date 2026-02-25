function Uout = welfarePOP(C, Zd, m_var, beta_var, g_var, eta0_var, eta_g_var, gl_var, L_var)
    % Calculates welfare given a vector of consumption (C), Dirty energy
    % use (Zd), a utility cost of dirty enegy use (m), a discount rate
    % (beta_var), and a steady state growth rate (g_var). In addition, 
    % eta0_var is the initial carbon intensity of dirty energy, and
    % eta_g_var<0 is the growth rate of carbon intensity.
    
    % Check finiteness
    assert (beta_var*(1+g_var)*(1+eta_g_var)<1)
    
    % Length of vectors
    T_var = length(C);
    assert (length(C) == length(Zd));
    
    % Initialize
    C_flow = ones(T_var,1);
    Zd_flow = ones(T_var,1);
    CO2_intensity = ones(T_var,1);
    
    for t=1:T_var
        CO2_intensity(t) = eta0_var*(1+eta_g_var)^(t-1);
        C_flow(t) = beta_var^(t-1)*L_var(t)*log(C(t));
        Zd_flow(t) = beta_var^(t-1)*m_var/(1-beta_var)*Zd(t)*CO2_intensity(t);
    end
    
    % Continuation value from T_var
    C_terminal = L_var(T_var)*beta_var^(T_var)/(1-beta_var*(1+gl_var))*log(C(T_var)) ...
        + (beta_var^T_var)*L_var(T_var)*(beta_var*(1+gl_var))*log(1+g_var)/(1-beta_var*(1+gl_var))^2;  
    Zd_terminal = beta_var^(T_var) * eta0_var * (1+eta_g_var)^(T_var) * ...
        m_var/((1-beta_var)*(1-beta_var*(1+eta_g_var)*(1+g_var)))*Zd(T_var);
    
    % Lifetime Utility
    Uout = sum(C_flow) - sum(Zd_flow) + C_terminal - Zd_terminal;  % 
end