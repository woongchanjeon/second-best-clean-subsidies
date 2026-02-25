%
% Status : main Dynare file
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

if isoctave || matlab_ver_less_than('8.6')
    clear all
else
    clearvars -global
    clear_persistent_variables(fileparts(which('dynare')), false)
end
tic0 = tic;
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info ys0_ ex0_
options_ = [];
M_.fname = 'ModelFinal';
M_.dynare_version = '4.6.2';
oo_.dynare_version = '4.6.2';
options_.dynare_version = '4.6.2';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('ModelFinal.log');
M_.exo_names = cell(4,1);
M_.exo_names_tex = cell(4,1);
M_.exo_names_long = cell(4,1);
M_.exo_names(1) = {'pc'};
M_.exo_names_tex(1) = {'pc'};
M_.exo_names_long(1) = {'pc'};
M_.exo_names(2) = {'pd'};
M_.exo_names_tex(2) = {'pd'};
M_.exo_names_long(2) = {'pd'};
M_.exo_names(3) = {'taud'};
M_.exo_names_tex(3) = {'taud'};
M_.exo_names_long(3) = {'taud'};
M_.exo_names(4) = {'tauc'};
M_.exo_names_tex(4) = {'tauc'};
M_.exo_names_long(4) = {'tauc'};
M_.endo_names = cell(18,1);
M_.endo_names_tex = cell(18,1);
M_.endo_names_long = cell(18,1);
M_.endo_names(1) = {'pe'};
M_.endo_names_tex(1) = {'pe'};
M_.endo_names_long(1) = {'pe'};
M_.endo_names(2) = {'ntilde'};
M_.endo_names_tex(2) = {'ntilde'};
M_.endo_names_long(2) = {'ntilde'};
M_.endo_names(3) = {'nd'};
M_.endo_names_tex(3) = {'nd'};
M_.endo_names_long(3) = {'nd'};
M_.endo_names(4) = {'nc'};
M_.endo_names_tex(4) = {'nc'};
M_.endo_names_long(4) = {'nc'};
M_.endo_names(5) = {'petilde'};
M_.endo_names_tex(5) = {'petilde'};
M_.endo_names_long(5) = {'petilde'};
M_.endo_names(6) = {'n'};
M_.endo_names_tex(6) = {'n'};
M_.endo_names_long(6) = {'n'};
M_.endo_names(7) = {'y'};
M_.endo_names_tex(7) = {'y'};
M_.endo_names_long(7) = {'y'};
M_.endo_names(8) = {'r'};
M_.endo_names_tex(8) = {'r'};
M_.endo_names_long(8) = {'r'};
M_.endo_names(9) = {'e'};
M_.endo_names_tex(9) = {'e'};
M_.endo_names_long(9) = {'e'};
M_.endo_names(10) = {'k'};
M_.endo_names_tex(10) = {'k'};
M_.endo_names_long(10) = {'k'};
M_.endo_names(11) = {'c'};
M_.endo_names_tex(11) = {'c'};
M_.endo_names_long(11) = {'c'};
M_.endo_names(12) = {'zd'};
M_.endo_names_tex(12) = {'zd'};
M_.endo_names_long(12) = {'zd'};
M_.endo_names(13) = {'zc'};
M_.endo_names_tex(13) = {'zc'};
M_.endo_names_long(13) = {'zc'};
M_.endo_names(14) = {'s'};
M_.endo_names_tex(14) = {'s'};
M_.endo_names_long(14) = {'s'};
M_.endo_names(15) = {'kcurrent'};
M_.endo_names_tex(15) = {'kcurrent'};
M_.endo_names_long(15) = {'kcurrent'};
M_.endo_names(16) = {'zd2'};
M_.endo_names_tex(16) = {'zd2'};
M_.endo_names_long(16) = {'zd2'};
M_.endo_names(17) = {'zc2'};
M_.endo_names_tex(17) = {'zc2'};
M_.endo_names_long(17) = {'zc2'};
M_.endo_names(18) = {'MCn'};
M_.endo_names_tex(18) = {'MCn'};
M_.endo_names_long(18) = {'MCn'};
M_.endo_partitions = struct();
M_.param_names = cell(10,1);
M_.param_names_tex = cell(10,1);
M_.param_names_long = cell(10,1);
M_.param_names(1) = {'beta'};
M_.param_names_tex(1) = {'beta'};
M_.param_names_long(1) = {'beta'};
M_.param_names(2) = {'gl'};
M_.param_names_tex(2) = {'gl'};
M_.param_names_long(2) = {'gl'};
M_.param_names(3) = {'g'};
M_.param_names_tex(3) = {'g'};
M_.param_names_long(3) = {'g'};
M_.param_names(4) = {'alpha'};
M_.param_names_tex(4) = {'alpha'};
M_.param_names_long(4) = {'alpha'};
M_.param_names(5) = {'nu'};
M_.param_names_tex(5) = {'nu'};
M_.param_names_long(5) = {'nu'};
M_.param_names(6) = {'gamma'};
M_.param_names_tex(6) = {'gamma'};
M_.param_names_long(6) = {'gamma'};
M_.param_names(7) = {'epsilon'};
M_.param_names_tex(7) = {'epsilon'};
M_.param_names_long(7) = {'epsilon'};
M_.param_names(8) = {'rho'};
M_.param_names_tex(8) = {'rho'};
M_.param_names_long(8) = {'rho'};
M_.param_names(9) = {'omega'};
M_.param_names_tex(9) = {'omega'};
M_.param_names_long(9) = {'omega'};
M_.param_names(10) = {'delta'};
M_.param_names_tex(10) = {'delta'};
M_.param_names_long(10) = {'delta'};
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 4;
M_.endo_nbr = 18;
M_.param_nbr = 10;
M_.orig_endo_nbr = 18;
M_.aux_vars = [];
M_.Sigma_e = zeros(4, 4);
M_.Correlation_matrix = eye(4, 4);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = true;
M_.det_shocks = [];
options_.linear = false;
options_.block = false;
options_.bytecode = false;
options_.use_dll = false;
options_.linear_decomposition = false;
M_.orig_eq_nbr = 18;
M_.eq_nbr = 18;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./+' M_.fname '/set_auxiliary_variables.m'], 'file') == 2;
M_.epilogue_names = {};
M_.epilogue_var_list_ = {};
M_.orig_maximum_endo_lag = 1;
M_.orig_maximum_endo_lead = 1;
M_.orig_maximum_exo_lag = 0;
M_.orig_maximum_exo_lead = 0;
M_.orig_maximum_exo_det_lag = 0;
M_.orig_maximum_exo_det_lead = 0;
M_.orig_maximum_lag = 1;
M_.orig_maximum_lead = 1;
M_.orig_maximum_lag_with_diffs_expanded = 1;
M_.lead_lag_incidence = [
 0 2 0;
 0 3 0;
 0 4 0;
 0 5 0;
 0 6 0;
 0 7 0;
 0 8 0;
 0 9 20;
 0 10 0;
 1 11 0;
 0 12 21;
 0 13 0;
 0 14 0;
 0 15 0;
 0 16 0;
 0 17 0;
 0 18 0;
 0 19 0;]';
M_.nstatic = 15;
M_.nfwrd   = 2;
M_.npred   = 1;
M_.nboth   = 0;
M_.nsfwrd   = 2;
M_.nspred   = 1;
M_.ndynamic   = 3;
M_.dynamic_tmp_nbr = [18; 10; 0; 0; ];
M_.model_local_variables_dynamic_tt_idxs = {
};
M_.equations_tags = {
  1 , 'name' , 'pe' ;
  2 , 'name' , 'ntilde' ;
  3 , 'name' , 'nd' ;
  4 , 'name' , 'nc' ;
  5 , 'name' , 'petilde' ;
  6 , 'name' , 'n' ;
  7 , 'name' , 'y' ;
  8 , 'name' , 'r' ;
  9 , 'name' , '9' ;
  10 , 'name' , 'k' ;
  11 , 'name' , 'c' ;
  12 , 'name' , 'zd' ;
  13 , 'name' , 'zc' ;
  14 , 'name' , 's' ;
  15 , 'name' , 'kcurrent' ;
  16 , 'name' , 'zd2' ;
  17 , 'name' , 'zc2' ;
  18 , 'name' , 'MCn' ;
};
M_.mapping.pe.eqidx = [1 6 9 16 17 ];
M_.mapping.ntilde.eqidx = [2 3 4 5 6 ];
M_.mapping.nd.eqidx = [3 4 12 18 ];
M_.mapping.nc.eqidx = [4 13 18 ];
M_.mapping.petilde.eqidx = [5 6 ];
M_.mapping.n.eqidx = [3 6 7 18 ];
M_.mapping.y.eqidx = [7 10 14 ];
M_.mapping.r.eqidx = [8 11 ];
M_.mapping.e.eqidx = [7 8 9 12 13 16 17 ];
M_.mapping.k.eqidx = [7 8 9 10 12 13 15 ];
M_.mapping.c.eqidx = [10 11 14 ];
M_.mapping.zd.eqidx = [12 ];
M_.mapping.zc.eqidx = [13 ];
M_.mapping.s.eqidx = [14 ];
M_.mapping.kcurrent.eqidx = [15 ];
M_.mapping.zd2.eqidx = [16 ];
M_.mapping.zc2.eqidx = [17 ];
M_.mapping.MCn.eqidx = [18 ];
M_.mapping.pc.eqidx = [1 2 5 13 17 ];
M_.mapping.pd.eqidx = [1 2 5 12 16 ];
M_.mapping.taud.eqidx = [1 2 16 ];
M_.mapping.tauc.eqidx = [1 2 17 ];
M_.static_and_dynamic_models_differ = false;
M_.has_external_function = false;
M_.state_var = [10 ];
M_.exo_names_orig_ord = [1:4];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(18, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(4, 1);
M_.params = NaN(10, 1);
M_.endo_trends = struct('deflator', cell(18, 1), 'log_deflator', cell(18, 1), 'growth_factor', cell(18, 1), 'log_growth_factor', cell(18, 1));
M_.NNZDerivatives = [70; -1; -1; ];
M_.static_tmp_nbr = [13; 2; 0; 0; ];
M_.model_local_variables_static_tt_idxs = {
};
load ('dynare_in')
M_.params(1) = beta_cal;
beta = M_.params(1);
M_.params(2) = gl_cal;
gl = M_.params(2);
M_.params(3) = g_cal;
g = M_.params(3);
M_.params(4) = alpha_cal;
alpha = M_.params(4);
M_.params(5) = nu_cal;
nu = M_.params(5);
M_.params(6) = 1-M_.params(5)-M_.params(4);
gamma = M_.params(6);
M_.params(7) = epsilon_cal;
epsilon = M_.params(7);
M_.params(8) = (M_.params(7)-1)/M_.params(7);
rho = M_.params(8);
M_.params(9) = omega_cal;
omega = M_.params(9);
M_.params(10) = delta_cal;
delta = M_.params(10);
%
% INITVAL instructions
%
options_.initval_file = false;
oo_.exo_steady_state(4) = 1;
oo_.exo_steady_state(3) = 1;
oo_.exo_steady_state(1) = 1;
oo_.exo_steady_state(2) = 1;
oo_.steady_state(1) = (M_.params(9)*(oo_.exo_steady_state(3)*oo_.exo_steady_state(2))^(1-M_.params(7))+(1-M_.params(9))*(oo_.exo_steady_state(4)*oo_.exo_steady_state(1))^(1-M_.params(7)))^(1/(1-M_.params(7)));
oo_.steady_state(2) = (1-M_.params(9))/M_.params(9)*(oo_.exo_steady_state(2)/oo_.exo_steady_state(1))^(M_.params(7)-1)*(oo_.exo_steady_state(3)/oo_.exo_steady_state(4))^M_.params(7);
oo_.steady_state(5) = (M_.params(9)^(1/M_.params(7))*oo_.exo_steady_state(2)^(-M_.params(8))+(1-M_.params(9))^(1/M_.params(7))*oo_.steady_state(2)^M_.params(8)*oo_.exo_steady_state(1)^(-M_.params(8)))^((-1)/M_.params(8));
oo_.steady_state(6) = 1-M_.params(5)*oo_.steady_state(5)/oo_.steady_state(1)*(1+oo_.steady_state(2));
oo_.steady_state(3) = (1-oo_.steady_state(6))/(1+oo_.steady_state(2));
oo_.steady_state(4) = oo_.steady_state(2)*oo_.steady_state(3);
oo_.steady_state(8) = (1+M_.params(3))/M_.params(1)-1;
oo_.steady_state(10) = M_.params(4)^((1-M_.params(5))/M_.params(6))*(oo_.steady_state(8)+M_.params(10))^((M_.params(5)-1)/M_.params(6))*(M_.params(5)/oo_.steady_state(1))^(M_.params(5)/M_.params(6));
oo_.steady_state(9) = (M_.params(5)/oo_.steady_state(1))^(1/(1-M_.params(5)))*oo_.steady_state(10)^(M_.params(4)/(1-M_.params(5)));
oo_.steady_state(7) = oo_.steady_state(6)*oo_.steady_state(10)^M_.params(4)*oo_.steady_state(9)^M_.params(5);
oo_.steady_state(11) = oo_.steady_state(7)-oo_.steady_state(10)*(1+M_.params(3))*(1+M_.params(2))+oo_.steady_state(10)*(1-M_.params(10));
oo_.steady_state(12) = oo_.steady_state(3)*oo_.steady_state(10)^M_.params(4)*oo_.steady_state(9)^M_.params(5)*oo_.exo_steady_state(2)^(-1);
oo_.steady_state(13) = oo_.steady_state(10)^M_.params(4)*oo_.steady_state(9)^M_.params(5)*oo_.steady_state(4)*oo_.exo_steady_state(1)^(-1);
oo_.steady_state(14) = 1-oo_.steady_state(11)/oo_.steady_state(7);
oo_.steady_state(15) = oo_.steady_state(10);
oo_.steady_state(16) = M_.params(9)*oo_.steady_state(9)*(oo_.steady_state(1)/oo_.exo_steady_state(3)/oo_.exo_steady_state(2))^M_.params(7);
oo_.steady_state(17) = (1-M_.params(9))*oo_.steady_state(9)*(oo_.steady_state(1)/oo_.exo_steady_state(4)/oo_.exo_steady_state(1))^M_.params(7);
oo_.steady_state(18) = 1-oo_.steady_state(6)-oo_.steady_state(3)-oo_.steady_state(4);
if M_.exo_nbr > 0
	oo_.exo_simul = ones(M_.maximum_lag,1)*oo_.exo_steady_state';
end
if M_.exo_det_nbr > 0
	oo_.exo_det_simul = ones(M_.maximum_lag,1)*oo_.exo_det_steady_state';
end
steady;
%
% ENDVAL instructions
%
ys0_= oo_.steady_state;
ex0_ = oo_.exo_steady_state;
oo_.exo_steady_state(4) = tauc_end;
oo_.exo_steady_state(3) = taud_end;
oo_.exo_steady_state(1) = 1;
oo_.exo_steady_state(2) = 1;
oo_.steady_state(1) = (M_.params(9)*(oo_.exo_steady_state(3)*oo_.exo_steady_state(2))^(1-M_.params(7))+(1-M_.params(9))*(oo_.exo_steady_state(4)*oo_.exo_steady_state(1))^(1-M_.params(7)))^(1/(1-M_.params(7)));
oo_.steady_state(2) = (1-M_.params(9))/M_.params(9)*(oo_.exo_steady_state(2)/oo_.exo_steady_state(1))^(M_.params(7)-1)*(oo_.exo_steady_state(3)/oo_.exo_steady_state(4))^M_.params(7);
oo_.steady_state(5) = (M_.params(9)^(1/M_.params(7))*oo_.exo_steady_state(2)^(-M_.params(8))+(1-M_.params(9))^(1/M_.params(7))*oo_.steady_state(2)^M_.params(8)*oo_.exo_steady_state(1)^(-M_.params(8)))^((-1)/M_.params(8));
oo_.steady_state(6) = 1-M_.params(5)*oo_.steady_state(5)/oo_.steady_state(1)*(1+oo_.steady_state(2));
oo_.steady_state(3) = (1-oo_.steady_state(6))/(1+oo_.steady_state(2));
oo_.steady_state(4) = oo_.steady_state(2)*oo_.steady_state(3);
oo_.steady_state(8) = (1+M_.params(3))/M_.params(1)-1;
oo_.steady_state(10) = M_.params(4)^((1-M_.params(5))/M_.params(6))*(oo_.steady_state(8)+M_.params(10))^((M_.params(5)-1)/M_.params(6))*(M_.params(5)/oo_.steady_state(1))^(M_.params(5)/M_.params(6));
oo_.steady_state(9) = (M_.params(5)/oo_.steady_state(1))^(1/(1-M_.params(5)))*oo_.steady_state(10)^(M_.params(4)/(1-M_.params(5)));
oo_.steady_state(7) = oo_.steady_state(6)*oo_.steady_state(10)^M_.params(4)*oo_.steady_state(9)^M_.params(5);
oo_.steady_state(11) = oo_.steady_state(7)-oo_.steady_state(10)*(1+M_.params(3))*(1+M_.params(2))+oo_.steady_state(10)*(1-M_.params(10));
oo_.steady_state(12) = oo_.steady_state(3)*oo_.steady_state(10)^M_.params(4)*oo_.steady_state(9)^M_.params(5)*oo_.exo_steady_state(2)^(-1);
oo_.steady_state(13) = oo_.steady_state(10)^M_.params(4)*oo_.steady_state(9)^M_.params(5)*oo_.steady_state(4)*oo_.exo_steady_state(1)^(-1);
oo_.steady_state(14) = 1-oo_.steady_state(11)/oo_.steady_state(7);
oo_.steady_state(15) = oo_.steady_state(10);
oo_.steady_state(16) = M_.params(9)*oo_.steady_state(9)*(oo_.steady_state(1)/oo_.exo_steady_state(3)/oo_.exo_steady_state(2))^M_.params(7);
oo_.steady_state(17) = (1-M_.params(9))*oo_.steady_state(9)*(oo_.steady_state(1)/oo_.exo_steady_state(4)/oo_.exo_steady_state(1))^M_.params(7);
oo_.steady_state(18) = 1-oo_.steady_state(6)-oo_.steady_state(3)-oo_.steady_state(4);
steady;
tauc_shock = tauc_shock(1:401)
%
% SHOCKS instructions
%
M_.det_shocks = [ M_.det_shocks;
struct('exo_det',0,'exo_id',4,'multiplicative',0,'periods',0:400,'value',tauc_shock) ];
M_.exo_det_length = 0;
taud_shock = taud_shock(1:401)
%
% SHOCKS instructions
%
M_.det_shocks = [ M_.det_shocks;
struct('exo_det',0,'exo_id',3,'multiplicative',0,'periods',0:400,'value',taud_shock) ];
M_.exo_det_length = 0;
options_.periods = 400;
perfect_foresight_setup;
options_.simul.maxit = 100;
perfect_foresight_solver;
assert (max(abs(zd-zd2)./zd)<percentage_check, 'zd !=zd2');
assert (max(abs(zc-zc2)./zc)<percentage_check, 'zc !=zc2');
assert (max(MCn)<percentage_check, 'labor market not cleared');
assert (length(n) == (T+2), 'Vector length mismatch')
save('ModelFinal_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('ModelFinal_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('ModelFinal_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('ModelFinal_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('ModelFinal_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('ModelFinal_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('ModelFinal_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
