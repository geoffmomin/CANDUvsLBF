% CANDU UO2 VERSUS LIGHTBRIDGE U-50Zr
% This script evaluates the macroscopic cross section of fission for fuels
% containing uranium, oxygen, and zirconium. Enrichment percent can be
% defined as needed.
% Developed by Geoffrey Momin
% This version does not require Data Table.csv
% ********Updates********
% March 1, 2016 - 0.1 - Release
%               - 0.2 - Prompts added to allow user fuel modification
%               - 0.3 - Automatically solves for UO2, U-50Zr or Custom mix
%               - 0.4 - Solves for power released in the reactor in MW/cm3

% Define the values for the molar masses, avogadro's
% number, and microscopic cross section of fission for U235 neutrons.

M_U235 = 235.043923062;
M_U238 = 238.050782583;
M_O = 15.9994;
M_Zr = 105.93591;
A = 6.022*10^23;
micro_fission = 582.6*10^-24;
neutrons = 143;
flux = 10^14;
fissions_wattsec = 3.12*10^10;

prompt = 'Please enter either UO2, U-50Zr, or Custom: ';
answer = input(prompt); 

if strcmpi(answer,'uo2')
    p_U235 = 0.0072;
    p_Zr = 0;
    n_O = 2;
elseif strcmpi(answer,'u-50zr')
    p_U235 = 0.197;
    p_Zr = 0.5;
    n_O = 0;
else
    prompt = 'Please enter the enrichment percentage: ';
    p_U235 = input(prompt)/100;

    prompt = 'Please enter the Zirconium concentration in %wt: ';
    p_Zr = input(prompt)/100;

    prompt = 'Please enter the number of moles of oxygen present: ';
    n_O = input(prompt);
end

p_U238 = 1 - p_U235 - p_Zr;

if p_Zr > 0
    density = 9.84;
else
    density = 10.96;
end

mole_weight = 1/((p_U235/M_U235)+(p_U238/M_U238));
enrich_density = mole_weight/(mole_weight + (n_O*M_O)+(p_Zr*M_Zr));
N = ((p_U235*density*A)/(M_U235))*enrich_density;
macro_fission = N * micro_fission;
P = macro_fission*flux/fissions_wattsec;
fprintf('The macroscopic cross section of fission of U235 in %s is %f\n', answer, macro_fission);
fprintf('The maximum power output of the %s fuel in MW/cm3 is %f', answer, P);
