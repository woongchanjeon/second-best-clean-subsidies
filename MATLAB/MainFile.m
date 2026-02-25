%% 0. Set up
clc
clear all
tic;
cd('C:/Users/wjeon01/Project/Replication/CJT2026JEEM/')
addpath('C:/dynare/4.6.2/matlab');
set(0,'DefaultFigureVisible','off')
set(0,'defaultAxesFontSize',15)
set(0,'DefaultLegendFontSize', 10)

%% Mechanics
start_year = 2020;                                                          %% Period of initial steady state
simul_years = 2000;                                                         %% Many years to simulate
per_length = 5;                                                             %% Years in one period
T = simul_years/per_length;                                                 %% Max periods to simulate
chart_years = 50;                                                           %% Number of years to show in charts
chartT = chart_years/per_length + 1;                                        %% Max periods to plot
end_year_chart = start_year + per_length*(chartT-1);                        %% Last period for charts
percentage_check = 0.0001;                                                  %% Tolerance when checking dynare output
BGP = ones(T+2,1);                                                          %% Vectors of one to represent BGP
welfare_years = 1000;                                                       %% Years for welfare calculation
welfare_periods =  welfare_years/per_length;                                %% Periods for welfare calculation
assert(welfare_periods<T, 'welfare periods > simulation periods');          %% Feasibility constraint for welfare calculation
assert(chartT<T, 'chart periods > simulation periods');                     %% Feasibility constraint for plotting

%% Calibration
epsilon_base = 0.95;                                                        %% Clean-Dirty EoS (baseline)
epsilon_alt = 1.85;                                                         %% Clean-Dirty EoS (alternate)
g_cal = (1.02)^per_length - 1;                                              %% Growth rate of Ay
gl_cal = (1.01)^per_length - 1;                                             %% Growth rate of population
nu_cal = 0.08;                                                              %% Energy share of output
labshare_cal = 0.63;                                                        %% Labor share of output
alpha_cal = 1 - nu_cal - labshare_cal;                                      %% Capital share of output
omega_cal = 0.60;                                                           %% CES distribution parameter
delta_cal =  1 - (1-0.06)^per_length;                                       %% Capital depreciation rate
beta_cal = 0.985^per_length/(1+gl_cal);                                     %% Discount rate
eta_g_cal = 0.97^per_length - 1;                                            %% Carbon intensity growth rate
eta0 = 1;                                                                   %% Starting carbon intensity
Ay0 = 1;                                                                    %% Initial value of Ay
L0 = 1;                                                                     %% Initial value of L
Xi_cal = 0.04;                                                              %% LF damages as %% of Y_0

%% Cutoff value
cutoff_eps = 1/(1-nu_cal);

%% IRA Policy                                                               %% Unweighted average of solar and wind from Bistline et al (2022 BPEA)
tauc_IRA = 0.8;                                                             %% Note tau_c in code is (1+tau_c) in paper

%% Level conversion
Ay = ones(T+2, 1);
L = ones(T+2, 1);
per = ones(T+2, 1);                                                         %% Converts periods to years
for t=1:(T+2) 
   Ay(t) = Ay0*(1+g_cal)^(t-1);
   L(t) = L0*(1+gl_cal)^(t-1);
   per(t) = start_year + per_length*(t-1);
end
Level = Ay.*L;                                                              %% Conversion factor from intensive form to levels

%% Save
save('base')                                                                %% Save all variables
save('for_paper.mat', ...
    'g_cal', 'gl_cal', 'delta_cal', 'eta_g_cal', 'beta_cal',  ...
    'tauc_IRA', 'epsilon_base', 'epsilon_alt', 'cutoff_eps')                %% Values reported in paper












%% 1. Initial run (baseline epsilon value, IRA policies) 
clc
clear
load('base')

%% Set-up
epsilon_cal = epsilon_base;                                                 %% Baseline parameter values

tauc_shock = ones(T+2,1);
for t=2:T+2
    tauc_shock(t) = tauc_IRA;                                               %% Impact of IRA subsidies
end
tauc_shock(1) = 1;
taud_shock = ones(T+2, 1);                                                  %% No dirty energy tax
tauc_end = tauc_shock(T+2);
taud_end = taud_shock(T+2);

%% Save
save('dynare_in')

%% Run model
dynare ModelFinal

%% Store laissez-faire results
ep1LF.n = n(1).*BGP;
ep1LF.nc = nc(1).*BGP;
ep1LF.nd = nd(1).*BGP;
ep1LF.s = s(1).*BGP;
ep1LF.pe = pe(1).*BGP;
ep1LF.Y = y(1).*Level;
ep1LF.K = kcurrent(1).*Level;
ep1LF.r = r.*BGP;
ep1LF.C = c(1).*Level;
ep1LF.Zd = zd(1).*Level;
ep1LF.Zc = zc(1).*Level;
ep1LF.E = e(1).*Level;

%% Calibrate m
mep1 = calibratem(beta_cal, Xi_cal, ep1LF.C(1), ep1LF.Y(1), ep1LF.Zd(1), eta0);
save('base', 'mep1', '-append')
save('for_paper.mat', 'mep1', '-append')

%% Calculate Utility
ep1LF.U = welfarePOP(ep1LF.C,ep1LF.Zd, mep1, beta_cal, g_cal, eta0, eta_g_cal, gl_cal, L);
save('base', 'ep1LF', '-append')

%% Store policy results
ep1IRA.n = n;
ep1IRA.nc = nc;
ep1IRA.nd = nd;
ep1IRA.s = s;
ep1IRA.pe = pe;
ep1IRA.Y = y.*Level;
ep1IRA.K = kcurrent.*Level;
ep1IRA.r = r;
ep1IRA.C = c.*Level;
ep1IRA.Zd = zd.*Level;
ep1IRA.Zc = zc.*Level;
ep1IRA.E = e.*Level;

%% Calculate Utility
ep1IRA.U = welfarePOP(ep1IRA.C,ep1IRA.Zd, mep1, beta_cal, g_cal, eta0, eta_g_cal, gl_cal, L);
assert(ep1LF.U>ep1IRA.U, 'IRA Welfare > LF welfare with baseline epsilon')
ep1IRA.CEV = CEVPOP(ep1IRA.U, ep1LF.U, beta_cal, gl_cal, L(1));
CEVep1IRA = ep1IRA.CEV;
save('for_paper.mat', 'CEVep1IRA', '-append')

%% Create Relative Variables
ep1IRA.Relnd = ep1IRA.nd ./ ep1LF.nd;
ep1IRA.Relnc = ep1IRA.nc ./ ep1LF.nc;
ep1IRA.Relny = ep1IRA.n ./ ep1LF.n;
ep1IRA.Rels = ep1IRA.s ./ ep1LF.s;
ep1IRA.RelZd = ep1IRA.Zd ./ ep1LF.Zd;
ep1IRA.RelZc = ep1IRA.Zc ./ ep1LF.Zc;
ep1IRA.RelE = ep1IRA.E ./ ep1LF.E;
ep1IRA.RelC = ep1IRA.C ./ ep1LF.C;
ep1IRA.RelK = ep1IRA.K ./ ep1LF.K;
ep1IRA.RelY = ep1IRA.Y ./ ep1LF.Y;
ep1IRA.Rels = ep1IRA.s ./ ep1LF.s;

%% Save policy results
save('base', 'ep1IRA', '-append')
Ep1EComp = ep1IRA.RelZd(chartT);
save('for_paper.mat', 'Ep1EComp', '-append')


%% Plot Results
clf('reset')
plot(per(1:chartT), ep1IRA.RelZd(1:chartT), 'Color', [200 0 0]/255, 'Marker', '^', 'MarkerSize', 7, 'MarkerFaceColor', [200 0 0]/255, 'LineWidth', 3);
hold on 
plot(per(1:chartT), ep1IRA.RelZc(1:chartT), 'Color', [146 195 51]/255, 'Marker', 's', 'MarkerSize', 10, 'MarkerFaceColor', [146 195 51]/255,'LineWidth', 3);
plot(per(1:chartT), ep1IRA.RelE(1:chartT), 'Color', [64 105 166]/255, 'LineWidth', 3);
plot(per(1:chartT), BGP(1:chartT), 'k-', 'LineWidth', 1);
hold off
axis([start_year end_year_chart 0.85 1.65])
legend('Dirty Energy', 'Clean Energy', 'Energy Services', 'Baseline', 'location', 'northeast', 'fontsize', 10)
print('Output/IRA/eps1/Energy', '-dpdf')

clf('reset')
plot(per(1:chartT), ep1IRA.RelC(1:chartT), 'Color', [144 53 58]/255, 'LineStyle', ':', 'LineWidth', 3);
hold on 
plot(per(1:chartT), ep1IRA.RelY(1:chartT), 'Color', [25 71 111]/255, 'LineStyle', '--', 'LineWidth', 3);
plot(per(1:chartT), ep1IRA.RelK(1:chartT), 'Color', [111 141 133]/255, 'LineWidth', 3);
plot(per(1:chartT), BGP(1:chartT), 'k-', 'LineWidth', 1);
hold off
axis([start_year end_year_chart  0.99 1.015])
legend('Consumption', 'Output', 'Capital', 'Baseline', 'location', 'southeast', 'fontsize', 10)
print('Output/IRA/eps1/Macro', '-dpdf')










%% 2. Second run (alternate epsilon value, IRA policies)
clc
clear all
load('base')

%% Set-up
epsilon_cal = epsilon_alt;                                                  %% Alterative parameter values

tauc_shock = ones(T+2, 1);
for t=2:T+2
    tauc_shock(t) = tauc_IRA;                                               %% Impact of IRA subsidies
end
tauc_shock(1) = 1;
taud_shock = ones(T+2, 1);                                                  %% No dirty energy tax
tauc_end = tauc_shock(T+2);
taud_end = taud_shock(T+2);

%% Save
save('dynare_in')

%% Run model
dynare ModelFinal

%% Store laissez-faire results
ep2LF.n = n(1).*BGP;
ep2LF.nc = nc(1).*BGP;
ep2LF.nd = nd(1).*BGP;
ep2LF.s = s(1).*BGP;
ep2LF.pe = pe(1).*BGP;
ep2LF.Y = y(1).*Level;
ep2LF.K = kcurrent(1).*Level;
ep2LF.r = r.*BGP;
ep2LF.C = c(1).*Level;
ep2LF.Zd = zd(1).*Level;
ep2LF.Zc = zc(1).*Level;
ep2LF.E = e(1).*Level;

%% Calibrate damages
mep2 = calibratem(beta_cal, Xi_cal, ep2LF.C(1), ep2LF.Y(1), ep2LF.Zd(1), eta0);
save('base', 'mep2', '-append')
save('for_paper.mat', 'mep2', '-append')

%% Welfare for laissez-faire case
ep2LF.U = welfarePOP(ep2LF.C,ep2LF.Zd, mep2, beta_cal, g_cal, eta0, eta_g_cal, gl_cal, L);
save('base', 'ep2LF', '-append')

%% Store policy results
ep2IRA.n = n;
ep2IRA.nc = nc;
ep2IRA.nd = nd;
ep2IRA.s = s;
ep2IRA.pe = pe;
ep2IRA.Y = y.*Level;
ep2IRA.K = kcurrent.*Level;
ep2IRA.r = r;
ep2IRA.C = c.*Level;
ep2IRA.Zd = zd.*Level;
ep2IRA.Zc = zc.*Level;
ep2IRA.E = e.*Level;

%% Welfare for policy case
ep2IRA.U = welfarePOP(ep2IRA.C,ep2IRA.Zd, mep2, beta_cal, g_cal, eta0, eta_g_cal, gl_cal, L);
%%assert(ep2LF.U<ep2IRA.U, 'IRA Welfare < LF welfare with alternative epsilon')
ep2IRA.CEV = CEVPOP(ep2IRA.U, ep2LF.U, beta_cal, gl_cal, L(1));
CEVep2IRA = ep2IRA.CEV;
save('for_paper.mat', 'CEVep2IRA', '-append')

%% Store relative variables
ep2IRA.Relnd = ep2IRA.nd ./ ep2LF.nd;
ep2IRA.Relnc = ep2IRA.nc ./ ep2LF.nc;
ep2IRA.Relny = ep2IRA.n  ./ ep2LF.n;
ep2IRA.Rels =  ep2IRA.s  ./ ep2LF.s;
ep2IRA.RelZd = ep2IRA.Zd ./ ep2LF.Zd;
ep2IRA.RelZc = ep2IRA.Zc ./ ep2LF.Zc;
ep2IRA.RelE =  ep2IRA.E  ./ ep2LF.E;
ep2IRA.RelC =  ep2IRA.C  ./ ep2LF.C;
ep2IRA.RelK =  ep2IRA.K  ./ ep2LF.K;
ep2IRA.RelY =  ep2IRA.Y  ./ ep2LF.Y;
ep2IRA.Rels =  ep2IRA.s  ./ ep2LF.s;

%% Save outcomes for alternative epsilon and IRA policies
save('base', 'ep2IRA', '-append')
Ep2EComp = ep2IRA.RelZd(chartT);
save('for_paper.mat', 'Ep2EComp', '-append')

%% Plot Results
clf('reset')
plot(per(1:chartT), ep2IRA.RelZd(1:chartT), 'Color', [200 0 0]/255, 'Marker', '^', 'MarkerSize', 7, 'MarkerFaceColor', [200 0 0]/255, 'LineWidth', 3);
hold on 
plot(per(1:chartT), ep2IRA.RelZc(1:chartT), 'Color', [146 195 51]/255, 'Marker', 's', 'MarkerSize', 10, 'MarkerFaceColor', [146 195 51]/255,'LineWidth', 3);
plot(per(1:chartT), ep2IRA.RelE(1:chartT), 'Color', [64 105 166]/255, 'LineWidth', 3);
plot(per(1:chartT), BGP(1:chartT), 'k-', 'LineWidth', 1);
hold off
axis([start_year end_year_chart 0.85 1.65])
legend('Dirty Energy', 'Clean Energy', 'Energy Services', 'Baseline', 'location', 'northeast', 'fontsize', 10)
print('Output/IRA/eps2/Energy', '-dpdf')

clf('reset')
plot(per(1:chartT), ep2IRA.RelC(1:chartT), 'Color', [144 53 58]/255, 'LineStyle', ':', 'LineWidth', 3);
hold on 
plot(per(1:chartT), ep2IRA.RelY(1:chartT), 'Color', [25 71 111]/255, 'LineStyle', '--', 'LineWidth', 3);
plot(per(1:chartT), ep2IRA.RelK(1:chartT), 'Color', [111 141 133]/255, 'LineWidth', 3);
plot(per(1:chartT), BGP(1:chartT), 'k-', 'LineWidth', 1);
hold off
axis([start_year end_year_chart  0.99 1.015])
legend('Consumption', 'Output', 'Capital', 'Baseline', 'location', 'southeast', 'fontsize', 10)
print('Output/IRA/eps2/Macro', '-dpdf')










%% 3. Constrained-efficient clean energy subsidy (alternate epsilon value)
clc
clear all
load('base')  

%% Subsidy 


tauc_exp = 1;                                                               %% 1 : optimize clean energy subsidy / 0 : optimize dirty energy tax
epsilon_exp = 1;                                                            %% 1 : epsilon_alt / 0 : epsilon_base

q_start = ones(48,1);
xl_const = zeros(48,1);
xh_const = 2*ones(48,1);

tol = 1e-08;
options = optimoptions(@fmincon,'algorithm','interior-point', ...
    'Display','off','FunctionTolerance',tol,'OptimalityTolerance',tol, ...
    'MaxFunctionEvaluations',500000,'MaxIterations',6200,'MaxSQPIter',10000);
[x_opt_subsidy, fval_subsidy] = fmincon(@(x)Policy_Exp_Welfare(x,tauc_exp,epsilon_exp), q_start, [], [], [], [], xl_const, xh_const, [], options);

shock = zeros(T+2, 1);
shock(1) = 1;
shock(2:40) = x_opt_subsidy(1:39);

block_starts = 41:40:360;
for i = 1:length(block_starts)
    shock(block_starts(i):block_starts(i)+39) = x_opt_subsidy(39+i);
end
shock(361:T+2) = x_opt_subsidy(48);

tauc_shock_best_alternate = shock;
save('base', 'tauc_shock_best_alternate', '-append');
save('for_paper.mat', 'tauc_shock_best_alternate', '-append');
save('climate_policy.mat', 'tauc_shock_best_alternate');


%% Run with the optimal subsidy
clc
clear all
load('base')
load('climate_policy')

epsilon_cal = epsilon_alt;                                                  
tauc_shock = tauc_shock_best_alternate;
taud_shock = ones(T+2, 1);
tauc_end = tauc_shock(T+2);
taud_end = taud_shock(T+2);

save('dynare_in')
dynare ModelFinal

%% Store policy results
ep2SBO.n = n;
ep2SBO.nc = nc;
ep2SBO.nd = nd;
ep2SBO.s = s;
ep2SBO.pe = pe;
ep2SBO.Y = y.*Level;
ep2SBO.K = kcurrent.*Level;
ep2SBO.r = r;
ep2SBO.C = c.*Level;
ep2SBO.Zd = zd.*Level;
ep2SBO.Zc = zc.*Level;
ep2SBO.E = e.*Level;

%% Store relative outcomes
ep2SBO.Relnd = ep2SBO.nd ./ ep2LF.nd;
ep2SBO.Relnc = ep2SBO.nc ./ ep2LF.nc;
ep2SBO.Relny = ep2SBO.n  ./ ep2LF.n;
ep2SBO.Rels =  ep2SBO.s  ./ ep2LF.s;
ep2SBO.RelZd = ep2SBO.Zd ./ ep2LF.Zd;
ep2SBO.RelZc = ep2SBO.Zc ./ ep2LF.Zc;
ep2SBO.RelE =  ep2SBO.E  ./ ep2LF.E;
ep2SBO.RelC =  ep2SBO.C  ./ ep2LF.C;
ep2SBO.RelK =  ep2SBO.K  ./ ep2LF.K;
ep2SBO.RelY =  ep2SBO.Y  ./ ep2LF.Y;
ep2SBO.Rels =  ep2SBO.s  ./ ep2LF.s;

%% Calculate Welfare
ep2SBO.U = welfarePOP(ep2SBO.C,ep2SBO.Zd, mep2, beta_cal, g_cal, eta0, eta_g_cal, gl_cal, L);
assert(ep2LF.U<ep2SBO.U, 'SBO welfare < LF Welfare')
assert(ep2IRA.U<ep2SBO.U, 'SBO welfare < IRA Welfare')
ep2SBO.CEV = CEVPOP(ep2SBO.U, ep2LF.U, beta_cal, gl_cal, L(1));
CEVep2SBO = ep2SBO.CEV;
SBOEComp_ep2 = ep2SBO.RelZd(chartT);
save('for_paper.mat', 'CEVep2SBO', 'SBOEComp_ep2', '-append');

%% Save SBO results
save('base', 'ep2SBO', '-append')

%% Plot Results

set(0,'DefaultFigureVisible','off')
set(0,'defaultAxesFontSize',18)
set(0, 'DefaultLegendFontSize', 18)

clf('reset')
plot(per(1:chartT), ep2SBO.RelZd(1:chartT), 'Color', [200 0 0]/255, 'Marker', '^', 'MarkerSize', 7, 'MarkerFaceColor', [200 0 0]/255, 'LineWidth', 3);
hold on 
plot(per(1:chartT), ep2SBO.RelZc(1:chartT), 'Color', [146 195 51]/255, 'Marker', 's', 'MarkerSize', 10, 'MarkerFaceColor', [146 195 51]/255,'LineWidth', 3);
plot(per(1:chartT), ep2SBO.RelE(1:chartT), 'Color', [64 105 166]/255, 'LineWidth', 3);
plot(per(1:chartT), BGP(1:chartT), 'k-', 'LineWidth', 1);
hold off
axis([start_year end_year_chart 0.35 1.8])
legend('Dirty Energy', 'Clean Energy', 'Energy Services', 'Baseline', 'location', 'northeast', 'fontsize', 14)
print('Output/SBO/eps2/Energy', '-dpdf')

clf('reset')
plot(per(1:chartT), ep2SBO.RelC(1:chartT), 'Color', [144 53 58]/255, 'LineStyle', ':', 'LineWidth', 3);
hold on 
plot(per(1:chartT), ep2SBO.RelY(1:chartT), 'Color', [25 71 111]/255, 'LineStyle', '--', 'LineWidth', 3);
plot(per(1:chartT), ep2SBO.RelK(1:chartT), 'Color', [111 141 133]/255, 'LineWidth', 3);
plot(per(1:chartT), BGP(1:chartT), 'k-', 'LineWidth', 1);
hold off
axis([start_year end_year_chart  0.965 1.035])
legend('Consumption', 'Output', 'Capital', 'Baseline', 'location', 'northeast', 'fontsize', 14)
print('Output/SBO/eps2/Macro', '-dpdf')

clf('reset')
plot(per(1:chartT), tauc_shock_best_alternate(1:chartT) - 1, 'Color', 'k', 'Marker', 'o', 'LineStyle', '-.', 'LineWidth', 1.5);
axis([start_year end_year_chart  -0.2 0])
legend('Constrained-efficient Clean Subsidy Rate', 'location', 'northeast', 'fontsize', 14)
print('Output/SBO/eps2/SBCleanSubsidy', '-dpdf')











%% 4. Efficient dirty energy tax (alternate epsilon value)
clc
clear all
load('base')  

%% Tax 


tauc_exp = 0;                                                               %% 1 : optimize clean energy subsidy / 0 : optimize dirty energy tax
epsilon_exp = 1;                                                            %% 1 : epsilon_alt / 0 : epsilon_base

q_start = ones(48,1);
xl_const = zeros(48,1);
xh_const = 2*ones(48,1);

tol = 1e-08;
options = optimoptions(@fmincon,'algorithm','interior-point', ...
    'Display','off','FunctionTolerance',tol,'OptimalityTolerance',tol, ...
    'MaxFunctionEvaluations',500000,'MaxIterations',6200,'MaxSQPIter',10000);
[x_opt_tax, fval_tax] = fmincon(@(x)Policy_Exp_Welfare(x,tauc_exp,epsilon_exp), q_start, [], [], [], [], xl_const, xh_const, [], options);

shock = zeros(T+2, 1);
shock(1) = 1;
shock(2:40) = x_opt_tax(1:39);

block_starts = 41:40:360;
for i = 1:length(block_starts)
    shock(block_starts(i):block_starts(i)+39) = x_opt_tax(39+i);
end
shock(361:T+2) = x_opt_tax(48);

taud_shock_best_alternate = shock;
save('base', 'taud_shock_best_alternate', '-append');
save('for_paper.mat', 'taud_shock_best_alternate', '-append');
save('climate_policy.mat', 'taud_shock_best_alternate','-append');


%% Run with the optimal tax
clc
clear all
load('base')
load('climate_policy')

epsilon_cal = epsilon_alt;                                                  
tauc_shock = ones(T+2, 1);
taud_shock = taud_shock_best_alternate;
tauc_end = tauc_shock(T+2);
taud_end = taud_shock(T+2);

save('dynare_in')
dynare ModelFinal

%% Store policy results
ep2TAX.n = n;
ep2TAX.nc = nc;
ep2TAX.nd = nd;
ep2TAX.s = s;
ep2TAX.pe = pe;
ep2TAX.Y = y.*Level;
ep2TAX.K = kcurrent.*Level;
ep2TAX.r = r;
ep2TAX.C = c.*Level;
ep2TAX.Zd = zd.*Level;
ep2TAX.Zc = zc.*Level;
ep2TAX.E = e.*Level;

%% Store Relative Outcomes
ep2TAX.Relnd = ep2TAX.nd ./ ep2LF.nd;
ep2TAX.Relnc = ep2TAX.nc ./ ep2LF.nc;
ep2TAX.Relny = ep2TAX.n  ./ ep2LF.n;
ep2TAX.Rels =  ep2TAX.s  ./ ep2LF.s;
ep2TAX.RelZd = ep2TAX.Zd ./ ep2LF.Zd;
ep2TAX.RelZc = ep2TAX.Zc ./ ep2LF.Zc;
ep2TAX.RelE =  ep2TAX.E  ./ ep2LF.E;
ep2TAX.RelC =  ep2TAX.C  ./ ep2LF.C;
ep2TAX.RelK =  ep2TAX.K  ./ ep2LF.K;
ep2TAX.RelY =  ep2TAX.Y  ./ ep2LF.Y;
ep2TAX.Rels =  ep2TAX.s  ./ ep2LF.s;

%% Calculate welfare
ep2TAX.U = welfarePOP(ep2TAX.C, ep2TAX.Zd, mep2, beta_cal, g_cal, eta0, eta_g_cal, gl_cal, L);
assert(ep2LF.U<ep2TAX.U, 'LF Welfare > Tax welfare')
assert(ep2SBO.U<ep2TAX.U,  'subsidy Welfare > Tax welfare')
ep2TAX.CEV = CEVPOP(ep2TAX.U, ep2LF.U, beta_cal, gl_cal, L(1));
CEVep2TAX = ep2TAX.CEV;
TAXEComp_ep2 = ep2TAX.RelZd(chartT);
save('for_paper.mat', 'CEVep2TAX', 'TAXEComp_ep2','-append');

%% Save tax results
save('base', 'ep2TAX', '-append')

%% Plot Results

set(0,'DefaultFigureVisible','off')
set(0,'defaultAxesFontSize',18)
set(0, 'DefaultLegendFontSize', 18)

clf('reset')
plot(per(1:chartT), ep2TAX.RelZd(1:chartT), 'Color', [200 0 0]/255, 'Marker', '^', 'MarkerSize', 7, 'MarkerFaceColor', [200 0 0]/255, 'LineWidth', 3);
hold on 
plot(per(1:chartT), ep2TAX.RelZc(1:chartT), 'Color', [146 195 51]/255, 'Marker', 's', 'MarkerSize', 10, 'MarkerFaceColor', [146 195 51]/255,'LineWidth', 3);
plot(per(1:chartT), ep2TAX.RelE(1:chartT), 'Color', [64 105 166]/255, 'LineWidth', 3);
plot(per(1:chartT), BGP(1:chartT), 'k-', 'LineWidth', 1);
hold off
axis([start_year end_year_chart 0.35 1.8])
legend('Dirty Energy', 'Clean Energy', 'Energy Services', 'Baseline', 'location', 'northeast', 'fontsize', 14)
print('Output/Tax/eps2/Energy', '-dpdf')

clf('reset')
plot(per(1:chartT), ep2TAX.RelC(1:chartT), 'Color', [144 53 58]/255, 'LineStyle', ':', 'LineWidth', 3);
hold on 
plot(per(1:chartT), ep2TAX.RelY(1:chartT), 'Color', [25 71 111]/255, 'LineStyle', '--', 'LineWidth', 3);
plot(per(1:chartT), ep2TAX.RelK(1:chartT), 'Color', [111 141 133]/255, 'LineWidth', 3);
plot(per(1:chartT), BGP(1:chartT), 'k-', 'LineWidth', 1);
hold off
axis([start_year end_year_chart  0.965 1.035])
legend('Consumption', 'Output', 'Capital', 'Baseline', 'location', 'northeast', 'fontsize', 14)
print('Output/Tax/eps2/Macro', '-dpdf')

clf('reset')
plot(per(1:chartT), taud_shock_best_alternate(1:chartT) - 1, 'Color', 'k', 'Marker', 'o', 'LineStyle', '-.', 'LineWidth', 1.5);
axis([start_year end_year_chart  0 0.8])
legend('Efficient Dirty Tax Rate', 'location', 'northeast', 'fontsize', 14)
print('Output/Tax/eps2/FBDirtyTax', '-dpdf')

for t=1:T
    CO2_intensity(t) = eta0*(1+eta_g_cal)^(t-1);
    FB_dirty_tax(t) = taud_shock_best_alternate(t) - 1;
    FB_carbon_tax(t) = FB_dirty_tax(t)/CO2_intensity(t);
end

clf('reset')
plot(per(1:chartT), FB_carbon_tax(1:chartT), 'Color', 'k', 'Marker', '*', 'LineStyle', '-', 'LineWidth', 1.5);
hold on
plot(per(1:chartT), taud_shock_best_alternate(1:chartT) - 1, 'Color', 'k', 'Marker', 'o', 'LineStyle', '-.', 'LineWidth', 1.5);
hold off
axis([start_year end_year_chart  0 2.75])
legend('Optimal Carbon Tax Rate', 'Optimal Dirty Tax Rate', 'location', 'northeast', 'fontsize', 14)
print('Output/Tax/eps2/FBCarbonTax', '-dpdf')











%% Load Numbers for paper
clear
load('for_paper.mat')

total_time = toc;
save('analysis_runtime.mat', 'total_time');