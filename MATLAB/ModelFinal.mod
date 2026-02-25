load ('dynare_in')





%%%%%%%%%% Model Set-Up %%%%%%%%%%


% -- List variables
var pe, ntilde, nd, nc, petilde, n, y, r, e, k, c, zd, zc, s, kcurrent, zd2, zc2, MCn;


% -- List parameters
parameters beta, gl, g, alpha, nu, gamma, epsilon, rho, omega, delta;


% -- List exogenous variables
varexo pc, pd, taud, tauc;


% -- Assign parameter values
beta = beta_cal;                                                            % Discount factor
gl = gl_cal;                                                                % Growth rate of population
g = g_cal;                                                                  % Growth rate of Ay
alpha = alpha_cal;                                                          % Capital share
nu = nu_cal;                                                                % Energy share
gamma = 1 - nu - alpha;                                                     % Labor share
epsilon = epsilon_cal;                                                      % Clean-Dirty EoS
rho = (epsilon-1)/epsilon; 
omega = omega_cal;                                                          % CES distribution parameter
delta = delta_cal;                                                          % Capital depreciation rate


% -- Specify model
model;

// Block 1: Variables that don't depend on macro aggregates
pe = ( omega*(taud*pd)^(1-epsilon) + (1-omega)*(tauc*pc)^(1-epsilon) )^(1/(1-epsilon));                                                     
                                                                            % Price of final energy (B13) 
ntilde = (1-omega)/omega*(pd/pc)^(epsilon-1)*(taud/tauc)^epsilon;           % Intermediate variable \tilde{n}_{cd} (B29)
nd = (1-n)/(1+ntilde);                                                      % Dirty energy share of inputs (B31)
nc = ntilde*nd;                                                             % Clean energy input share (B32)
petilde = ( omega^(1/epsilon)*pd^(-rho) + (1-omega)^(1/epsilon)*ntilde^rho*pc^(-rho) )^(-1/rho);                                                        
                                                                            % Intermediate variable \tilde{p}_{e,t} (B36)
n = 1 - nu*(petilde/pe)*(1+ntilde);                                         % Final good labor share (B39)

// Block 2: Growth Model
y = k(-1)^alpha*e^nu*n;                                                     % Final good production function (B17)
r = alpha*k(-1)^(alpha-1)*e^nu - delta;                                     % Final good FOC wrt K (B20)
pe = nu*k(-1)^alpha*e^(nu-1);                                               % Final good FOC wrt E (B21)
k = (y - c + (1-delta)*k(-1))/(1+g)/(1+gl);                                 % K law of motion (B25)
c(+1) = beta*(1+r(+1))/(1+g)*c;                                             % Euler Equation (B26)

// Block 3: Primary energy production (no feedback to rest of model)
zd = k(-1)^alpha*e^nu*nd*pd^(-1);                                           % Dirty energy production function (B18)
zc = k(-1)^alpha*e^nu*nc*pc^(-1);                                           % Clean energy production function (B19)

// Block 4: Savings variables (no feedback to rest of model)
s = 1 - c/y;                                                                % Savings Rate
kcurrent = k(-1);                                                           % Contemporaneous capital

// Block 5: Variables for checking
zd2 = (pe/taud/pd)^epsilon*e*omega;                                         % Final energy FOC wrt Zd (B11)
zc2 = (pe/tauc/pc)^epsilon*e*(1-omega);                                     % Final energy FOC wrt Zc (B12)
MCn = 1 - n - nd - nc;                                                      % Market clearing condition for labor

end;





%%%%%%%%%% Run Model %%%%%%%%%%


% -- Specify initial steady state
initval;

tauc = 1;
taud = 1;
pc = 1;
pd = 1;
pe = ( omega*(taud*pd)^(1-epsilon) + (1-omega)*(tauc*pc)^(1-epsilon) )^(1/(1-epsilon));
ntilde = (1-omega)/omega*(pd/pc)^(epsilon-1)*(taud/tauc)^epsilon;
petilde = ( omega^(1/epsilon)*pd^(-rho) + (1-omega)^(1/epsilon)*ntilde^rho*pc^(-rho) )^(-1/rho);  
n = 1 - nu*(petilde/pe)*(1+ntilde);
nd = (1-n)/(1+ntilde);
nc = ntilde*nd;
r = (1+g)/beta - 1;
k = alpha^((1-nu)/gamma) * (r+delta)^((nu-1)/gamma) * (nu/pe)^(nu/gamma);
e = (nu/pe)^(1/(1-nu)) * k^(alpha/(1-nu));
y = k^alpha * e^nu * n;
c = y - (1+g)*(1+gl)*k + (1-delta)*k;
zd = k^alpha*e^nu*nd*pd^(-1);
zc = k^alpha*e^nu*nc*pc^(-1);
s = 1 - c/y;
kcurrent = k;   
zd2 = (pe/taud/pd)^epsilon*e*omega;
zc2 = (pe/tauc/pc)^epsilon*e*(1-omega);
MCn = 1 - n - nd - nc;

end;
steady;


% -- Specify terminal steady state
endval;

tauc = tauc_end;
taud = taud_end;
pc = 1;
pd = 1;
pe = ( omega*(taud*pd)^(1-epsilon) + (1-omega)*(tauc*pc)^(1-epsilon) ) ^ (1/(1-epsilon));
ntilde = (1-omega)/omega*(pd/pc)^(epsilon-1)*(taud/tauc)^epsilon;
petilde = ( omega^(1/epsilon)*pd^(-rho) + (1-omega)^(1/epsilon)*ntilde^rho*pc^(-rho) )^(-1/rho);  
n = 1 - nu*(petilde/pe)*(1+ntilde);
nd = (1-n)/(1+ntilde);
nc = ntilde*nd;
r = (1+g)/beta - 1;
k = alpha^((1-nu)/gamma) * (r+delta)^((nu-1)/gamma) * (nu/pe)^(nu/gamma);
e = (nu/pe)^(1/(1-nu)) * k^(alpha/(1-nu));
y = k^alpha * e^nu * n;
c = y - (1+g)*(1+gl)*k + (1-delta)*k;
zd = k^alpha*e^nu*nd*pd^(-1);
zc = k^alpha*e^nu*nc*pc^(-1);
s = 1 - c/y;
kcurrent = k;   
zd2 = (pe/taud/pd)^epsilon*e*omega;
zc2 = (pe/tauc/pc)^epsilon*e*(1-omega);
MCn = 1 - n - nd - nc;

end;
steady;


% -- Shock to tauc
tauc_shock = tauc_shock(1:401)
shocks;

var tauc;
periods 0:400;  
values (tauc_shock);

end;


% -- Shock to taud
taud_shock = taud_shock(1:401)
shocks;

var taud;
periods 0:400;  
values (taud_shock);

end;



% -- Run simulation
perfect_foresight_setup(periods = 400);
perfect_foresight_solver(maxit = 100);


% -- Check
assert (max(abs(zd-zd2)./zd)<percentage_check, 'zd !=zd2');
assert (max(abs(zc-zc2)./zc)<percentage_check, 'zc !=zc2');
assert (max(MCn)<percentage_check, 'labor market not cleared');
assert (length(n) == (T+2), 'Vector length mismatch')